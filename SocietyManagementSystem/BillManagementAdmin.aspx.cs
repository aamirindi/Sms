using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class BillManagementAdmin : Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void BindGrid()
        {
            string query = "exec GetAllUserBills";

            SqlDataAdapter da = new SqlDataAdapter(query, conn);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("EditBill.aspx?id=" + id);
            }
            else if (e.CommandName == "ViewRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                Response.Redirect("ViewBillAdmin.aspx?id=" + id);
            }
            else if (e.CommandName == "DeleteRow")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                string query = $"exec DeleteBill '{id}'";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.ExecuteNonQuery();
                conn.Close();

                BindGrid();
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void Add_Bill(object sender, EventArgs e)
        {
            Response.Redirect("AddBills.aspx");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string nameFilter = txtName.Text.Trim();
            string fromMonth = txtFromMonth.Text.Trim();
            string toMonth = txtToMonth.Text.Trim();
            string paymentStatus = ddlPaymentStatus.SelectedValue;

            string query = @"
        SELECT
            B.id,
            U.name AS Name,
            B.bill_title,
            B.amount,
            B.month,
            B.paid_date,
            B.payment_method,
            B.paid_amount,
            B.created_at
        FROM Bills B
        JOIN Allotments A ON B.flat_id = A.flat_id
        JOIN Users U ON A.user_id = U.id
        WHERE 1=1";

            if (!string.IsNullOrEmpty(nameFilter))
            {
                query += " AND U.name LIKE @Name";
            }

            if (!string.IsNullOrEmpty(fromMonth))
            {
                query += " AND B.month >= @FromMonth";
            }

            if (!string.IsNullOrEmpty(toMonth))
            {
                query += " AND B.month <= @ToMonth";
            }

            if (!string.IsNullOrEmpty(paymentStatus))
            {
                query += " AND (CASE WHEN B.paid_date IS NOT NULL THEN 'Paid' ELSE 'Not Paid' END) = @PaymentStatus";
            }

            query += " ORDER BY B.created_at DESC";

            SqlCommand cmd = new SqlCommand(query, conn);

            if (!string.IsNullOrEmpty(nameFilter))
            {
                cmd.Parameters.AddWithValue("@Name", "%" + nameFilter + "%");
            }
            if (!string.IsNullOrEmpty(fromMonth))
            {
                cmd.Parameters.AddWithValue("@FromMonth", fromMonth);
            }
            if (!string.IsNullOrEmpty(toMonth))
            {
                cmd.Parameters.AddWithValue("@ToMonth", toMonth);
            }
            if (!string.IsNullOrEmpty(paymentStatus))
            {
                cmd.Parameters.AddWithValue("@PaymentStatus", paymentStatus);
            }

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}
