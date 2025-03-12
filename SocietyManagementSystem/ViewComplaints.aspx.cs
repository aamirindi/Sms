using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class ViewComplaint : System.Web.UI.Page
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
                conn.Open();

                string query = "GetComplaintById";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", complaintId);
                SqlDataReader rdr = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(rdr);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];

                    lblUserName.Text = row["user_name"].ToString();
                    lblFlatNumber.Text = row["flat_number"].ToString();
                    lblComplaintDetails.Text = row["complaint_details"].ToString();
                    lblStatus.Text = row["status"].ToString();
                    lblStatus.CssClass = lblStatus.Text == "Pending" ? "status-pending" :
                    lblStatus.Text == "Resolved" ? "status-resolved" : "status-progress";

                    rptMasterComments.DataSource = dt;
                    rptMasterComments.DataBind();
                }
            }
        }
    }
}
