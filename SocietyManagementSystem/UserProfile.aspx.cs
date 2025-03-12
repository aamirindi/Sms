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
    public partial class UserProfile : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                if (Session["loggedIn"] != null)
                {
                    string email = Session["loggedIn"].ToString();
                    EditFetchData(email);
                }
                else
                {
                    Response.Redirect("#");
                }
            }
        }


        public void EditFetchData(string email)
        {

            string q = $"exec EditProfileFecthData '{email}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader r = cmd.ExecuteReader();


            if (r.Read())
            {
                TextBox1.Text = r["name"].ToString();
                TextBox2.Text = r["email"].ToString();
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            string email = Session["loggedIn"].ToString();

            string q = $"exec EditProfileSaveData '{email}','{TextBox1.Text}','{TextBox2.Text}'";

            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            Response.Redirect("Login.aspx");

        }







    }
}
//using System;
 //using System.Collections.Generic;
 //using System.Linq;
 //using System.Web;
 //using System.Web.UI;
 //using System.Web.UI.WebControls;

//namespace SocietyManagementSystem
//{
//    public partial class UserProfile : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {

//        }
//    }
//}