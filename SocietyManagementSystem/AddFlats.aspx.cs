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
    public partial class AddFlats : System.Web.UI.Page
    {
        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            con = new SqlConnection(cs);
            con.Open();
            if (!IsPostBack)
            {
                LoadFlatTypes();
            }
        }


        public void LoadFlatTypes()
        {
            ddl1.Items.Clear();
            ddl1.Items.Add(new ListItem("Select Type", ""));
            ddl1.Items.Add(new ListItem("1 BHK Flat", "1 BHK Flat"));
            ddl1.Items.Add(new ListItem("2 BHK Flat", "2 BHK Flat"));
            ddl1.Items.Add(new ListItem("3 BHK Flat", "3 BHK Flat"));
        }
        protected void btnAddFlat_Click(object sender, EventArgs e)
        {
            string q = $"exec sp_AddFlat '{TextBox1.Text}','{TextBox2.Text}','{TextBox3.Text}','{ddl1.SelectedValue}'";
            SqlCommand cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();
            Response.Write("<script>alert('Flat added successfully')</script>");

            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox3.Text = "";
            ddl1.SelectedIndex = 0;


        }
    }
}
