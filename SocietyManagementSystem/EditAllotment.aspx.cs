using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SocietyManagementSystem
{
    public partial class EditAllotment : System.Web.UI.Page
    {
        //private string connectionString = "dbconn";
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindUsers();
                BindFlats();
                if (Request.QueryString["id"] != null)
                {
                    int allotmentId = Convert.ToInt32(Request.QueryString["id"]);
                    BindAllotmentDetails(allotmentId);
                }
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

        private void BindAllotmentDetails(int allotmentId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Allotments WHERE id = @id", con);
                cmd.Parameters.AddWithValue("@id", allotmentId);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    ddlUsers.SelectedValue = row["user_id"].ToString();
                    ddlFlats.SelectedValue = row["flat_id"].ToString();
                    txtMoveInDate.Text = row["move_in_date"].ToString();
                    txtMoveOutDate.Text = row["move_out_date"].ToString();
                    hdnAllotmentId.Value = allotmentId.ToString();
                }
            }
        }

        protected void btnEditAllotment_Click(object sender, EventArgs e)
        {
            string user_id = ddlUsers.SelectedValue;
            string flat_id = ddlFlats.SelectedValue;
            string move_in_date = txtMoveInDate.Text;
            string move_out_date = txtMoveOutDate.Text;
            int allotmentId = Convert.ToInt32(hdnAllotmentId.Value);

            if (string.IsNullOrEmpty(user_id) || string.IsNullOrEmpty(flat_id) || string.IsNullOrEmpty(move_in_date))
            {
                lblError.Visible = true;
                lblError.Text = "All fields are required";
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateAllotment", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@allotment_id", allotmentId);
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
