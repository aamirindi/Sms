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
    public partial class FlatsManagement : System.Web.UI.Page
    {
        SqlConnection con;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            con = new SqlConnection(cs);
            con.Open();

            if (!IsPostBack)
            {
                LoadFlats();
            }
        }
        private void LoadFlats()
        {
            string q1 = $"exec sp_GetAllFlats";
            SqlDataAdapter da = new SqlDataAdapter(q1, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridViewFlats.DataSource = dt;
            GridViewFlats.DataBind();
        }

        protected void btnAddFlat_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddFlats.aspx");
        }

        protected void GridViewFlats_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(GridViewFlats.DataKeys[e.NewEditIndex].Value);
            Response.Redirect("EditFlats.aspx?id=" + id);
        }

        protected void GridViewFlats_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridViewFlats.DataKeys[e.RowIndex].Value);
            string q1 = $"exec sp_DeleteFlats @id";
            SqlCommand cmd = new SqlCommand(q1, con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();

            LoadFlats();
        }

        protected void GridViewFlats_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
