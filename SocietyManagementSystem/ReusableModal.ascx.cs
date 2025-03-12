using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SocietyManagementSystem
{
    public partial class ReusableModal : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void ShowModal(string title, string message, string modalClass)
        {
            modalTitle.InnerText = title;
            modalMessage.InnerText = message;

            // Set the modal class dynamically
            reusableModal.Attributes["class"] = $"modal {modalClass}";

            // Show modal using JavaScript
            ScriptManager.RegisterStartupScript(this, GetType(), "ShowModalScript", "$('#reusableModal').modal('show');", true);
        }
    }
}