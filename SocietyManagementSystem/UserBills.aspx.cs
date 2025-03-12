using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class UserBills : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
            if (!IsPostBack)
            {
                LoadUserBills();
            }
            GridView1.RowDataBound += new GridViewRowEventHandler(GridView1_RowDataBound);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblPaidAmount = (Label)e.Row.FindControl("lblPaidAmount");

                if (lblPaidAmount != null)
                {
                    if (lblPaidAmount.Text == "Not Paid")
                    {
                        lblPaidAmount.Text = "Not Paid";
                        lblPaidAmount.BackColor = System.Drawing.Color.Red;
                        lblPaidAmount.ForeColor = System.Drawing.Color.White;
                    }
                    else
                    {
                        lblPaidAmount.BackColor = System.Drawing.Color.Green;
                        lblPaidAmount.ForeColor = System.Drawing.Color.White;
                    }
                }
            }
        }

        private void LoadUserBills(string searchMonth = "", string paymentStatus = "")
        {
            int userId = Convert.ToInt32(Session["id"]);

            if (userId == 0)
            {
                Response.Redirect("Login.aspx");
            }

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand("GetUserBills", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    if (!string.IsNullOrEmpty(searchMonth))
                    {
                        cmd.Parameters.AddWithValue("@Month", searchMonth);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Month", DBNull.Value);
                    }

                    if (!string.IsNullOrEmpty(paymentStatus))
                    {
                        cmd.Parameters.AddWithValue("@PaymentStatus", paymentStatus);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@PaymentStatus", DBNull.Value);
                    }

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewRow")
            {
                int billId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"BillDetails.aspx?id={billId}");
            }
            else if (e.CommandName == "PayBill")
            {
                int billId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"BillPaymentUser.aspx?billId={billId}");
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            LoadUserBills();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchMonth = txtSearchMonth.Text.Trim();
            string paymentStatus = ddlPaymentStatus.SelectedValue;

            LoadUserBills(searchMonth, paymentStatus);
        }
    }
}
