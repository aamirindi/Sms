using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                LoadDashboardCounts();
            }
        }

        private void LoadDashboardCounts()
        {
            int userId = Convert.ToInt32(Session["id"]);
            if (userId == 0)
            {
                Response.Redirect("Login.aspx");
            }

            string q = $"exec GetUserDashboardCounts '{userId}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblBillsCount.Text = reader["BillsCount"].ToString();
                lblComplaintsCount.Text = reader["ComplaintsCount"].ToString();
                lblVisitorsCount.Text = reader["VisitorsCount"].ToString();
            }

        }
    }
}