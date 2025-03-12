using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class AddComplaints : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        protected void btnAddComplaint_Click(object sender, EventArgs e)
        {
            string description = txtDescription.Text;
            int userId = Convert.ToInt32(Session["id"]);

            if (string.IsNullOrEmpty(description))
            {
                lblError.Text = "Complaint Description is required.";
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("AddComplaintAndNotify", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@status", "pending");

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                         "alert('Your complaint has been added successfully!'); window.location='Complaints.aspx';", true);
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }
        }


        private int GetFlatId(int userId)
        {
            int flatId = 0;
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("GetFlatIdByUserId", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@user_id", userId);

                con.Open();
                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    flatId = Convert.ToInt32(result);
                }
            }
            return flatId;
        }

    }
}
