using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class UserManagement : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                UserList();
            }

        }

        protected void UserList()
        {

            string q = "exec UserManagementList";

            SqlDataAdapter reader = new SqlDataAdapter(q, conn);

            DataTable dt = new DataTable();

            reader.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label l1 = (Label)GridView1.Rows[e.RowIndex].FindControl("Label1");
            string id = l1.Text;
            string q = $"exec  UserDelete  {id} ";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('User Deleted successfully');</script>");
            UserList();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {

            //int id = Convert.ToInt32(GridView1.DataKeys[e.NewEditIndex].Value);
            Label l1 = (Label)GridView1.Rows[e.NewEditIndex].FindControl("Label1");
            string id = l1.Text;
            Response.Redirect("EditUser.aspx?id=" + id);
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string name = TextBox1.Text;

            string q = $" exec SearchByname'{name}'";
            SqlCommand cmd = new SqlCommand(q, conn);

            SqlDataReader rdr = cmd.ExecuteReader();

            GridView1.DataSource = rdr;
            GridView1.DataBind();
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
//    public partial class UserManagement : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {

//        }
//    }
//}