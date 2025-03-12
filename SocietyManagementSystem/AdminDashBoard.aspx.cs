using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                LoadDashboardCounts();
                LoadAllotmentsBarChart();
                LoadBillsPaymentPieChart();
            }
        }

        private void LoadAllotmentsBarChart()
        {
            List<KeyValuePair<string, int>> chartData = new List<KeyValuePair<string, int>>();

            // Query to group move-in dates by month
            string query = "exec GetMoveInDatesByMonth";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                string monthYear = reader["MonthYear"].ToString();
                int count = Convert.ToInt32(reader["Count"]);
                chartData.Add(new KeyValuePair<string, int>(monthYear, count));
            }
            reader.Close();

            // Convert to JSON for Chart.js
            var jsonData = new
            {
                labels = chartData.Select(item => item.Key).ToArray(),
                datasets = new[]
                {
                    new
                    {
                        label = "Number of Allotments",
                        data = chartData.Select(item => item.Value).ToArray(),
                        backgroundColor = "#36A2EB",
                        borderColor = "#2980B9",
                        borderWidth = 1
                    }
                }
            };

            // Serialize to JSON
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string chartJson = serializer.Serialize(jsonData);

            // Register the script to render the chart
            string script = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    var ctx = document.getElementById('allotmentsBarChart').getContext('2d');
                    var allotmentsChart = new Chart(ctx, {{
                        type: 'bar',
                        data: {chartJson},
                        options: {{
                            responsive: true,
                            maintainAspectRatio: false,
                            title: {{
                                display: true,
                                text: 'Allotments by Month'
                            }},
                            scales: {{
                                yAxes: [{{
                                    ticks: {{
                                        beginAtZero: true,
                                        precision: 0
                                    }}
                                }}]
                            }}
                        }}
                    }});
                }});";

            ClientScript.RegisterStartupScript(this.GetType(), "AllotmentsBarChart", script, true);
        }

        private void LoadBillsPaymentPieChart()
        {
            string query = "exec GetPaidDataPieChart";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            int paidCount = 0;
            int unpaidCount = 0;

            while (reader.Read())
            {
                string status = reader["payment_status"].ToString();
                int count = Convert.ToInt32(reader["bill_count"]);

                if (status == "Paid")
                    paidCount = count;
                else
                    unpaidCount = count;
            }
            reader.Close();

            // Prepare chart data
            var jsonData = new
            {
                labels = new[] { "Paid", "Not Paid" },
                datasets = new[]
                {
                    new
                    {
                        data = new[] { paidCount, unpaidCount },
                        backgroundColor = new[] { "#4BC0C0", "#FF6384" },
                        hoverBackgroundColor = new[] { "#3AA7A7", "#E84B6A" }
                    }
                }
            };

            // Serialize to JSON
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string chartJson = serializer.Serialize(jsonData);

            // Register the script to render the chart
            string script = $@"
                document.addEventListener('DOMContentLoaded', function() {{
                    var ctx = document.getElementById('billsPaymentPieChart').getContext('2d');
                    var billsChart = new Chart(ctx, {{
                        type: 'pie',
                        data: {chartJson},
                        options: {{
                            responsive: true,
                            maintainAspectRatio: false,
                            title: {{
                                display: true,
                                text: 'Bill Payment Status'
                            }},
                            legend: {{
                                position: 'right'
                            }},
                            tooltips: {{
                                callbacks: {{
                                    label: function(tooltipItem, data) {{
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function(previousValue, currentValue) {{
                                            return previousValue + currentValue;
                                        }});
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue/total) * 100) + 0.5);
                                        return data.labels[tooltipItem.index] + ': ' + currentValue + ' (' + percentage + '%)'
                                    }}
                                }}
                            }}
                        }}
                    }});
                }});";

            ClientScript.RegisterStartupScript(this.GetType(), "BillsPaymentPieChart", script, true);
        }

        private void LoadDashboardCounts()
        {
            string query = "EXEC GetAdminDashboardCounts";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                lblUsersCount.Text = reader["UsersCount"].ToString();
                lblFlatsCount.Text = reader["FlatsCount"].ToString();
                lblAllotmentsCount.Text = reader["AllotmentsCount"].ToString();
                lblBillsCount.Text = reader["BillsCount"].ToString();
                lblComplaintsCount.Text = reader["ComplaintsCount"].ToString();
                lblVisitorsCount.Text = reader["VisitorsCount"].ToString();
            }

            reader.Close();
        }
    }
}