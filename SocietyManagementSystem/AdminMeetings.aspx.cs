using System;
using System.Data;
using System.Data.SqlClient;

namespace SocietyManagementSystem
{
    public partial class AdminMeetings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMeetings();
            }
        }

        protected void btnCreateMeeting_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text;
            string description = txtDescription.Text;
            DateTime meetingDate = DateTime.Parse(txtDate.Text);
            TimeSpan meetingTime = TimeSpan.Parse(txtTime.Text);
            int createdBy = Convert.ToInt32(Session["UserId"]); // Assuming admin's user ID is stored in session

            using (SqlConnection con = new SqlConnection("dbconn"))
            {
                using (SqlCommand cmd = new SqlCommand("AddMeeting", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@meeting_date", meetingDate);
                    cmd.Parameters.AddWithValue("@meeting_time", meetingTime);
                    cmd.Parameters.AddWithValue("@created_by", createdBy);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            lblMessage.Text = "Meeting created successfully!";
            BindMeetings();
        }

        protected void gvMeetings_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteMeeting")
            {
                int meetingId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection("dbconn"))
                {
                    using (SqlCommand cmd = new SqlCommand("DeleteMeeting", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@meeting_id", meetingId);
                        cmd.Parameters.AddWithValue("@action_by", Convert.ToInt32(Session["UserId"]));

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                BindMeetings();
            }
        }

        private void BindMeetings()
        {
            using (SqlConnection con = new SqlConnection("dbconn"))
            {
                using (SqlCommand cmd = new SqlCommand("GetMeetings", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvMeetings.DataSource = dt;
                    gvMeetings.DataBind();
                }
            }
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
//    public partial class AdminMeetings : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {

//        }
//    }
//}