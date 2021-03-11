using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Forms.Deposit.LoanDeposit
{
    public partial class frmDepositGrid : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();
        DateTime Time_now;
        string CustomerID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["CustomerID"] != null)
            {
                CustomerID = Request.QueryString["CustomerID"];
                FilldgHistory();
            }

        }

        private void FilldgHistory()
        {
            query = @"";
        }
    }
}