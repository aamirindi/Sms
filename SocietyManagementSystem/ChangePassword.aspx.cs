using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string email = Session["loggedIn"].ToString();

            string currentPassword = TextBox1.Text;
            string newPassword = TextBox2.Text;
            string confirmPassword = TextBox3.Text;

            // Check if new passwords match
            if (newPassword != confirmPassword)
            {
                Label1.Text = "New passwords do not match.";
                return;
            }

            // Database connection string (from Web.config)
            string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Check current password
                string query = "SELECT password FROM Users  WHERE email = @email";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@email", email);

                object dbPassword = cmd.ExecuteScalar();

                if (dbPassword == null || dbPassword.ToString() != currentPassword)
                {
                    Label1.Text = "Current password is incorrect.";
                    return;
                }

                // Update new password
                string updateQuery = "UPDATE Users  SET password = @NewPassword WHERE email = @email";
                SqlCommand updateCmd = new SqlCommand(updateQuery, con);
                updateCmd.Parameters.AddWithValue("@NewPassword", newPassword);
                updateCmd.Parameters.AddWithValue("@email", email);

                int rowsAffected = updateCmd.ExecuteNonQuery();

                if (rowsAffected > 0)
                {
                    Label1.ForeColor = System.Drawing.Color.Green;
                    Label1.Text = "Password changed successfully.";
                }
                else
                {
                    Label1.Text = "Password change failed.";
                }
            }

        }
    }
}//using System;
 //using System.Collections.Generic;
 //using System.Linq;
 //using System.Web;
 //using System.Web.UI;
 //using System.Web.UI.WebControls;

//namespace SocietyManagementSystem
//{
//    public partial class ChangePassword : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {

//        }
//    }
//}