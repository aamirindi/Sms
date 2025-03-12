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

    public partial class Complaints : System.Web.UI.Page
    {
        SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["loggedIn"] != null)
                {
                    BindComplaints();

                    btnAdd.Visible = !string.IsNullOrEmpty(Session["loggedIn"].ToString());
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }


        private void BindComplaints()
        {
            if (Session["id"] == null) return;
            int userId = Convert.ToInt32(Session["id"]);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetUserComplaints", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@user_id", userId);
                con.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvComplaints.DataSource = dt;
                gvComplaints.DataBind();
            }
        }


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



        protected void gvComplaints_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                int complaintId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ViewComplaint.aspx?id={complaintId}");
            }
        }
    }
}
