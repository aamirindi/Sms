using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using iText.Kernel.Pdf;
using iText.Layout;
using iText.Layout.Element;
using System.IO;
using System.Net.Mail;
using System.Net;


namespace SocietyManagementSystem
{
    public partial class BillDetails : Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                int billId;
                if (int.TryParse(Request.QueryString["id"], out billId))
                {
                    LoadBillDetails(billId);
                }
                else
                {
                    Response.Redirect("UserBills.aspx");
                }
            }
        }

        private void LoadBillDetails(int billId)
        {
            string query = $"exec GetBillDetailsById '{billId}'";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblBillTitle.Text = reader["bill_title"].ToString();
                lblAmount.Text = string.Format("{0:C}", reader["amount"]);
                lblMonth.Text = reader["month"].ToString();
                lblPaidDate.Text = reader["paid_date"] != DBNull.Value ? Convert.ToDateTime(reader["paid_date"]).ToString("yyyy-MM-dd") : "Not Paid";
                lblPaymentMethod.Text = reader["payment_method"].ToString();
                lblPaidAmount.Text = reader["paid_amount"] != DBNull.Value ? string.Format("{0:C}", reader["paid_amount"]) : "Not Paid";
                lblCreatedAt.Text = Convert.ToDateTime(reader["created_at"]).ToString("yyyy-MM-dd HH:mm:ss");
            }
            else
            {
                Response.Redirect("UserBills.aspx");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserBills.aspx");
        }

        protected void btnDownloadInvoice_Click(object sender, EventArgs e)
        {
            int billId = Convert.ToInt32(Request.QueryString["id"]);
            GenerateInvoicePDF(billId);
        }

        private void GenerateInvoicePDF(int billId)
        {
            // Set the file name
            string fileName = $"Invoice_{billId}.pdf";
            string filePath = Server.MapPath($"~/Invoices/{fileName}");

            // Create PDF document
            if(File.Exists(filePath))
            {
               
            }
            using (FileStream fs = new FileStream(filePath, FileMode.Create, FileAccess.Write))
            {
                PdfWriter writer = new PdfWriter(fs);
                PdfDocument pdf = new PdfDocument(writer);
                Document document = new Document(pdf);

                // Fetch bill details
                string query = $"exec    '{billId}'";
                SqlCommand cmd = new SqlCommand(query, conn);
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

            Response.ContentType = "application/pdf";
            Response.AppendHeader("Content-Disposition", $"attachment; filename={fileName}");
            Response.TransmitFile(filePath);
            Response.End();
        }
    }
}

//string s = @"
//<style>
//body {
//  font-family: Arial, sans-serif;
//  background-color: #f4f4f4;
//  padding: 20px;
//}

//.invoice {
//  background-color: #fff;
//  border-radius: 8px;
//  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
//  padding: 30px;
//  max-width: 600px;
//  margin: 0 auto;
//}

//.invoice-header {
//  border-bottom: 2px solid #f1f1f1;
//  padding-bottom: 20px;
//  margin-bottom: 20px;
//}

//.invoice-header h1 {
//  font-size: 28px;
//  margin: 0;
//}

//.invoice-info {
//  display: flex;
//  justify-content: space-between;
//  margin-bottom: 10px;
//}

//.invoice-info p {
//  margin: 5px 0;
//}

//.invoice-table {
//  width: 100%;
//  border-collapse: collapse;
//  margin-bottom: 20px;
//}

//.invoice-table th, .invoice-table td {
//  padding: 10px;
//  border-bottom: 1px solid #f1f1f1;
//}

//.invoice-table th {
//  background-color: #f1f1f1;
//}

//.invoice-total {
//  display: flex;
//  justify-content: space-between;
//  font-weight: bold;
//}

//.footer {
//  margin-top: 20px;
//  text-align: center;
//  color: #888;
//}
//</style>
//<body>
//<div class='invoice'>
//<div class='invoice-header'>
//<h1 align='center'>Fees Receipt</h1>
//<div class='invoice-info'>
//<p><strong>Invoice Number:</strong> INV-00" + $"{lblId.Text}" + @"</p>
//<p><strong>Name:</strong> " + $"{lblName.Text}" + @"</p>
//<p><strong>Date:</strong> " + $"{TextBox1.Text}" + @"</p>
//</div>
//<div class='invoice-info'>
//<p><strong>Email ID:</strong>" + $"{lblEmail.Text}" + @"</p>
//<p><strong>Contact No:</strong> " + $"{lblContact.Text}" + @"</p>
//</div>
//</div>
//<table class='invoice-table'>
//<thead>
//<tr>
//<th>Course</th>
//<th>Total Fees</th>
//<th>Paid Fees</th>
//<th>Balance Fees</th>
//</tr>
//</thead>
//<tbody>
//<tr>
//<td>Java Course</td>
//<td>5000</td>
//<td>" + $"{txtPaid.Text}" + @"</td>
//<td>" + $"{lblBal.Text}" + @"</td>
//</tr>
//</tbody>
//</table>
//<div class='invoice-total'>
//<p><strong>Course Fees:</strong></p>
//<p>" + $"{lblBalance.Text}" + @"</p>
//</div>
//<div class='footer'>
//<p>Feel Free to Connect Us!</p>
//</div>
//</div></body>";


//byte[] pdfBytes = GeneratePdfFromHtml(s);

//// Send email with PDF attachment
//SendEmailWithAttachment(pdfBytes);
//        }

//        private byte[] GeneratePdfFromHtml(string htmlContent)
//{
//    using (MemoryStream memoryStream = new MemoryStream())
//    {
//        Document document = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
//        PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
//        document.Open();

//        using (StringReader stringReader = new StringReader(htmlContent))
//        {
//            XMLWorkerHelper.GetInstance().ParseXHtml(writer, document, stringReader);
//        }

//        document.Close();
//        return memoryStream.ToArray();
//    }
//}

//private void SendEmailWithAttachment(byte[] attachmentBytes)
//{
//    MailMessage mailMessage = new MailMessage();
//    mailMessage.From = new MailAddress("khelojikrish@gmail.com");
//    mailMessage.To.Add(lblEmail.Text);
//    mailMessage.Subject = "Fees Receipt";
//    mailMessage.Body = "Please find the Fees Receipt attachment.";
//    mailMessage.IsBodyHtml = true;

//    // Attach PDF
//    MemoryStream stream = new MemoryStream(attachmentBytes);
//    mailMessage.Attachments.Add(new Attachment(stream, "offer_letter.pdf", "application/pdf"));

//    SmtpClient smtpClient = new SmtpClient("smtp.gmail.com", 587);
//    smtpClient.Credentials = new NetworkCredential("khelojikrish@gmail.com", "pcrluqlodjnnhgmj");
//    smtpClient.EnableSsl = true;

//    try
//    {
//        smtpClient.Send(mailMessage);
//        Response.Write("<script>alert('Receipt Send Successfully');</script>");
//        ClearDetails();

//    }
//    catch (Exception ex)
//    {
//        // Handle exception
//        throw ex;
//    }
//    finally
//    {
//        // Clean up resources
//        stream.Dispose();
//        mailMessage.Dispose();
//        smtpClient.Dispose();
//    }
//}