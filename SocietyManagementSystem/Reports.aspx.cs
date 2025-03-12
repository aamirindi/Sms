using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SocietyManagementSystem
{
    public partial class Reports : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set default dates
                txtStartDate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            string reportType = ddlReportType.SelectedValue;
            string startDate = txtStartDate.Text;
            string endDate = txtEndDate.Text;

            if (string.IsNullOrEmpty(reportType) || string.IsNullOrEmpty(startDate) || string.IsNullOrEmpty(endDate))
            {
                ShowError("Please select a report type and date range.");
                return;
            }

            DataTable reportData = GetReportData(reportType, startDate, endDate);

            if (reportData.Rows.Count > 0)
            {
                ShowReport(reportData, reportType, startDate, endDate);
            }
            else
            {
                ShowError("No data found for the selected criteria.");
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            string reportType = ddlReportType.SelectedValue;
            string startDate = txtStartDate.Text;
            string endDate = txtEndDate.Text;

            if (string.IsNullOrEmpty(reportType) || string.IsNullOrEmpty(startDate) || string.IsNullOrEmpty(endDate))
            {
                ShowError("Please select a report type and date range.");
                return;
            }

            DataTable reportData = GetReportData(reportType, startDate, endDate);

            if (reportData.Rows.Count > 0)
            {
                ExportToCSV(reportData, $"{reportType}_Report_{startDate}_to_{endDate}.csv");
            }
        }

        private DataTable GetReportData(string reportType, string startDate, string endDate)
        {
            DataTable dataTable = new DataTable();
            string storedProcedure = GetStoredProcedureName(reportType);

            using (SqlConnection connection = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(storedProcedure, connection))
            {
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@start_date", startDate);
                command.Parameters.AddWithValue("@end_date", endDate);

                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(dataTable);
            }

            return dataTable;
        }

        private string GetStoredProcedureName(string reportType)
        {
            switch (reportType)
            {
                case "Bill":
                    return "GetBillReport";
                case "Complaint":
                    return "GetComplaintReport";
                case "Visitor":
                    return "GetVisitorReport";
                default:
                    throw new ArgumentException("Invalid report type.");
            }
        }

        private void ShowReport(DataTable reportData, string reportType, string startDate, string endDate)
        {
            gvReport.DataSource = reportData;
            gvReport.DataBind();
            pnlReportOutput.Visible = true;
            lblReportTitle.InnerText = $"{reportType} Report from {startDate} to {endDate}";
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            lblError.Visible = true;
            pnlReportOutput.Visible = false;
        }

        private void ExportToCSV(DataTable dataTable, string fileName)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", $"attachment;filename={fileName}");
            Response.Charset = "";
            Response.ContentType = "text/csv";

            using (var writer = new System.IO.StringWriter())
            {
                WriteCSV(dataTable, writer);
                Response.Output.Write(writer.ToString());
                Response.Flush();
                Response.End();
            }
        }

        private void WriteCSV(DataTable dataTable, System.IO.StringWriter writer)
        {
            for (int i = 0; i < dataTable.Columns.Count; i++)
            {
                writer.Write(dataTable.Columns[i]);
                if (i < dataTable.Columns.Count - 1)
                {
                    writer.Write(",");
                }
            }
            writer.WriteLine();

            foreach (DataRow row in dataTable.Rows)
            {
                for (int i = 0; i < dataTable.Columns.Count; i++)
                {
                    writer.Write(row[i].ToString());
                    if (i < dataTable.Columns.Count - 1)
                    {
                        writer.Write(",");
                    }
                }
                writer.WriteLine();
            }
        }
    }
}








//using queries
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;

//namespace SocietyManagementSystem
//{
//    public partial class Reports : System.Web.UI.Page
//    {
//        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                // Initialize form
//                txtStartDate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
//                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
//            }
//        }

//        protected void btnGenerateReport_Click(object sender, EventArgs e)
//        {
//            string reportType = ddlReportType.SelectedValue;
//            string startDate = txtStartDate.Text;
//            string endDate = txtEndDate.Text;

//            if (string.IsNullOrEmpty(reportType) || string.IsNullOrEmpty(startDate) || string.IsNullOrEmpty(endDate))
//            {
//                lblError.Text = "Please select a report type and date range.";
//                lblError.Visible = true;
//                return;
//            }

