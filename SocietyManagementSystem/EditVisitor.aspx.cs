using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace SocietyManagementSystem
{
    public partial class EditVisitor : System.Web.UI.Page
    {
        //private string connectionString = "dbconn";
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFlats();
                if (Request.QueryString["id"] != null)
                {
                    int visitorId = Convert.ToInt32(Request.QueryString["id"]);
                    BindVisitorDetails(visitorId);
                }
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

        private void BindVisitorDetails(int visitorId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT * FROM Visitors WHERE id = @id AND out_datetime IS NULL", con);
                cmd.Parameters.AddWithValue("@id", visitorId);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    ddlFlats.SelectedValue = row["flat_id"].ToString();
                    txtName.Text = row["name"].ToString();
                    txtPhone.Text = row["phone"].ToString();
                    txtAddress.Text = row["address"].ToString();
                    txtPersonToMeet.Text = row["person_to_meet"].ToString();
                    txtReason.Text = row["reason"].ToString();
                    txtInDateTime.Text = row["in_datetime"].ToString();
                    hdnVisitorId.Value = visitorId.ToString();
                }
            }
        }

        protected void btnEditVisitor_Click(object sender, EventArgs e)
        {
            string flat_id = ddlFlats.SelectedValue;
            string name = txtName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();
            string person_to_meet = txtPersonToMeet.Text.Trim();
            string reason = txtReason.Text.Trim();
            string in_datetime = txtInDateTime.Text.Trim();
            int visitorId = Convert.ToInt32(hdnVisitorId.Value);

            if (string.IsNullOrEmpty(flat_id) || string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) ||
                string.IsNullOrEmpty(address) || string.IsNullOrEmpty(person_to_meet) ||
                string.IsNullOrEmpty(reason) || string.IsNullOrEmpty(in_datetime))
            {
                lblError.Visible = true;
                lblError.Text = "All fields are required";
                return;
            }

            if (!Regex.IsMatch(phone, @"^\d{10}$"))
            {
                lblError.Visible = true;
                lblError.Text = "Phone number is invalid";
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateVisitor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@visitor_id", visitorId);
                cmd.Parameters.AddWithValue("@flat_id", flat_id);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.Parameters.AddWithValue("@address", address);
                cmd.Parameters.AddWithValue("@person_to_meet", person_to_meet);
                cmd.Parameters.AddWithValue("@reason", reason);
                cmd.Parameters.AddWithValue("@in_datetime", in_datetime);
                cmd.Parameters.AddWithValue("@is_in_out", "in");
                cmd.Parameters.AddWithValue("@out_remark", DBNull.Value);
                cmd.Parameters.AddWithValue("@out_datetime", DBNull.Value);
                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("Visitors.aspx");
        }
    }
}
