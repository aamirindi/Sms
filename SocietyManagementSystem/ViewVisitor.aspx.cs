using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SocietyManagementSystem
{
    public partial class ViewVisitor : System.Web.UI.Page
    {
        //private string connectionString = "dbconn";
        private string connectionString = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int visitorId = Convert.ToInt32(Request.QueryString["id"]);
                    BindVisitorDetails(visitorId);
                }
            }
        }

        private void BindVisitorDetails(int visitorId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(@"
                    SELECT visitors.id, flats.flat_number, flats.block_number, visitors.name, visitors.phone,
                           visitors.person_to_meet, visitors.in_datetime, visitors.out_datetime, visitors.is_in_out,
                           visitors.out_remark, visitors.address, visitors.reason
                    FROM visitors
                    JOIN flats ON flats.id = visitors.flat_id
                    WHERE visitors.id = @id", con);
                cmd.Parameters.AddWithValue("@id", visitorId);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    lblFlatNumber.Text = row["block_number"].ToString() + " - " + row["flat_number"].ToString();
                    lblName.Text = row["name"].ToString();
                    lblPhone.Text = row["phone"].ToString();
                    lblAddress.Text = row["address"].ToString();
                    lblPersonToMeet.Text = row["person_to_meet"].ToString();
                    lblReason.Text = row["reason"].ToString();
                    lblInDateTime.Text = row["in_datetime"].ToString();
                    hdnVisitorId.Value = visitorId.ToString();

                    if (row["out_remark"] != DBNull.Value)
                    {
                        lblOutRemark.Text = row["out_remark"].ToString();
                        lblOutDateTime.Text = row["out_datetime"].ToString();
                        pnlOutDetails.Visible = true;
                    }
                    else
                    {
                        pnlMarkOut.Visible = true;
                    }
                }
            }
        }

        protected void btnMarkOut_Click(object sender, EventArgs e)
        {
            string out_remark = txtOutRemark.Text.Trim();
            string out_datetime = txtOutDateTime.Text.Trim();
            int visitorId = Convert.ToInt32(hdnVisitorId.Value);

            if (string.IsNullOrEmpty(out_remark) || string.IsNullOrEmpty(out_datetime))
            {
                lblError.Visible = true;
                lblError.Text = "Please enter out remark and out date/time";
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("UpdateVisitor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@visitor_id", visitorId);
                cmd.Parameters.AddWithValue("@flat_id", DBNull.Value);
                cmd.Parameters.AddWithValue("@name", DBNull.Value);
                cmd.Parameters.AddWithValue("@phone", DBNull.Value);
                cmd.Parameters.AddWithValue("@address", DBNull.Value);
                cmd.Parameters.AddWithValue("@person_to_meet", DBNull.Value);
                cmd.Parameters.AddWithValue("@reason", DBNull.Value);
                cmd.Parameters.AddWithValue("@in_datetime", DBNull.Value);
                cmd.Parameters.AddWithValue("@is_in_out", "out");
                cmd.Parameters.AddWithValue("@out_remark", out_remark);
                cmd.Parameters.AddWithValue("@out_datetime", out_datetime);
                cmd.Parameters.AddWithValue("@action_by", 1); // Assuming the logged-in user ID is 1
                con.Open();
                cmd.ExecuteNonQuery();
            }

            Response.Redirect("Visitors.aspx");
        }
    }
}
