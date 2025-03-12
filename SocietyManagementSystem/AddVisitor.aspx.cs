using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace SocietyManagementSystem
{
    public partial class AddVisitor : System.Web.UI.Page
    {
        //private string connectionString = "dbconn";
        private string connectionString = "Data Source=DESKTOP-FKR0CTR\\MTSESURAJDB;Initial Catalog=SocietyManagementSystem;Integrated Security=True;Encrypt=False;MultipleActiveResultSets=True";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFlats();
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

        protected void btnAddVisitor_Click(object sender, EventArgs e)
        {
            string flat_id = ddlFlats.SelectedValue;
            string name = txtName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string address = txtAddress.Text.Trim();
            string person_to_meet = txtPersonToMeet.Text.Trim();
            string reason = txtReason.Text.Trim();
            string in_datetime = txtInDateTime.Text.Trim();

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

            DateTime inDateTime;
            if (!DateTime.TryParse(in_datetime, out inDateTime))
            {
                lblError.Visible = true;
                lblError.Text = "Invalid date and time format";
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("AddVisitor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@flat_id", flat_id);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@phone", phone);
                cmd.Parameters.AddWithValue("@address", address);
                cmd.Parameters.AddWithValue("@person_to_meet", person_to_meet);
                cmd.Parameters.AddWithValue("@reason", reason);
                cmd.Parameters.AddWithValue("@in_datetime", inDateTime);
                cmd.Parameters.AddWithValue("@is_in_out", "in");
                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("Visitors.aspx");
        }
    }
}

//using System;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Text.RegularExpressions;

//namespace SocietyManagementSystem
//{
//    public partial class AddVisitor : System.Web.UI.Page
//    {
//        //private string connectionString = "dbconn";
//        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;


//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                BindFlats();
//            }
//        }

//        private void BindFlats()
//        {
//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand("GetFlatsForDropdown", con);
//                cmd.CommandType = CommandType.StoredProcedure;
//                SqlDataAdapter sda = new SqlDataAdapter(cmd);
//                DataTable dt = new DataTable();
//                sda.Fill(dt);
//                ddlFlats.DataSource = dt;
//                ddlFlats.DataTextField = "flat_number";
//                ddlFlats.DataValueField = "id";
//                ddlFlats.DataBind();
//            }
//        }

//        protected void btnAddVisitor_Click(object sender, EventArgs e)
//        {
//            string flat_id = ddlFlats.SelectedValue;
//            string name = txtName.Text.Trim();
//            string phone = txtPhone.Text.Trim();
//            string address = txtAddress.Text.Trim();
//            string person_to_meet = txtPersonToMeet.Text.Trim();
//            string reason = txtReason.Text.Trim();
//            string in_datetime = txtInDateTime.Text.Trim();

//            if (string.IsNullOrEmpty(flat_id) || string.IsNullOrEmpty(name) || string.IsNullOrEmpty(phone) ||
//                string.IsNullOrEmpty(address) || string.IsNullOrEmpty(person_to_meet) ||
//                string.IsNullOrEmpty(reason) || string.IsNullOrEmpty(in_datetime))
//            {
//                lblError.Visible = true;
//                lblError.Text = "All fields are required";
//                return;
//            }

//            if (!Regex.IsMatch(phone, @"^\d{10}$"))
//            {
//                lblError.Visible = true;
//                lblError.Text = "Phone number is invalid";
//                return;
//            }

//            using (SqlConnection con = new SqlConnection(connectionString))
//            {
//                SqlCommand cmd = new SqlCommand("AddVisitor", con);
//                cmd.CommandType = CommandType.StoredProcedure;
//                cmd.Parameters.AddWithValue("@flat_id", flat_id);
//                cmd.Parameters.AddWithValue("@name", name);
//                cmd.Parameters.AddWithValue("@phone", phone);
//                cmd.Parameters.AddWithValue("@address", address);
//                cmd.Parameters.AddWithValue("@person_to_meet", person_to_meet);
//                cmd.Parameters.AddWithValue("@reason", reason);
//                cmd.Parameters.AddWithValue("@in_datetime", in_datetime);
//                cmd.Parameters.AddWithValue("@is_in_out", "in");
//                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
//                con.Open();
//                cmd.ExecuteNonQuery();
//            }

//            Response.Redirect("Visitors.aspx");
//        }
//    }
//}

