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
    public partial class ViewComplaintadmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["loggedIn"] == null)
                {
                    Response.Redirect("Login.aspx");
                }

                LoadComplaintDetails();
            }
        }

        private void LoadComplaintDetails()
        {
            string complaintId = Request.QueryString["id"];
            if (string.IsNullOrEmpty(complaintId)) return;

            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "GetComplaintById";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", complaintId);

                conn.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    lblUserName.Text = rdr["user_name"].ToString();
                    lblFlatNumber.Text = rdr["flat_number"].ToString();
                    lblComplaintDetails.Text = rdr["complaint_details"].ToString();

                    string status = rdr["status"].ToString().ToLower();
                    lblStatus.Text = status;

                    if (status == "pending")
                        lblStatus.CssClass = "status-pending";
                    else if (status == "resolved")
                        lblStatus.CssClass = "status-resolved";
                    else if (status == "in_progress")
                        lblStatus.CssClass = "status-progress";

                    ddlStatus.SelectedValue = status;
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null) return;

            int complaintId;
            if (!int.TryParse(Request.QueryString["id"], out complaintId)) return;

            string status = ddlStatus.SelectedValue.ToLower();
            string comment = txtMasterComment.Text;

            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(cs))
            {
                string query = "UpdateComplaintStatus";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@complaint_id", complaintId);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@comment", comment);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("ComplaintManagement.aspx");
            Context.ApplicationInstance.CompleteRequest();
        }

    }
}
