﻿using CrystalDecisions.CrystalReports.Engine;
using MFIS.Services;
using System;
using System.Data;
using System.Web.UI;


namespace MFIS.Forms.MobileForms
{
    public partial class MSavingsLoan : System.Web.UI.Page
    {

        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string getBranchCode = "";
        string getStaffID = "";
        string getLedgerCode = "";
        string getAccSubSubCode = "";
        DateTime Time_now;
        double Balance, TotalPaid = 0;
        string getCustMobileNo = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            Time_now = DateTime.Now.Date;
            txtDate.Text = Time_now.ToString();

            if (Session["ProjectCode"] != null && Session["USERID"] != null)
            {   //BranchCode
                lblStaffName.Text = Session["StaffName"].ToString();

                getBranchCode = Session["ProjectCode"].ToString();
                getStaffID = Session["USERID"].ToString();


            }
            else { Response.Redirect("~/Forms/Pages/LoginPage.aspx"); }
        }

        private void GenerateVoucherNo()
        {
            string ID = txtIdNo.Text.Remove(3);
            string GeneratedVoucher = ID.Trim('-') + DateTime.Now.ToString("yyyyMMddHHmmssffff");
            lblVoucherNo.Text = GeneratedVoucher;
        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FillCustomerInfo();
        }

        protected void txtIdNo_TextChanged(object sender, EventArgs e)
        {
            FillCustomerInfo();
        }

        protected void DropdownSAno_SelectedIndexChanged(object sender, EventArgs e)
        {
            FillCustomerInfo();
        }

        private void FillCustomerInfo()
        {
            DropdownLAno.Visible = true;
            divLAsearch.Visible = false;

            DropdownSAno.Visible = true;
            divSASearch.Visible = false;

            FindCustomer();
            FillLoanInfo();
            FillSavingsInfo();
        }

        private void FindCustomer()
        {
            query = @"select * from CustInfo where CustIDNO = '" + txtIdNo.Text + "'";
            dt = db.ExecuteQuery(query);
            if (dt.Rows.Count > 0)
            {
                Session["CustMobileNo"] = dt.Rows[0]["Mobile"].ToString();
                GenerateVoucherNo();

                txtCustomerName.Text = dt.Rows[0]["CustName"].ToString();
            }
            else { }
        }

