using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class Allotments : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAllotments();
            }
        }

        private void BindAllotments(string searchTerm = null)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("GetAllAllotments", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        cmd.Parameters.AddWithValue("@searchTerm", searchTerm);
                    }

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    gvAllotments.DataSource = dt;
                    gvAllotments.DataBind();
                }
            }
        }

        protected void gvAllotments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                int allotmentId = Convert.ToInt32(e.CommandArgument);
                DeleteAllotment(allotmentId);
                BindAllotments();
                ShowMessage("Allotment deleted successfully.");
            }
            else if (e.CommandName == "Edit")
            {
                int allotmentId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"EditAllotment.aspx?id={allotmentId}");
            }
        }

        protected void gvAllotments_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Get the ID of the allotment to be deleted
                int allotmentId = Convert.ToInt32(gvAllotments.DataKeys[e.RowIndex].Value);

                // Call the method to delete the allotment
                DeleteAllotment(allotmentId);

                // Rebind the GridView to reflect the changes
                BindAllotments();

                // Show success message
                ShowMessage("Allotment deleted successfully.");
            }
            catch (Exception ex)
            {
                // Handle any errors that occur during deletion
                ShowMessage("An error occurred while deleting the allotment: " + ex.Message);
            }
        }

        protected void gvAllotments_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAllotments.PageIndex = e.NewPageIndex;
            BindAllotments();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            BindAllotments(searchTerm);
        }

        private void DeleteAllotment(int allotmentId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("DeleteAllotment", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@allotment_id", allotmentId);
                    cmd.Parameters.AddWithValue("@action_by", 1); // Replace with logged-in user ID
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void ShowMessage(string message)
        {
            lblSuccess.Visible = true;
            lblSuccess.Text = message;
        }
    }
}


//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data.SqlClient;
//using System.Data;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace SocietyManagementSystem
//{
//    public partial class Allotments : System.Web.UI.Page
//    {
//        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                BindAllotments();
//            }
//        }

//        private void BindAllotments(string sortExpression = null, string searchTerm = null)
//        {
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand("GetAllAllotments", con);
//                cmd.CommandType = CommandType.StoredProcedure;
//                if (!string.IsNullOrEmpty(searchTerm))
//                {
//                    cmd.Parameters.AddWithValue("@searchTerm", searchTerm);
//                }
//                SqlDataAdapter sda = new SqlDataAdapter(cmd);
//                DataTable dt = new DataTable();
//                sda.Fill(dt);

//                if (!string.IsNullOrEmpty(sortExpression))
//                {
//                    dt.DefaultView.Sort = sortExpression;
//                    dt = dt.DefaultView.ToTable();
//                }

//                gvAllotments.DataSource = dt;
//                gvAllotments.DataBind();
//            }
//        }

//        protected void gvAllotments_RowCommand(object sender, GridViewCommandEventArgs e)
//        {
//            if (e.CommandName == "Delete")
//            {
//                int allotmentId = Convert.ToInt32(e.CommandArgument);
//                DeleteAllotment(allotmentId);
//                BindAllotments();
//                lblSuccess.Visible = true;
//                lblSuccess.Text = "Allotment Data has been removed";
//            }
//            else if (e.CommandName == "Edit")
//            {
//                int allotmentId = Convert.ToInt32(e.CommandArgument);
//                Response.Redirect($"EditAllotment.aspx?id={allotmentId}");
//            }
//        }

//        protected void gvAllotments_RowDeleting(object sender, GridViewDeleteEventArgs e)
//        {
//            int allotmentId = Convert.ToInt32(gvAllotments.DataKeys[e.RowIndex].Value);
//            DeleteAllotment(allotmentId);
//            BindAllotments();
//            lblSuccess.Visible = true;
//            lblSuccess.Text = "Allotment Data has been removed";
//        }

//        protected void gvAllotments_PageIndexChanging(object sender, GridViewPageEventArgs e)
//        {
//            gvAllotments.PageIndex = e.NewPageIndex;
//            BindAllotments();
//        }

//        protected void gvAllotments_Sorting(object sender, GridViewSortEventArgs e)
//        {
//            string sortExpression = e.SortExpression;
//            string sortDirection = string.Empty;

//            if (ViewState["SortDirection"] != null && (string)ViewState["SortDirection"] == "ASC")
//            {
//                sortDirection = "DESC";
//            }
//            else
//            {
//                sortDirection = "ASC";
//            }

//            ViewState["SortDirection"] = sortDirection;
//            BindAllotments($"{sortExpression} {sortDirection}");
//        }

//        protected void btnSearch_Click(object sender, EventArgs e)
//        {
//            string searchTerm = txtSearch.Text.Trim();
//            BindAllotments(searchTerm: searchTerm);
//        }

//        private void DeleteAllotment(int allotmentId)
//        {
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand("DeleteAllotment", con);
//                cmd.CommandType = CommandType.StoredProcedure;
//                cmd.Parameters.AddWithValue("@allotment_id", allotmentId);
//                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
//                con.Open();
//                cmd.ExecuteNonQuery();
//            }
//        }
//    }
//}
//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data.SqlClient;
//using System.Data;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;


//namespace SocietyManagementSystem
//{
//    public partial class Allotments : System.Web.UI.Page
//    {
//        //private string connectionString = "dbconn";
//        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                BindAllotments();
//            }
//        }

//        private void BindAllotments()
//        {
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand("GetAllAllotments", con);
//                cmd.CommandType = CommandType.StoredProcedure;
//                SqlDataAdapter sda = new SqlDataAdapter(cmd);
//                DataTable dt = new DataTable();
//                sda.Fill(dt);
//                gvAllotments.DataSource = dt;
//                gvAllotments.DataBind();
//            }
//        }

//        protected void gvAllotments_RowCommand(object sender, GridViewCommandEventArgs e)
//        {
//            if (e.CommandName == "Delete")
//            {
//                int allotmentId = Convert.ToInt32(e.CommandArgument);
//                DeleteAllotment(allotmentId);
//                BindAllotments();
//                lblSuccess.Visible = true;
//                lblSuccess.Text = "Allotment Data has been removed";
//            }
//            else if (e.CommandName == "Edit")
//            {
//                int allotmentId = Convert.ToInt32(e.CommandArgument);
//                Response.Redirect($"EditAllotment.aspx?id={allotmentId}");
//            }
//        }

//        protected void gvAllotments_RowDeleting(object sender, GridViewDeleteEventArgs e)
//        {
//            int allotmentId = Convert.ToInt32(gvAllotments.DataKeys[e.RowIndex].Value);
//            DeleteAllotment(allotmentId);
//            BindAllotments();
//            lblSuccess.Visible = true;
//            lblSuccess.Text = "Allotment Data has been removed";
//        }

//        private void DeleteAllotment(int allotmentId)
//        {
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand("DeleteAllotment", con);
//                cmd.CommandType = CommandType.StoredProcedure;
//                cmd.Parameters.AddWithValue("@allotment_id", allotmentId);
//                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
//                con.Open();
//                cmd.ExecuteNonQuery();
//            }
//        }
//    }
//}
