using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace SocietyManagementSystem
{
    public partial class UserViewAllNoti : Page
    {
        SqlConnection conn;
        private int pageSize = 4;
        private int currentPage = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                btnPrevious.Visible = false;
                btnNext.Visible = false;
                LoadAllNotifications(0);
            }
        }

        private void LoadAllNotifications(int pageIndex)
        {
            if (Session["id"] == null)
                return;
            int userId = Convert.ToInt32(Session["id"]);

            string query = $"exec GetUserNotifications '{userId}'";
            SqlCommand cmd = new SqlCommand(query, conn);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // Pagination
            PagedDataSource pagedData = new PagedDataSource();
            pagedData.DataSource = dt.DefaultView;
            pagedData.AllowPaging = true;
            pagedData.PageSize = pageSize;
            pagedData.CurrentPageIndex = pageIndex;

            // Enable/Disable Pagination Buttons
            btnPrevious.Visible = !pagedData.IsFirstPage;
            btnNext.Visible = !pagedData.IsLastPage;

            ViewState["PageIndex"] = pageIndex;

            rptAllNotifications.DataSource = pagedData;
            rptAllNotifications.DataBind();
        }

        protected void rptAllNotifications_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {
                HiddenField hfNotificationLink = (HiddenField)e.Item.FindControl("hfNotificationLink");
                string notificationLink = hfNotificationLink != null ? hfNotificationLink.Value : string.Empty;

                // Redirect to the stored link
                if (!string.IsNullOrEmpty(notificationLink))
                {
                    Response.Redirect(notificationLink);
                }
            }
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            int pageIndex = (int)ViewState["PageIndex"] - 1;
            LoadAllNotifications(pageIndex);
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            int pageIndex = (int)ViewState["PageIndex"] + 1;
            LoadAllNotifications(pageIndex);
        }
    }
}