        protected void DropdownLAno_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropdownLAno.SelectedValue == "Other")
            {
                divLAsearch.Visible = true;
                DropdownLAno.Visible = false;
            }
        }

        protected void btnLASearch_Click(object sender, EventArgs e)
        {

            query = @"select * from Loan_Application where LoanNo='" + txtLANo.Text + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { }
            if (dt.Rows.Count > 0)
            {
                txtIdNo.Text = dt.Rows[0]["CustIDNO"].ToString();
                FillCustomerInfo();
            }
            else { }
        }

        protected void btnSearchSA_Click(object sender, EventArgs e)
        {
            query = @"select * from CustReg where CustAccNo = '" + txtSANo.Text + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { }
            if (dt.Rows.Count > 0)
            {
                txtIdNo.Text = dt.Rows[0]["CustIDNO"].ToString();
                FillCustomerInfo();
            }
            else { }
        }

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Session["CustMobileNo"] = "";
            Response.Redirect("~/Forms/MobileForms/MDashboard.aspx");
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

        #region LoanRegion

        private void FillLoanInfo()
        {
            query = @"select * from Loan_Application where Loan_Status='Active' and CustIDNO='" + txtIdNo.Text + "'";
            dt = db.ExecuteQuery(query);
            DropdownLAno.DataSource = dt;
            DropdownLAno.DataTextField = "LoanNo";
            DropdownLAno.DataValueField = "LoanNo";
            DropdownLAno.DataBind();
            DropdownLAno.Items.Insert(0, "select");
            DropdownLAno.Items.Insert(1, "Other");

        }

        private decimal GetLAProfit(string LA_Amount, string LANo)
        {
            decimal AmountWithProfit = decimal.Parse(LA_Amount);
            decimal ProfitPercentage = 0;

            decimal Principal = 0;
            decimal profitAmount = 0;

            query = @"select ServiceChrg from Loan_Application where LoanNo='" + LANo + "'";
            dt = db.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                ProfitPercentage = decimal.Parse(dt.Rows[0]["ServiceChrg"].ToString());
            }

            Principal = (100 * AmountWithProfit) / (100 + ProfitPercentage);
            profitAmount = AmountWithProfit - Principal;
            return profitAmount;

        }

        private void LoanInsert()
        {

            if (DropdownLAno.SelectedItem.ToString() != "select" && txtLAAmount.Text != "" && txtLAAmount.Text != null)
            {
                int insertStatus = 0;
                LoadAccSubSubCode();
                LoadLeadgerCode();

                query = @"INSERT into Loan_DataEntry (CustAccTrSL ,Profit,Notes ,Dr, EntryNo,PYear, PDate, LoanNo, Account_Sub_SubCode, Cr,TransactionType, TransactionStatus, LedgerCode, AddDate,StaffID,VoucherNo,BranchCode,UserId,EntryPlatform)
                        VALUES (" + getCustLoanCount() + " ,ROUND(" + GetLAProfit(txtLAAmount.Text, DropdownLAno.SelectedValue) + " ,2) , 'Recieved By Cash' ,0," + getCustLoanCount() + ",'" + Time_now.Year + "', '" + Time_now.Date + "','" + DropdownLAno.SelectedValue + "', '103001', " + txtLAAmount.Text + ", 'Reciepts', 'Cr', " + getLedgerCode + " , '" + DateTime.Now + "','" + getStaffID + "','" + lblVoucherNo.Text + "', '" + getBranchCode + "', '" + getStaffID + "', 'Mobile Webapp' )";
                insertStatus = db.ExecuteNonQuery(query);
                try
                {

                }
                catch (Exception exc) { throw exc; }
                if (insertStatus > 0)
                {
                    InsertLoanSchedule();
                    CheckPaymentStatus();

                    //SMS
                    Sms_Manager sms = new Sms_Manager();
                    try
                    {
                        query = @"select LoanNo,SUM(Cr) as SumAmount,COUNT(Cr) as EntryCount from Deposit_DataEntry where LoanNo='" + DropdownLAno.SelectedValue + "' group by LoanNo";
                        dt = db.ExecuteQuery(query);
                        string Balance = dt.Rows[0]["SumAmount"].ToString();

                        getCustMobileNo = Session["CustMobileNo"].ToString();
                        string msg = "Dear Sir, A/C: '" + DropdownLAno.SelectedValue + "' cash recieved by BDT:" + txtSAamount.Text + " on " + DateTime.Now + " & Balance:" + Balance + " Thanks, Safety MCL.";
                        sms.SendSMS(getCustMobileNo, msg);
                    }
                    catch (Exception) { }

                }
                else { }
            }
        }



        private string getCustLoanCount()
        {
            query = @"select COUNT(AutoSlNo)+1 as LoanEntryNo from Loan_DataEntry where LoanNo='" + DropdownLAno.SelectedValue + "'";
            try { dt = db.ExecuteQuery(query); }
            catch (Exception) { }
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["LoanEntryNo"].ToString();
            }
            else
            {
                return "1";
            }

        }

        private void LoadAccSubSubCode()
        {
            query = @"select Distinct SubDepositCodeNo, Account_Sub_SubCode from Deposit_SubScheme 
                      where SubDepositCodeNo=(select SubDepositCodeNo from CustReg where CustAccNo='" + DropdownSAno.SelectedValue + "' and Active_InActive='Active')";


            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { throw exc; }
            if (dt.Rows.Count > 0)
            {
                getAccSubSubCode = dt.Rows[0]["Account_Sub_SubCode"].ToString();
            }
        }

        //MSavingsLoan Entry is being shared In LoanInsert, LoanSchedule

        private void InsertLoanSchedule()
        {
            int ScheduleStatus = 0;

            query = @"INSERT into LoanSchedule (CustAccTrSL ,EntryNo,PDate, LoanNo, Receipt_amt, VoucherNo,TransactionType,StaffID,UserId) 
                    VALUES (" + getCustLoanCount() + " ," + getCustLoanCount() + ",'" + Time_now + "', '" + DropdownLAno.SelectedValue + "', " + txtLAAmount.Text + ", '" + lblVoucherNo.Text + "','Reciept','" + getStaffID + "','" + getStaffID + "' )";
            try { ScheduleStatus = db.ExecuteNonQuery(query); } catch (Exception exc) { throw exc; }

        }

        private void CheckPaymentStatus()
        {
            int paidStatus = 0;

            query = @"SELECT LoanNo, SUM(Dr) AS Dr, SUM(Cr) AS Cr, SUM(Dr - Cr) AS Balance FROM Loan_DataEntry GROUP BY LoanNo HAVING LoanNo='" + DropdownLAno.SelectedValue + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { throw exc; }
            if (dt.Rows.Count > 0)
            {


                Balance = double.Parse(dt.Rows[0]["Dr"].ToString());
                TotalPaid = double.Parse(dt.Rows[0]["Cr"].ToString());

                if (Balance == TotalPaid)
                {
                    query = @"INSERT into Loan_complate_members (PDate,LoanNo, Remarks) 
                                    VALUES ('" + Time_now + "', '" + DropdownLAno.SelectedValue + "', 'Paid' )";

                    try { paidStatus = db.ExecuteNonQuery(query); } catch (Exception exc) { throw exc; }
                    if (paidStatus > 0)
                    {

                        LoanStatusUpdate();
                    }
                }
                else { }

            }
        }

        private void LoanStatusUpdate()
        {
            int UpdateStatus = 0;
            query = @"Update Loan_Application set Loan_Status = 'InActive' where LoanNo = '" + DropdownLAno.SelectedValue + "' ";
            try { UpdateStatus = db.ExecuteNonQuery(query); } catch (Exception exc) { throw exc; }
        }

        #endregion

        #region SavingRegion

        private void FillSavingsInfo()
        {
            query = @"select * from CustReg where CustIDNO='" + txtIdNo.Text + "' and Active_InActive='Active'";
            //query = @"select * from CustReg where CustIDNO='" + txtIdNo.Text + "'";
            try
            {
                dt = db.ExecuteQuery(query);
            }
            catch (Exception)
            {

                throw;
            }
            if (dt.Rows.Count > 0)
            {
                DropdownSAno.DataSource = dt;
                DropdownSAno.DataTextField = "CustAccNo";
                DropdownSAno.DataValueField = "CustAccNo";
                DropdownSAno.DataBind();
                DropdownSAno.Items.Insert(0, "select");
                DropdownSAno.Items.Insert(1, "Other");
            }
        }

        private void FillSAStatusInfo()
        {
            query = @"select top 1 * from Deposit_DataEntry where CustAccNo='" + DropdownSAno.SelectedValue + "' order by PDate desc ";
            try
            {
                dt = db.ExecuteQuery(query);
            }
            catch (Exception exc)
            {

                throw exc;
            }
            if (dt.Rows.Count > 0)
            { }
        }

        protected void DropdownSAno_SelectedIndexChanged1(object sender, EventArgs e)
        {
            if (DropdownSAno.SelectedValue == "Other")
            {
                divSASearch.Visible = true;
                DropdownLAno.Visible = false;
            }
            FillSAStatusInfo();
            LoadAccSubSubCode();
        }

        private void SavingsInsert()
        {
            LoadAccSubSubCode();
            LoadLeadgerCode();
            if (DropdownSAno.SelectedItem.ToString() != "select" && txtSAamount.Text != "" && txtSAamount.Text != null)
            {
                int sInsertStatus = 0;

                //, , , Dr,Notes,CustAccTrSL
                query = @"INSERT into Deposit_DataEntry (ProfitCR,Notes,UserId,Dr,EntryNo,PYear, CustAccNo, PDate, Account_Sub_SubCode,Cr, PMonth, TransactionType, TransactionStatus, AddDate,LedgerCode,StaffID,Vou_ChqNo,BranchCode,EntryPlatform)
                    VALUES (0,'Recieved By Cash','" + getStaffID + "',0," + getSavingCount() + ",'" + Time_now.Year + "', '" + DropdownSAno.SelectedValue + "', '" + Time_now + "', " + getAccSubSubCode + ", " + txtSAamount.Text + ", '" + Time_now.Month + "', 'Receipts','Cr', '" + Time_now + "'," + getLedgerCode + " ,'" + getStaffID + "','" + lblVoucherNo.Text + "','" + getBranchCode + "', 'Mobile Webapp')";
                sInsertStatus = db.ExecuteNonQuery(query);

                if (sInsertStatus > 0)
                {
                    Sms_Manager sms = new Sms_Manager();
                    try
                    {
                        getCustMobileNo = Session["CustMobileNo"].ToString();
                        query = @"select CustAccNo,SUM(Cr) as SumAmount,COUNT(Cr) as EntryCount from Deposit_DataEntry where CustAccNo='" + DropdownSAno.SelectedValue + "' group by CustAccNo";
                        dt = db.ExecuteQuery(query);
                        string Balance = dt.Rows[0]["SumAmount"].ToString();
                        string msg = "Dear Sir, A/C:" + DropdownSAno.SelectedValue + " cash recieved by BDT:" + txtSAamount.Text + " on " + DateTime.Now + "  Balance:" + Balance + " Thanks, Safety MCL.";
                        sms.SendSMS(getCustMobileNo, msg);

                    }
                    catch (Exception) { }

                }

            }

        }

        private string getSavingCount()
        {
            query = @"select COUNT(AutoSlNo)+1 as DepoEntryNo from Deposit_DataEntry where CustAccNo='" + DropdownSAno.SelectedValue + "'";
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

        #endregion

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            LoadLeadgerCode();
            LoanInsert();
            SavingsInsert();

            BindReport();

            ClearAllTextBox();


        }

        private void ClearAllTextBox()
        {
            Session["CustMobileNo"] = null;
            //Response.Redirect("~/Forms/MobileForms/MSavingsLoan.aspx");
            txtCustomerName.Text = "";
            txtIdNo.Text = "";
            DropdownLAno.SelectedIndex = 0;
            DropdownSAno.SelectedIndex = 0;
            txtSAamount.Text = "";
            txtSANo.Text = "";
            txtLAAmount.Text = "";
            txtLANo.Text = "";
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            DropdownLAno.Visible = false;
            divLAsearch.Visible = true;
            DropdownSAno.Visible = false;
            divSASearch.Visible = true;
            Session["CustMobileNo"] = "";
            Response.Redirect("MSavingsLoan.aspx");
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

        //Report Binding

        private void BindReport()
        {
            ReportDocument crystalReport = new ReportDocument();

            query = @"Exec SelectLastLoanDepositHistory @VoucherNo='" + lblVoucherNo.Text + "', @CustID='" + txtIdNo.Text + "'";
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

                divPrint.Visible = true;

                //ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "loader()", true);
                txtIdNo.Text = "";
            }
        }

    }
}