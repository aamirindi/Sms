using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SocietyManagementSystem
{
    public partial class Dashboard : Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["user_id"] != null && Session["user_role"] != null)
                {
                    if (Session["user_role"].ToString() == "admin")
                    {
                        BindAdminDashboard();
                    }
                    else if (Session["user_role"].ToString() == "user")
                    {
                        BindUserDashboard();
                    }
                }
                else
                {
                    Response.Write("<script>alert('Something Went Wrong')</script>");
                }
            }
        }

        private void BindAdminDashboard()
        {
            pnlAdmin.Visible = true;
            lblTotalFlats.Text = GetTotalCount("flats").ToString();
            lblTotalBills.Text = GetTotalCount("bills").ToString();
            lblTotalAllotments.Text = GetTotalCount("allotments").ToString();
            lblTotalVisitors.Text = GetTotalCount("visitors").ToString();
            lblTotalInProgressComplaints.Text = GetComplaintCount("in_progress").ToString();
            lblTotalUnresolvedComplaints.Text = GetComplaintCount("unresolved").ToString();
            lblTotalResolvedComplaints.Text = GetComplaintCount("resolved").ToString();
            lblTotalComplaints.Text = GetTotalCount("complaints").ToString();
        }

        private void BindUserDashboard()
        {
            pnlUser.Visible = true;
            string flatId = GetFlatIdForUser(Convert.ToInt32(Session["user_id"]));
            if (!string.IsNullOrEmpty(flatId))
            {
                lblUserTotalInProgressComplaints.Text = GetComplaintCount("in_progress", flatId).ToString();
                lblUserTotalUnresolvedComplaints.Text = GetComplaintCount("unresolved", flatId).ToString();
                lblUserTotalResolvedComplaints.Text = GetComplaintCount("resolved", flatId).ToString();
                lblUserTotalComplaints.Text = GetTotalComplaintCountForUser(flatId).ToString();
                lblUserTotalBills.Text = GetTotalBillsForUser(flatId).ToString();
                lblUserTotalVisitors.Text = GetTotalVisitorsForUser(flatId).ToString();
            }
            else
            {
                Response.Write("<script>alert('Flat ID not found for the user.')</script>");
            }
        }

        private int GetTotalCount(string tableName)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetTotalCount", con) { CommandType = CommandType.StoredProcedure };
                cmd.Parameters.AddWithValue("@tableName", tableName);
                con.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private int GetComplaintCount(string status, string flatId = null)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetComplaintCount", con) { CommandType = CommandType.StoredProcedure };
                cmd.Parameters.AddWithValue("@status", status);
                if (!string.IsNullOrEmpty(flatId))
                {
                    cmd.Parameters.AddWithValue("@flatId", Convert.ToInt32(flatId));
                }
                con.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private string GetFlatIdForUser(int userId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetFlatIdForUser", con) { CommandType = CommandType.StoredProcedure };
                cmd.Parameters.AddWithValue("@userId", userId);
                con.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? result.ToString() : null;
            }
        }

        private int GetTotalComplaintCountForUser(string flatId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetTotalComplaintCountForUser", con) { CommandType = CommandType.StoredProcedure };
                cmd.Parameters.AddWithValue("@flatId", Convert.ToInt32(flatId));
                con.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private int GetTotalBillsForUser(string flatId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetTotalBillsForUser", con) { CommandType = CommandType.StoredProcedure };
                cmd.Parameters.AddWithValue("@flatId", Convert.ToInt32(flatId));
                con.Open();
                return (int)cmd.ExecuteScalar();
            }
        }

        private int GetTotalVisitorsForUser(string flatId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetTotalVisitorsForUser", con) { CommandType = CommandType.StoredProcedure };
                cmd.Parameters.AddWithValue("@flatId", Convert.ToInt32(flatId));
                con.Open();
                return (int)cmd.ExecuteScalar();
            }
        }
    }
}

//using System;
//using System.Data;
//using System.Data.SqlClient;

