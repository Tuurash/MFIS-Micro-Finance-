using CrystalDecisions.CrystalReports.Engine;
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
    public partial class MDeposit : System.Web.UI.Page
    {

        #region variables

        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        int AutoGenSlNo = 0;
        string getBranchCode = "";
        string getStaffID = "";
        string getSlNoAll = "";
        string getSlNo = "";
        DateTime Time_now;
        string getCustIDNo = "";
        string getAreaCodeForBranch = "";
        string getCustAccNo = "";
        DateTime getMaturedDate;
        string getVoucherNo = "";

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null && Session["USERID"] != null)
            {   //BranchCode
                lblStaffName.Text = Session["StaffName"].ToString();
                getBranchCode = Session["ProjectCode"].ToString();
                getStaffID = Session["USERID"].ToString();
            }
            else
            {
                Response.Redirect("~/Forms/Pages/LoginPage.aspx");
            }

            if (Request.QueryString["CustIDNo"] != "" && Request.QueryString["CustAccNo"] != "")
            {
                getCustIDNo = Request.QueryString["CustIDNo"];
                txtCustIDNO.Text = getCustIDNo;
                getCustAccNo = Request.QueryString["CustAccNo"];
                txtCustAccNo.Text = getCustAccNo;

                GenerateVoucherNo();
            }

            Time_now = DateTime.Now.Date;
        }

        private void GenerateVoucherNo()
        {
            string GeneratedVoucher = getCustIDNo + '-' + DateTime.Now.ToString("yyyy-MM-dd-HHmmss-ffff");
            getVoucherNo = GeneratedVoucher;
        }

        protected void btnSkip_Click(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "InsertComplete()", true); }
        }

        protected void btnSaveDeposit_Click(object sender, EventArgs e)
        {
            SavingsInsert();
        }

        private void SavingsInsert()
        {
            if (txtSAamount.Text != "")
            {
                int sInsertStatus = 0;

                lblAddedVoucher.Text = getVoucherNo;
                //, BranchCode, EntryNo, Dr,Notes,CustAccTrSL,Vou_ChqNo
                query = @"INSERT into Deposit_DataEntry (PYear, CustAccNo, PDate, Account_Sub_SubCode,Cr, PMonth, TransactionType, TransactionStatus, AddDate,LedgerCode,StaffID,Vou_ChqNo)
                    VALUES ('" + Time_now.Year + "', '" + getCustAccNo + "', '" + Time_now.Date + "', '203001112', " + txtSAamount.Text + ", '" + Time_now.Month + "', 'Receipts','Cr', '" + Time_now.Date + "','1101002' ,'" + getStaffID + "','" + lblAddedVoucher.Text + "')";
                try
                {
                    sInsertStatus = db.ExecuteNonQuery(query);
                }
                catch (Exception) { }
                if (sInsertStatus > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "notify(" + txtSAamount.Text + ")", true);
                }

            }

        }



        protected void btnLogout_Click(object sender, EventArgs e)
        {
            int logoutStatus = 0;
            string query = @"select UserID,comName from User_Now where UserId =  '" + getStaffID + "'";

            DataTable dt3 = db.ExecuteQuery(query);

            if (dt3.Rows.Count > 0)
            {
                if (dt3.Rows[0]["comName"].ToString() == System.Environment.MachineName)
                {

                    try
                    {
                        string UserInfo = @"delete from User_Now where UserID='" + Session["USERID"] + "'";
                        logoutStatus = db.ExecuteNonQuery(UserInfo);
                    }
                    catch (Exception)
                    {
                        //throw new Exception(ex.Message);
                    }

                    Session.RemoveAll();
                    Session.Abandon();
                    //Response.Redirect("~/frmLogin.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Please try another user')</script>");
                }
            }
            if (logoutStatus > 0)
            {
                Response.Redirect("~/Forms/Pages/LoginPage.aspx");
            }
        }

        protected void btnPrintDepositReciept_Click(object sender, EventArgs e)
        {
            string getReportName = "LoanDepositReport";
            Response.Redirect("~/Reports/ReportViewer.aspx?CustomerID=" + getCustIDNo + "&VoucherNo=" + lblAddedVoucher.Text + "&ReportName=" + getReportName);
        }

        protected void linkbtn_PrintHtml_Click(object sender, EventArgs e)
        {
            string getReportName = "LoanDepositReport_HTML";
            Response.Redirect("~/Reports/ReportViewer.aspx?CustomerID=" + getCustIDNo + "&VoucherNo=" + lblAddedVoucher.Text + "&ReportName=" + getReportName);
            //Response.Redirect("~/Forms/MobileForms/DepositRptPage.aspx?CustomerID=" + getCustIDNo + "&VoucherNo=" + lblAddedVoucher.Text + "&ReportName=" + getReportName);
        }

        protected void linkbtnRDLC_Click(object sender, EventArgs e)
        {
            string getReportName = "LoanDepoRpt_RDLC";
            Response.Redirect("~/Reports/ReportViewer.aspx?CustomerID=" + getCustIDNo + "&VoucherNo=" + lblAddedVoucher.Text + "&ReportName=" + getReportName);
        }

        protected void linkbtnPrintNow_Click(object sender, EventArgs e)
        {

            Response.Redirect("~/Reports/ReportViewer.aspx?CustomerID=" + getCustIDNo + "&VoucherNo=" + lblAddedVoucher.Text);
        }
    }
}