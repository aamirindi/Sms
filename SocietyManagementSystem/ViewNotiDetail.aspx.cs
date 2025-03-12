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
    public partial class ViewNotiDetail : Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                LoadNotificationDetails();
            }
        }

        private void LoadNotificationDetails()
        {
            string billId = Request.QueryString["billId"];

            if (string.IsNullOrEmpty(billId))
            {
                Response.Write("<script>alert('Invalid Notification'); window.location='Home.aspx';</script>");
                return;
            }

            string query = $"exec GetBillDetails '{billId}'";
            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblBillTitle.Text = reader["bill_title"].ToString();
                lblAmount.Text = reader["amount"].ToString();
                lblMonth.Text = reader["month"].ToString();
                lblPaidDate.Text = reader["paid_date"].ToString();
                lblPaymentMethod.Text = reader["payment_method"].ToString();
                lblPaidAmount.Text = reader["paid_amount"].ToString();
                lblCreatedAt.Text = Convert.ToDateTime(reader["created_at"]).ToString("yyyy-MM-dd HH:mm:ss");
            }
            else
            {
                Response.Write("<script>alert('No data found'); window.location='Home.aspx';</script>");
            }
        }
    }
}
