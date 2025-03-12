using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;

namespace SocietyManagementSystem
{
    public partial class EditBill : Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);

            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"]);
                    LoadBillDetails(id);
                }
                else
                {
                    Response.Redirect("BillManagementAdmin.aspx");
                }
            }
        }

        private void LoadBillDetails(int id)
        {
            try
            {
                conn.Open();
                string query = $"exec GetBillById '{id}'";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    txtBillTitle.Text = reader["bill_title"].ToString();
                    txtAmount.Text = reader["amount"].ToString();
                    txtMonth.Text = reader["month"].ToString();
                    txtPaidDate.Text = reader["paid_date"] != DBNull.Value ? Convert.ToDateTime(reader["paid_date"]).ToString("yyyy-MM-dd") : "";
                    txtPaymentMethod.Text = reader["payment_method"].ToString();
                    txtPaidAmount.Text = reader["paid_amount"] != DBNull.Value ? reader["paid_amount"].ToString() : "";
                }
                reader.Close();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                conn.Close();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                int id = Convert.ToInt32(Request.QueryString["id"]);
                UpdateBillDetails(id);
            }
        }

        private void UpdateBillDetails(int id)
        {
            try
            {
                conn.Open();

                string billTitle = txtBillTitle.Text;
                decimal billAmount = Convert.ToDecimal(txtAmount.Text);
                string billMonth = txtMonth.Text;
                string billPaidDate = string.IsNullOrEmpty(txtPaidDate.Text) ? "NULL" : $"'{Convert.ToDateTime(txtPaidDate.Text):yyyy-MM-dd}'";
                string billPaymentMethod = string.IsNullOrEmpty(txtPaymentMethod.Text) ? "NULL" : $"'{txtPaymentMethod.Text}'";
                string billPaidAmount = string.IsNullOrEmpty(txtPaidAmount.Text) ? "NULL" : txtPaidAmount.Text;

                string query = $"exec UpdateBillEditAdmin {id}, '{billTitle}', {billAmount}, '{billMonth}', {billPaidDate}, {billPaymentMethod}, {billPaidAmount};";

                SqlCommand cmd = new SqlCommand(query, conn);

                int rowsAffected = cmd.ExecuteNonQuery();
                if (rowsAffected > 0)
                {
                    Response.Redirect("BillManagementAdmin.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Error updating bill.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
            finally
            {
                conn.Close();
            }
        }
    }
}
