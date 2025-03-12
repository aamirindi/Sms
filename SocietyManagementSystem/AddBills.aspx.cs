using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class AddBills : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                BindFlatNumber();
            }
        }

        public void BindFlatNumber()
        {
            string q = "exec GetFlatsForDropdown";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();

            DropDownList1.Items.Clear();
            DropDownList1.Items.Add(new ListItem("Select Flat", ""));

            while (rdr.Read())
            {
                string blockNumber = rdr["block_number"].ToString();
                string flatNumber = rdr["flat_number"].ToString();
                string displayText = $"{blockNumber} - {flatNumber}";
                string value = rdr["id"].ToString();

                DropDownList1.Items.Add(new ListItem(displayText, value));
            }

            rdr.Close();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "")
            {
                Response.Write("<script>alert('Please select a flat.');</script>");
                return;
            }

            int flatId = Convert.ToInt32(DropDownList1.SelectedValue);
            string billTitle = TextBox1.Text;
            decimal amount = Convert.ToDecimal(TextBox2.Text);
            string month = TextBox3.Text;

            string q = $"exec AddBill '{flatId}', '{billTitle}', '{amount}', '{month}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('Bill added successfully.');</script>");

            DropDownList1.SelectedIndex = 0;
            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox3.Text = "";
        }
    }
}
