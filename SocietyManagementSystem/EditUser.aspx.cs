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
    public partial class EditUser : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int EditID = Convert.ToInt32(Request.QueryString["id"]);
                    EditList(EditID);
                }
                else
                {
                    Response.Redirect("UserManagement.aspx");
                }
            }
        }


        public void EditList(int EditID)
        {
            int id = EditID;
            string q = $"exec EditDataFetch '{id}'";
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
            int ID = Convert.ToInt32(Request.QueryString["id"]);
            string q = $"exec UserUpdate '{ID}','{TextBox1.Text}','{TextBox2.Text}','{TextBox3.Text}'";

            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            Response.Redirect("UserManagement.aspx");


        }
    }
}