//namespace SocietyManagementSystem
//{
//    public partial class Dashboard : System.Web.UI.Page
//    {
//        private string connectionString = "dbconn";

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                if (Session["user_id"] != null && Session["user_role"].ToString() == "admin")
//                {
//                    BindAdminDashboard();
//                }
//                else if (Session["user_id"] != null && Session["user_role"].ToString() == "user")
//                {
//                    BindUserDashboard();
//                }
//                else
//                {
//                    //Response.Redirect("logout.aspx");
//                    Response.Write("<script>alert('Something Went Wrong')</script>");

//                }
//            }
//        }

//        private void BindAdminDashboard()
//        {
//            pnlAdmin.Visible = true;
//            lblTotalFlats.Text = GetTotalCount("flats").ToString();
//            lblTotalBills.Text = GetTotalCount("bills").ToString();
//            lblTotalAllotments.Text = GetTotalCount("allotments").ToString();
//            lblTotalVisitors.Text = GetTotalCount("visitors").ToString();
//            lblTotalInProgressComplaints.Text = GetComplaintCount("in_progress").ToString();
//            lblTotalUnresolvedComplaints.Text = GetComplaintCount("unresolved").ToString();
//            lblTotalResolvedComplaints.Text = GetComplaintCount("resolved").ToString();
//            lblTotalComplaints.Text = GetTotalCount("complaints").ToString();
//        }

//        private void BindUserDashboard()
//        {
//            pnlUser.Visible = true;
//            string flatId = GetFlatIdForUser(Convert.ToInt32(Session["user_id"]));
//            lblUserTotalInProgressComplaints.Text = GetComplaintCount("in_progress", flatId).ToString();
//            lblUserTotalUnresolvedComplaints.Text = GetComplaintCount("unresolved", flatId).ToString();
//            lblUserTotalResolvedComplaints.Text = GetComplaintCount("resolved", flatId).ToString();
//            lblUserTotalComplaints.Text = GetTotalComplaintCountForUser(flatId).ToString();
//            lblUserTotalBills.Text = GetTotalBillsForUser(flatId).ToString();
//            lblUserTotalVisitors.Text = GetTotalVisitorsForUser(flatId).ToString();
//        }

//        private int GetTotalCount(string tableName)
//        {
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand($"SELECT COUNT(*) FROM {tableName}", con);
//                con.Open();
//                return (int)cmd.ExecuteScalar();
//            }
//        }

//        private int GetComplaintCount(string status, string flatId = null)
//        {
//            string query = $"SELECT COUNT(*) FROM complaints WHERE status = @status";
//            if (!string.IsNullOrEmpty(flatId))
//            {
//                query += " AND flat_id = @flatId";
//            }

//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand(query, con);
//                cmd.Parameters.AddWithValue("@status", status);
//                if (!string.IsNullOrEmpty(flatId))
//                {
//                    cmd.Parameters.AddWithValue("@flatId", flatId);
//                }
//                con.Open();
//                return (int)cmd.ExecuteScalar();
//            }
//        }

//        private string GetFlatIdForUser(int userId)
//        {
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand("SELECT flat_id FROM allotments WHERE user_id = @userId", con);
//                cmd.Parameters.AddWithValue("@userId", userId);
//                con.Open();
//                return cmd.ExecuteScalar()?.ToString();
//            }
//        }

//        private int GetTotalComplaintCountForUser(string flatId)
//        {
//            string query = "SELECT COUNT(*) FROM complaints WHERE flat_id = @flatId";
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand(query, con);
//                cmd.Parameters.AddWithValue("@flatId", flatId);
//                con.Open();
//                return (int)cmd.ExecuteScalar();
//            }
//        }

//        private int GetTotalBillsForUser(string flatId)
//        {
//            string query = "SELECT COUNT(*) FROM bills WHERE flat_id = @flatId";
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand(query, con);
//                cmd.Parameters.AddWithValue("@flatId", flatId);
//                con.Open();
//                return (int)cmd.ExecuteScalar();
//            }
//        }

//        private int GetTotalVisitorsForUser(string flatId)
//        {
//            string query = "SELECT COUNT(*) FROM visitors WHERE flat_id = @flatId";
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand(query, con);
//                cmd.Parameters.AddWithValue("@flatId", flatId);
//                con.Open();
//                return (int)cmd.ExecuteScalar();
//            }
//        }
//    }
//}
