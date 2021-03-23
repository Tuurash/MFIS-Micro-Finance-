using MFIS.Pages;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Forms.MobileForms
{
    public partial class DepositRptPage : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string getCustomerID = "";
        string getVoucherNo = "";
        string getReportName = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            lblPrintDate.Text = DateTime.Now.ToString();
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

            FillReportData();
        }

        private void FillReportData()
        {
            if (getReportName == "LoanDepositReport_HTML")
            {
                query = @"Exec SelectLastLoanDepositHistory @VoucherNo='" + getVoucherNo + "', @CustID='" + getCustomerID + "'";
                try
                {
                    dt = db.ExecuteQuery(query);

                    if (dt.Rows.Count > 0)
                    {
                        lblID.Text = dt.Rows[0]["CustIDNO"].ToString();
                        lblName.Text = dt.Rows[0]["CustName"].ToString();
                        lblID.Text = dt.Rows[0]["Vou_ChqNo"].ToString();

                        FillGridReport(dt);
                    }

                }
                catch (Exception exc)
                {
                    throw exc;
                }
                if (dt.Rows.Count > 0)
                {

                }
            }
        }

        private void FillGridReport(DataTable dt)
        {
            gridReport.DataSource = dt;
            gridReport.DataBind();

            //double TotalAmount = 0;
            //gridReport.FooterRow.Cells[1].Text = "Total: ";
            //gridReport.FooterRow.Cells[2].Font.Bold = true;
            //gridReport.FooterRow.Cells[2].HorizontalAlign = HorizontalAlign.Left;


            //TotalAmount = dt.AsEnumerable().Sum(row => row.Field<double>(dt.Columns[2].ToString()));
            //gridReport.FooterRow.Cells[2].Text = TotalAmount.ToString();]

            decimal TotalAmount = dt.AsEnumerable().Sum(row => row.Field<decimal>("Cr"));
            gridReport.FooterRow.Cells[1].Text = "Total";
            gridReport.FooterRow.Cells[1].HorizontalAlign = HorizontalAlign.Right;
            gridReport.FooterRow.Cells[2].Text = TotalAmount.ToString("N2");

        }


    }
}