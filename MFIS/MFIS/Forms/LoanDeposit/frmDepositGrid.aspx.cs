using MFIS.Pages;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Forms.LoanDeposit
{
    public partial class frmDepositGrid : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string getCustomerID = "";
        string getVoucherNo = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["CustomerID"] != null)
            {
                getCustomerID = Request.QueryString["CustomerID"];
                FilldgHistory();
            }
            if (Request.QueryString["VoucherNo"] != null && Request.QueryString["CustomerID"] != null)
            {
                getVoucherNo = Request.QueryString["VoucherNo"];
                FillLastPaymentDetails();
            }

        }

        private void FillLastPaymentDetails()
        {
            query = @"Exec SelectLastLoanDepositHistory @VoucherNo='" + getVoucherNo + "', @CustID='" + getCustomerID + "'";
            try
            {
                dt = db.ExecuteQuery(query);
            }
            catch (Exception exc)
            {

                throw exc;
            }
            if (dt.Rows.Count > 0)
            {
                gridLastPayment.DataSource = dt;
                gridLastPayment.DataBind();
            }
        }

        private void FilldgHistory()
        {
            query = @"Exec AllLoanDepositHistoryByCustID @CustID='" + getCustomerID + "'";
            try
            {
                dt = db.ExecuteQuery(query);
            }
            catch (Exception exc)
            {

                throw exc;
            }

            if (dt.Rows.Count > 0)
            {
                dgHistory.DataSource = dt;
                dgHistory.DataBind();
            }

        }


        protected void dgHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            FilldgHistory();
            dgHistory.PageIndex = e.NewPageIndex;
            dgHistory.DataBind();
        }

        protected void btnShowAllHistory_Click(object sender, EventArgs e)
        {
            divHistory.Visible = true;
        }

        protected void btnGetReport_Click(object sender, EventArgs e)
        {
            string getReportName = "LoanDepositReport";
            Response.Redirect("~/Reports/ReportViewer.aspx?CustomerID=" + getCustomerID + "&VoucherNo=" + getVoucherNo + "&ReportName=" + getReportName);
        }
    }
}