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
    public partial class AddUser : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string Name = TextBox1.Text;
            string email = TextBox2.Text;
            string password = TextBox3.Text;



            string q = $"exec NewUser '{Name}','{email}','{password}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('User added successfully');window.location.href='UserManagement.aspx'</script>");

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
//    public partial class AddUser : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {

//        }
//    }
//}