using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace SocietyManagementSystem
{
    public partial class ComplaintManagement : System.Web.UI.Page
    {
        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["loggedIn"] != null)
                {
                    BindComplaints();

                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }


        private void BindComplaints()
        {
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                con.Open();
                //SqlCommand cmd = new SqlCommand("GetComplaints", con);
                SqlCommand cmd = new SqlCommand("GetUserComplaints", con);//changed the stored procedure to get the created at 
                cmd.CommandType = CommandType.StoredProcedure;
                // Retrieve userId from session
                int userId = 0;
                if (Session["UserId"] != null)
                {
                    int.TryParse(Session["UserId"].ToString(), out userId);
                }
                // Add the @user_id parameter
                cmd.Parameters.AddWithValue("@user_id", userId); // Ensure userId is defined and has a valid value

                //con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvComplaints.DataSource = dt;
                gvComplaints.DataBind();
            }
        }
        //private void BindComplaints()
        //{
        //    using (SqlConnection conn = new SqlConnection("dbconn"))
        //    {
        //        using (SqlCommand cmd = new SqlCommand("GetUserComplaints", conn))
        //        {
        //            cmd.CommandType = CommandType.StoredProcedure;

        //            // Retrieve userId from session
        //            int userId = 0;
        //            if (Session["UserId"] != null)
        //            {
        //                int.TryParse(Session["UserId"].ToString(), out userId);
        //            }
        //            // Add the @user_id parameter
        //            cmd.Parameters.AddWithValue("@user_id", userId); // Ensure userId is defined and has a valid value

        //            SqlDataAdapter da = new SqlDataAdapter(cmd);
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);
        //            gvComplaints.DataSource = dt;
        //            gvComplaints.DataBind();
        //        }
        //    }
        //}

        protected void gvComplaints_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvComplaints.PageIndex = e.NewPageIndex;
            BindComplaints();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddComplaints.aspx");
        }

        protected void gvComplaints_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int complaintId = Convert.ToInt32(gvComplaints.DataKeys[e.RowIndex].Values["id"]);
            DeleteComplaint(complaintId);
            BindComplaints();
        }

        private void DeleteComplaint(int complaintId)
        {
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteComplaint", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@complaint_id", complaintId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void gvComplaints_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int complaintId = Convert.ToInt32(gvComplaints.DataKeys[e.NewEditIndex].Value);
            Response.Redirect($"EditComplaint.aspx?id={complaintId}");
        }

        protected void gvComplaints_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int complaintId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ViewComplaintadmin.aspx?id={complaintId}");
            }
        }
    }
}
