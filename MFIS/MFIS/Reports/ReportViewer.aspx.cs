using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using MFIS.Forms;
using MFIS.Pages;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Reports
{
    public partial class ReportViewer : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string getCustomerID = "";
        string getVoucherNo = "";
        string getReportName = "";

        ReportDocument crystalReport = new ReportDocument();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["CustomerID"] != null)
            {
                getCustomerID = Request.QueryString["CustomerID"];
            }
            if (Request.QueryString["VoucherNo"] != null && Request.QueryString["CustomerID"] != null)
            {
                getVoucherNo = Request.QueryString["VoucherNo"];
            }

            if (Request.QueryString["ReportName"] != null)
            {
                getReportName = Request.QueryString["ReportName"];
            }

            ShowReport();
        }

        private void ShowReport()
        {
            if (getReportName == "LoanDepositReport")
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
                    crystalReport.Load(Server.MapPath("LoanDepositReport.rpt"));
                    crystalReport.SetDataSource(dt);
                    CrystalReportViewer.ReportSource = crystalReport;
                    crystalReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, HttpContext.Current.Response, false, "Diposit&loanReport");
                }
            }
        }
    }
}