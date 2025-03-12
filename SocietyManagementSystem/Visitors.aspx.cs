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
    public partial class Visitors : System.Web.UI.Page
    {
        //private string connectionString = "dbconn";
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindVisitors();
            }
        }

        private void BindVisitors()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetVisitorReport", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@start_date", DBNull.Value);
                cmd.Parameters.AddWithValue("@end_date", DBNull.Value);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvVisitors.DataSource = dt;
                gvVisitors.DataBind();
            }
        }

        protected void gvVisitors_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int visitorId = Convert.ToInt32(e.CommandArgument);
                DeleteVisitor(visitorId);
                BindVisitors();
                lblSuccess.Visible = true;
                lblSuccess.Text = "Visitor Data has been removed";
            }
            else if (e.CommandName == "Edit")
            {
                int visitorId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"EditVisitor.aspx?id={visitorId}");
            }
            else if (e.CommandName == "View")
            {
                int visitorId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ViewVisitor.aspx?id={visitorId}");
            }
        }

        private void DeleteVisitor(int visitorId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("DeleteVisitor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@visitor_id", visitorId);
                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
