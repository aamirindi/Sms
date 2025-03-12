using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace SocietyManagementSystem.Admin
{
    public partial class AdminViewVisitor : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                int visitorId = Convert.ToInt32(Request.QueryString["id"]);
                BindVisitorData(visitorId);
            }
        }

        private void BindVisitorData(int visitorId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("GetVisitorById", con) { CommandType = CommandType.StoredProcedure };
                    cmd.Parameters.AddWithValue("@visitor_id", visitorId);
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblFlatNumber.Text = reader["flat_number"].ToString();
                            lblName.Text = reader["name"].ToString();
                            lblPhone.Text = reader["phone"].ToString();
                            lblAddress.Text = reader["address"].ToString();
                            lblPersonToMeet.Text = reader["person_to_meet"].ToString();
                            lblReason.Text = reader["reason"].ToString();
                            lblInDateTime.Text = reader["in_datetime"].ToString();
                            lblOutRemark.Text = reader["out_remark"].ToString();
                            lblOutDateTime.Text = reader["out_datetime"].ToString();
                            lblStatus.Text = reader["is_in_out"].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }
        }
    }
}
//using System;
//using System.Data;
//using System.Data.SqlClient;
//using System.Web.UI;

//namespace SocietyManagementSystem.Admin
//{
//    public partial class AdminViewVisitor : Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack && Request.QueryString["id"] != null)
//            {
//                int visitorId = Convert.ToInt32(Request.QueryString["id"]);
//                BindVisitorData(visitorId);
//            }
//        }

//        private void BindVisitorData(int visitorId)
//        {
//            try
//            {
//                using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
//                {
//                    SqlCommand cmd = new SqlCommand("GetVisitorById", con) { CommandType = CommandType.StoredProcedure };
//                    cmd.Parameters.AddWithValue("@visitor_id", visitorId);
//                    con.Open();
//                    using (SqlDataReader reader = cmd.ExecuteReader())
//                    {
//                        if (reader.Read())
//                        {
//                            lblFlatNumber.Text = reader["flat_number"].ToString();
//                            lblName.Text = reader["name"].ToString();
//                            lblPhone.Text = reader["phone"].ToString();
//                            lblAddress.Text = reader["address"].ToString();
//                            lblPersonToMeet.Text = reader["person_to_meet"].ToString();
//                            lblReason.Text = reader["reason"].ToString();
//                            lblInDateTime.Text = reader["in_datetime"].ToString();
//                            lblOutRemark.Text = reader["out_remark"].ToString();
//                            lblOutDateTime.Text = reader["out_datetime"].ToString();
//                            lblStatus.Text = reader["is_in_out"].ToString();
//                        }
//                    }
//                }
//            }
//            catch (Exception ex)
//            {
//                lblError.Text = "Error: " + ex.Message;
//            }
//        }
//    }
//}
