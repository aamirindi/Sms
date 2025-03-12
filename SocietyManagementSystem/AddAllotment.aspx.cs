using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SocietyManagementSystem
{
    public partial class AddAllotment : System.Web.UI.Page
    {
        //private string connectionString = "dbconn";
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUsers();
                BindFlats();
            }
        }

        private void BindUsers()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetUsersForDropdown", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlUsers.DataSource = dt;
                ddlUsers.DataTextField = "name";
                ddlUsers.DataValueField = "id";
                ddlUsers.DataBind();
            }
        }

        private void BindFlats()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("GetFlatsForDropdown", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                ddlFlats.DataSource = dt;
                ddlFlats.DataTextField = "flat_number";
                ddlFlats.DataValueField = "id";
                ddlFlats.DataBind();
            }
        }

        protected void btnAddAllotment_Click(object sender, EventArgs e)
        {
            string user_id = ddlUsers.SelectedValue;
            string flat_id = ddlFlats.SelectedValue;
            string move_in_date = txtMoveInDate.Text;
            string move_out_date = txtMoveOutDate.Text;

            if (string.IsNullOrEmpty(user_id) || string.IsNullOrEmpty(flat_id) || string.IsNullOrEmpty(move_in_date))
            {
                lblError.Visible = true;
                lblError.Text = "All fields are required";
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("AddAllotment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@user_id", user_id);
                cmd.Parameters.AddWithValue("@flat_id", flat_id);
                cmd.Parameters.AddWithValue("@move_in_date", move_in_date);
                cmd.Parameters.AddWithValue("@move_out_date", move_out_date ?? (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("Allotments.aspx");
        }
    }
}
