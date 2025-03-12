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
    public partial class Login : System.Web.UI.Page
    {

        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string pass = txtPassword.Text;

            string q = $"exec LoginByUser '{email}','{pass}'";
            SqlCommand cmd = new SqlCommand(q, conn);

            SqlDataReader rdr = cmd.ExecuteReader();

            if (rdr.HasRows)
            {
                Session["MyUser"] = email;

                while (rdr.Read())
                {
                    string dbEmail = rdr["email"].ToString();
                    int dbID = Convert.ToInt32(rdr["id"].ToString());

                    if ((rdr["email"].Equals(email) || rdr["name"].Equals(email)) && rdr["password"].Equals(pass) && rdr["role"].Equals("admin"))
                    {
                        Session["loggedIn"] = dbEmail;
                        Session["id"] = dbID;

                        //ModalControl.ShowModal("Welcome", $"{rdr["name"]}", "modal-success");

                        Response.Redirect("AdminDashBoard.aspx");
                    }
                    if ((rdr["email"].Equals(email) || rdr["name"].Equals(email)) && rdr["password"].Equals(pass) && rdr["role"].Equals("user"))
                    {
                        Session["loggedIn"] = dbEmail;
                        Session["id"] = dbID;

                        //ModalControl.ShowModal("Welcome", $"{rdr["name"]}", "modal-success");

                        Response.Redirect("UserDashBoard.aspx");
                    }
                }
            }
            else
            {
                //ModalControl.ShowModal("Welcome", $"{rdr["name"]}", "modal-danger");

                Response.Write("<script>alert('Invalid Credentails')</script>");
            }
        }

    }
}
