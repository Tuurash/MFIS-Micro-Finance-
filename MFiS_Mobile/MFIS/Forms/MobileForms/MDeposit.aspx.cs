using CrystalDecisions.CrystalReports.Engine;
using MFIS.Services;
using System;
using System.Data;
using System.Web.UI;


namespace MFIS.Forms.MobileForms
{
    public partial class MDeposit : System.Web.UI.Page
    {

        #region variables

        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string getBranchCode = "";
        string getStaffID = "";

        DateTime Time_now;
        string getCustIDNo = "";
        string getAccSubSubCode = "";
        string getCustAccNo = "";
        string getCustMobileNo = "";

        string getVoucherNo = "";
        string getSubDepositCode = "";
        string getLedgerCode = "";



        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null && Session["USERID"] != null && Session["SubDepositCode"] != null && Session["SubDepositCode"].ToString() != "")
            {   //BranchCode
                lblStaffName.Text = Session["StaffName"].ToString();
                getBranchCode = Session["ProjectCode"].ToString();
                getStaffID = Session["USERID"].ToString();
                getSubDepositCode = Session["SubDepositCode"].ToString();
                getCustMobileNo = Session["CustMobileNo"].ToString();
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
            string ID = getCustIDNo.Remove(3);
            string GeneratedVoucher = ID.Trim('-') + DateTime.Now.ToString("yyyyMMddHHmmssffff");
            getVoucherNo = GeneratedVoucher;
        }

        protected void btnSkip_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Forms/MobileForms/MDashboard.aspx");
        }

        protected void btnSaveDeposit_Click(object sender, EventArgs e)
        {
            SavingsInsert();
        }


        private void LoadAccSubSubCode()
        {
            query = "select * from Deposit_SubScheme where SubDepositCodeNo='" + getSubDepositCode + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { throw exc; }
            if (dt.Rows.Count > 0)
            {
                getAccSubSubCode = dt.Rows[0]["Account_Sub_SubCode"].ToString();
            }
        }

        private void LoadLeadgerCode()
        {
            query = @"select * from Acc_Sub_SubHead where Acc_Name='" + RadioPaymnetMethod.SelectedValue + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { throw exc; }
            if (dt.Rows.Count > 0)
            {
                getLedgerCode = dt.Rows[0]["Account_Sub_SubCode"].ToString();
            }
            else { getLedgerCode = "1101002"; }
        }

        private string getSavingCount()
        {
            query = @"select COUNT(AutoSlNo)+1 as DepoEntryNo from Deposit_DataEntry where CustAccNo='" + getCustAccNo + "'";
            try { dt = db.ExecuteQuery(query); }
            catch (Exception) { }
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["DepoEntryNo"].ToString();
            }
            else
            {
                return "1";
            }
        }

        private void SavingsInsert()
        {
            if (txtSAamount.Text != "")
            {
                string DepoAmount = txtSAamount.Text;
                int sInsertStatus = 0;

                LoadAccSubSubCode();
                LoadLeadgerCode();
                lblAddedVoucher.Text = getVoucherNo;
                //, EntryNo, Dr,Notes,CustAccTrSL
                query = @"INSERT into Deposit_DataEntry (CustAccTrSL,ProfitCR,Notes,UserId,Dr,EntryNo,BranchCode,PYear, CustAccNo, PDate, Account_Sub_SubCode,Cr, PMonth, TransactionType, TransactionStatus, AddDate,LedgerCode,StaffID,Vou_ChqNo, EntryPlatform)
                        VALUES (" + getSavingCount() + " ,0 ,'Recieved By Cash','" + getStaffID + "',0 ," + getSavingCount() + " ,'" + getBranchCode + "','" + Time_now.Year + "', '" + getCustAccNo + "', '" + Time_now + "', " + getAccSubSubCode + ", " + DepoAmount + ", '" + Time_now.Month + "', 'Receipts','Cr', '" + Time_now + "'," + getLedgerCode + " ,'" + getStaffID + "','" + lblAddedVoucher.Text + "', 'Mobile Webapp')";
                sInsertStatus = db.ExecuteNonQuery(query);
                try
                {

                    //sInsertStatus = db.ExecuteNonQuery(query);
                }
                catch (Exception) { }
                if (sInsertStatus > 0)
                {
                    BindReport();

                    Sms_Manager sms = new Sms_Manager();

                    try
                    {
                        query = @"select CustAccNo,SUM(Cr) as SumAmount,COUNT(Cr) as EntryCount from Deposit_DataEntry where CustAccNo='" + getCustAccNo + "' group by CustAccNo";
                        dt = db.ExecuteQuery(query);
                        string Balance = dt.Rows[0]["SumAmount"].ToString();

                        string msg = "Dear Sir, A/C: '" + getCustAccNo + "' cash recieved by BDT:" + DepoAmount + " on " + DateTime.Now + "  Balance:" + Balance + " Thanks, Safety MCL.";
                        sms.SendSMS(getCustMobileNo, msg);
                    }
                    catch (Exception) { }

                }

            }
        }

        private void BindReport()
        {
            ReportDocument crystalReport = new ReportDocument();

            query = @"Exec SelectLastLoanDepositHistory @VoucherNo='" + lblAddedVoucher.Text + "', @CustID='" + txtCustIDNO.Text + "'";
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
                crystalReport.Load(Server.MapPath("~/Reports/DepoReport.rpt"));
                crystalReport.SetDataSource(dt);
                CrystalReportViewer1.ReportSource = crystalReport;

                //ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "notify(" + txtSAamount.Text + ")", true);
                divPrint.Visible = true;
                Clear();
            }
        }

        private void Clear()
        {
            txtSAamount.Text = "";
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

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Forms/MobileForms/MDashboard.aspx");
        }
    }
}