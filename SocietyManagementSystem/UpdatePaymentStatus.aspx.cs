using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;
using System.IO;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;


namespace SocietyManagementSystem
{
    public partial class UpdatePaymentStatus : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            int billId = Convert.ToInt32(Request.QueryString["billId"]);
            decimal paidAmount = Convert.ToDecimal(Request.QueryString["paidAmount"]);
            string paymentMethod = Request.QueryString["paymentMethod"];
            string paymentDate = DateTime.Now.ToString("yyyy-MM-dd");

            // Fetching bill amount
            string selectQuery = $"exec FetchingAmount '{billId}'";
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
                string updateQuery = $"exec UpdatingBillPayment '{paymentDate}','{paidAmount}','{paymentMethod}','{billId}'";

                SqlCommand cmd = new SqlCommand(updateQuery, conn);
                cmd.ExecuteNonQuery();

                // Updating Notification table link
                string updateNotificationQuery = $"exec UpdatingNotiAfterPayment '{billId}'";

                SqlCommand notiCmd = new SqlCommand(updateNotificationQuery, conn);
                notiCmd.ExecuteNonQuery();

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
            else
            {
                Response.Write("Error: Amount mismatch");
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
    }
}
