using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace SocietyManagementSystem
{
    public partial class ViewBillAdmin : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int billId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadBillDetails(billId);
                }
            }
        }

        private void LoadBillDetails(int billId)
        {
            string query = $"exec LoadBill '{billId}'";
            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                lblBillTitle.Text = "Bill Title: " + reader["bill_title"].ToString();
                lblAmount.Text = "Amount: $" + Convert.ToDecimal(reader["amount"]).ToString("F2");
                lblMonth.Text = "Month: " + reader["month"].ToString();
                lblPaidDate.Text = "Paid Date: " + (reader["paid_date"] != DBNull.Value ? Convert.ToDateTime(reader["paid_date"]).ToString("yyyy-MM-dd") : "Not Paid");
                lblPaymentMethod.Text = "Payment Method: " + reader["payment_method"].ToString();
                lblPaidAmount.Text = "Paid Amount: $" + (reader["paid_amount"] != DBNull.Value ? Convert.ToDecimal(reader["paid_amount"]).ToString("F2") : "0.00");
                lblCreatedAt.Text = "Created At: " + Convert.ToDateTime(reader["created_at"]).ToString("yyyy-MM-dd HH:mm:ss");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("BillManagementAdmin.aspx");
        }
    }
}
