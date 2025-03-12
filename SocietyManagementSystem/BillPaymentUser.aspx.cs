using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using Razorpay.Api;
using System.Net.Mail;
using System.Net;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using System.IO;

namespace SocietyManagementSystem
{
    public partial class BillPaymentUser : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                if (Request.QueryString["billId"] != null)
                {
                    LoadBillDetails();
                }
                else
                {
                    lblBillTitle.Text = "No bill selected.";
                }
            }
        }

        private void LoadBillDetails()
        {
            int billId = Convert.ToInt32(Request.QueryString["billId"]);
            int userId = Convert.ToInt32(Session["id"]);

            string query = $"exec GetBillDetailsForUser '{billId}', '{userId}'";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblFlatNumber.Text = reader["flat_details"].ToString();
                lblBillTitle.Text = reader["bill_title"].ToString();
                lblBillMonth.Text = reader["month"].ToString();
                lblBillAmount.Text = reader["amount"].ToString();
            }
            else
            {
                lblFlatNumber.Text = "N/A";
                lblBillTitle.Text = "No bill found";
                lblBillMonth.Text = "-";
                lblBillAmount.Text = "0.00";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int billId = Convert.ToInt32(Request.QueryString["billId"]);
            string paymentMethod = ddlPaymentMethod.SelectedValue;
            decimal paidAmount = Convert.ToDecimal(txtPaidAmount.Text);
            string paymentDate = txtPaymentDate.Text;

            if (paymentMethod == "Cash")
            {
                // Fetching bill amount
                string selectQuery = $"exec GetBillAmount '{billId}'";
                decimal billAmount = 0;
                SqlCommand selectCmd = new SqlCommand(selectQuery, conn);
                object result = selectCmd.ExecuteScalar();

                if (result != null)
                {
                    billAmount = Convert.ToDecimal(result);
                }

                if (paidAmount == billAmount)
                {
                    // Updating Bills table
                    string updateQuery = $"exec UpdateBillPayment '{billId}','{paymentDate}','{paidAmount}','{paymentMethod}'";
                    SqlCommand cmd = new SqlCommand(updateQuery, conn);
                    cmd.ExecuteNonQuery();

                    // Updating Notification table link
                    string updateNotificationQuery = $"exec UpdateNotificationLinkAfterPayment '{billId}'";
                    SqlCommand notiCmd = new SqlCommand(updateNotificationQuery, conn);
                    notiCmd.ExecuteNonQuery();

                    Response.Write("<script>alert('Payment done successfully!')</script>");

                    // Sending invoice through email
                    string userEmail = Session["loggedIn"].ToString();
                    MailMessage userMail = new MailMessage();
                    userMail.From = new MailAddress("aamirindi@gmail.com");
                    userMail.To.Add(userEmail);
                    userMail.Subject = $"Invoice for Bill Id : {billId}";

                    // Generate the PDF and get the file path
                    string pdfPath = GenerateInvoicePDFForEmail(billId);
                    userMail.Attachments.Add(new Attachment(pdfPath));

                    userMail.Body = $"Payment has been completed successfully!<br/><br/>Please find the attached invoice for your records.";
                    userMail.IsBodyHtml = true;

                    SmtpClient smtp = new SmtpClient("smtp.gmail.com");
                    smtp.Credentials = new NetworkCredential("aamirindi@gmail.com", "elklfufuoqcicyty");
                    smtp.Port = 587;
                    smtp.EnableSsl = true;
                    smtp.Send(userMail);

                    Response.Write("<script>alert('Payment completed and invoice sent successfully!')</script>");
                    Response.Redirect("UserBills.aspx");
                }
                else if (paidAmount < billAmount)
                {
                    Response.Write("<script>alert('Insufficient amount! Please pay the full amount.')</script>");
                }
                else
                {
                    Response.Write("<script>alert('Overpayment detected! Please enter the correct amount.')</script>");
                }
            }
            else
            {
                string keyId = "rzp_test_Kl7588Yie2yJTV";
                string keySecret = "6dN9Nqs7M6HPFMlL45AhaTgp";

                RazorpayClient razorpayClient = new RazorpayClient(keyId, keySecret);
                decimal amount = Convert.ToDecimal(txtPaidAmount.Text);

                // Create an order
                Dictionary<string, object> options = new Dictionary<string, object>();
                options.Add("amount", amount * 100); // Amount should be in paisa
                options.Add("currency", "INR");
                options.Add("receipt", "order_receipt_" + billId);
                options.Add("payment_capture", 1); // Auto capture payment

                Razorpay.Api.Order order = razorpayClient.Order.Create(options);
                string orderId = order["id"].ToString();

                string razorpayScript = $@"
    console.log('Razorpay script injected');
    var options = {{
        'key': '{keyId}',
        'amount': {amount * 100},
        'currency': 'INR',
        'name': 'Masstech Business Solutions Pvt.Ltd',
        'description': 'Checkout Payment',
        'order_id': '{orderId}',
        'handler': function(response) {{
            console.log('Payment successful: ', response);
            fetch('UpdatePaymentStatus.aspx?billId={billId}&paidAmount={amount}&paymentMethod=Online&paymentId=' + response.razorpay_payment_id, {{
                method: 'GET'
            }})
            .then(res => res.text())
            .then(data => {{
                alert('Payment successful! Payment ID: ' + response.razorpay_payment_id);
                window.location.href='UserBills.aspx';
            }})
            .catch(error => console.error('Error:', error));
        }},
        'prefill': {{
            'name': 'Krish Kheloji',
            'email': 'khelojikrish@gmail.com',
            'contact': '7208921898'
        }},
        'theme': {{
            'color': '#F37254'
        }}
    }};
    console.log('Opening Razorpay modal');
    var rzp1 = new Razorpay(options);
    rzp1.open();
";
                ClientScript.RegisterStartupScript(this.GetType(), "razorpayScript", razorpayScript, true);
            }
        }

        private string GenerateInvoicePDFForEmail(int billId)
        {
            // Set the file name
            string fileName = $"Invoice_{billId}.pdf";
            string filePath = Server.MapPath($"~/Invoices/{fileName}");

            // Create PDF document
            using (FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.Write))
            {
                PdfWriter writer = new PdfWriter(fs);
                PdfDocument pdf = new PdfDocument(writer);
                Document document = new Document(pdf);

                // Fetch bill details
                string query = $"exec FetchBillById @BillId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@BillId", billId);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Adding invoice details
                    document.Add(new Paragraph("SOCIETY MANAGEMENT SYSTEM")
                        .SetFont(iText.Kernel.Font.PdfFontFactory.CreateFont(iText.IO.Font.Constants.StandardFonts.HELVETICA_BOLD))
                        .SetFontSize(18));

                    document.Add(new Paragraph("Bill Invoice")
                        .SetFont(iText.Kernel.Font.PdfFontFactory.CreateFont(iText.IO.Font.Constants.StandardFonts.HELVETICA_BOLD))
                        .SetFontSize(14)
                        .SetUnderline());

                    document.Add(new Paragraph($"Bill ID: {billId}"));
                    document.Add(new Paragraph($"Flat Number: {reader["flat_id"]}"));
                    document.Add(new Paragraph($"Bill Title: {reader["bill_title"]}"));
                    document.Add(new Paragraph($"Amount: ₹ {reader["amount"]}"));
                    document.Add(new Paragraph($"Month: {reader["month"]}"));
                    document.Add(new Paragraph($"Paid Date: {reader["paid_date"]}"));
                    document.Add(new Paragraph($"Payment Method: {reader["payment_method"]}"));
                    document.Add(new Paragraph($"Paid Amount: ₹ {reader["paid_amount"]}"));
                    document.Add(new Paragraph($"Created At: {reader["created_at"]}"));

                    document.Add(new Paragraph("\nThank you for your payment!")
                        .SetFont(iText.Kernel.Font.PdfFontFactory.CreateFont(iText.IO.Font.Constants.StandardFonts.HELVETICA_OBLIQUE))
                        .SetFontSize(12));
                }

                reader.Close();
                document.Close();
            }

            return filePath;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserBills.aspx");
        }
    }
}