//            DataTable dt = GetReportData(reportType, startDate, endDate);

//            if (dt.Rows.Count > 0)
//            {
//                gvReport.DataSource = dt;
//                gvReport.DataBind();
//                pnlReportOutput.Visible = true;
//                lblReportTitle.InnerText = $"{reportType} Report from {startDate} to {endDate}";
//            }
//            else
//            {
//                lblError.Text = "No data found for the selected criteria.";
//                lblError.Visible = true;
//                pnlReportOutput.Visible = false;
//            }
//        }

//        protected void btnExport_Click(object sender, EventArgs e)
//        {
//            string reportType = ddlReportType.SelectedValue;
//            string startDate = txtStartDate.Text;
//            string endDate = txtEndDate.Text;

//            if (string.IsNullOrEmpty(reportType) || string.IsNullOrEmpty(startDate) || string.IsNullOrEmpty(endDate))
//            {
//                lblError.Text = "Please select a report type and date range.";
//                lblError.Visible = true;
//                return;
//            }

//            DataTable dt = GetReportData(reportType, startDate, endDate);

//            if (dt.Rows.Count > 0)
//            {
//                ExportToCSV(dt, $"{reportType}_Report_{startDate}_to_{endDate}.csv");
//            }
//        }

//        private DataTable GetReportData(string reportType, string startDate, string endDate)
//        {
//            DataTable dt = new DataTable();

//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                string query = "";

//                switch (reportType)
//                {
//                    case "Bill":
//                        query = @"
//                            SELECT b.bill_title, f.block_number, f.flat_number, b.amount, b.month, b.paid_date, b.payment_method, b.paid_amount
//                            FROM bills b
//                            INNER JOIN flats f ON b.flat_id = f.id
//                            WHERE b.created_at BETWEEN @startDate AND @endDate
//                            ORDER BY b.id DESC";
//                        break;

//                    case "Complaint":
//                        query = @"
//                            SELECT u.name AS UserName, f.block_number, f.flat_number, c.description, c.status, c.created_at
//                            FROM complaints c
//                            JOIN users u ON c.user_id = u.id
//                            JOIN flats f ON c.flat_id = f.id
//                            WHERE c.created_at BETWEEN @startDate AND @endDate
//                            ORDER BY c.id DESC";
//                        break;

//                    case "Visitor":
//                        query = @"
//                            SELECT f.block_number, f.flat_number, v.name, v.phone, v.address, v.person_to_meet, v.reason, v.in_datetime, v.out_remark, v.out_datetime, v.is_in_out
//                            FROM visitors v
//                            JOIN flats f ON v.flat_id = f.id
//                            WHERE v.created_at BETWEEN @startDate AND @endDate
//                            ORDER BY v.id DESC";
//                        break;
//                }

//                using (SqlCommand cmd = new SqlCommand(query, con))
//                {
//                    cmd.Parameters.AddWithValue("@startDate", startDate);
//                    cmd.Parameters.AddWithValue("@endDate", endDate);

//                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
//                    sda.Fill(dt);
//                }
//            }

//            return dt;
//        }

//        private void ExportToCSV(DataTable dt, string fileName)
//        {
//            Response.Clear();
//            Response.Buffer = true;
//            Response.AddHeader("content-disposition", $"attachment;filename={fileName}");
//            Response.Charset = "";
//            Response.ContentType = "text/csv";

//            System.IO.StringWriter sw = new System.IO.StringWriter();
//            System.Web.UI.HtmlTextWriter htw = new System.Web.UI.HtmlTextWriter(sw);

//            for (int i = 0; i < dt.Columns.Count; i++)
//            {
//                sw.Write(dt.Columns[i]);
//                if (i < dt.Columns.Count - 1)
//                {
//                    sw.Write(",");
//                }
//            }
//            sw.Write(sw.NewLine);

//            foreach (DataRow row in dt.Rows)
//            {
//                for (int i = 0; i < dt.Columns.Count; i++)
//                {
//                    sw.Write(row[i].ToString());
//                    if (i < dt.Columns.Count - 1)
//                    {
//                        sw.Write(",");
//                    }
//                }
//                sw.Write(sw.NewLine);
//            }

//            Response.Output.Write(sw.ToString());
//            Response.Flush();
//            Response.End();
//        }
//    }
//}