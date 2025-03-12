using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Remoting.Messaging;

namespace SocietyManagementSystem
{
    public partial class EditFlats : System.Web.UI.Page
    {
        SqlConnection con;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            con = new SqlConnection(cs);
            con.Open();

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int flatID = Convert.ToInt32(Request.QueryString["id"]);
                    LoadFlatDetails(flatID);
                }
                else
                {
                    Response.Redirect("FlatsManagement.aspx");
                }
            }
        }

        public void LoadFlatDetails(int id)
        {
            string q = $"exec GetFlatDetails @id";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.Parameters.AddWithValue("@id", id);
            SqlDataReader r = cmd.ExecuteReader();


            if (r.Read())
            {
                flatid.Value = r["id"].ToString();
                TextBox1.Text = r["flat_number"].ToString();
                TextBox2.Text = r["floor"].ToString();
                TextBox3.Text = r["block_number"].ToString();
                TextBox4.Text = r["flat_type"].ToString();
            }
            else
            {
                Response.Redirect("FlatsManagement.aspx");
            }

        }


        protected void btnUpdateFlat_Click(object sender, EventArgs e)
        {

            string q = $"exec sp_UpdateFlat '{flatid.Value}','{TextBox1.Text}','{TextBox2.Text}','{TextBox3.Text}','{TextBox4.Text}'";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();

            Response.Redirect("FlatsManagement.aspx");
        }



        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("FlatsManagement.aspx");
        }
    }
}
