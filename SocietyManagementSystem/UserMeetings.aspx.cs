using System;
using System.Data;
using System.Data.SqlClient;

namespace SocietyManagementSystem
{
    public partial class UserMeetings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNotifications();
            }
        }

        private void BindNotifications()
        {
            int userId = Convert.ToInt32(Session["id"]);

            using (SqlConnection con = new SqlConnection("dbconn"))
            {
                using (SqlCommand cmd = new SqlCommand("GetMeetingsForNotifications", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@user_id", userId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvNotifications.DataSource = dt;
                    gvNotifications.DataBind();
                }
            }
        }
    }
}
