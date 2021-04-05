using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using MFIS.Services;
using System;
using System.Data;

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


            if (!IsPostBack)
            {
                this.BindReport();
            }

            ShowReport();

        }

        private void BindReport()
        {
            EstablishConnection();

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
                crystalReport.Load(Server.MapPath("DepoReport.rpt"));
                crystalReport.SetDataSource(dt);
                CrystalReportViewer1.ReportSource = crystalReport;
            }
        }

        private void EstablishConnection()
        {
            ConnectionInfo myConnectionInfo = new ConnectionInfo();

            myConnectionInfo.ServerName = "localhost";
            myConnectionInfo.DatabaseName = "MFiS-4";
            myConnectionInfo.UserID = "sa";
            myConnectionInfo.Password = "sa*1209";
            setDBLOGONforREPORT(myConnectionInfo);
        }

        private void setDBLOGONforREPORT(ConnectionInfo myConnectionInfo)
        {
            TableLogOnInfos mytableloginfos = new TableLogOnInfos();
            mytableloginfos = CrystalReportViewer1.LogOnInfo;
            foreach (TableLogOnInfo myTableLogOnInfo in mytableloginfos)
            {
                myTableLogOnInfo.ConnectionInfo = myConnectionInfo;
            }
        }

        private void ShowReport()
        {
            EstablishConnection();

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
                    ReportDocument crystalReport = new ReportDocument();
                    string reportPath = Server.MapPath("DepoReport.rpt");
                    crystalReport.Load(reportPath);
                    crystalReport.SetDataSource(dt);
                    crystalReport.ExportToHttpResponse(CrystalDecisions.Shared.ExportFormatType.PortableDocFormat, Response, true, "Diposit&loanReport");



                }
            }

            else if (getReportName == "LoanDepositReport_HTML")
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
                    EstablishConnection();
                    crystalReport.Load(Server.MapPath("DepoReport.rpt"));
                    crystalReport.SetDataSource(dt);
                    CrystalReportViewer1.ReportSource = crystalReport;
                }
            }

            //Print Direct

            else if (getReportName == "DepoRpt")
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
                    EstablishConnection();
                    crystalReport.Load(Server.MapPath("DepoReport.rpt"));
                    crystalReport.SetDataSource(dt);
                    CrystalReportViewer1.ReportSource = crystalReport;

                    crystalReport.PrintToPrinter(1, false, 0, 0);
                }
            }

            else if (getReportName == "LoanD epoRpt_RDLC")
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

                    //ReportViewer1.ProcessingMode = ProcessingMode.Local;
                    //ReportViewer1.LocalReport.ReportPath = Server.MapPath("DepoReportRDLC.rdlc");

                    //ReportDataSource datasource = new ReportDataSource("DataSet1", dt);
                    //ReportViewer1.LocalReport.DataSources.Clear();
                    //ReportViewer1.LocalReport.DataSources.Add(datasource);
                    //ReportViewer1.ShowPrintButton = true;
                }

            }

        }


    }
}