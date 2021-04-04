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
    public partial class MSavingsLoan : System.Web.UI.Page
    {

        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string getBranchCode = "";
        string getStaffID = "";
        string getSubDepositCode = "";
        string getAccSubSubCode = "";
        DateTime Time_now;
        double Balance, TotalPaid = 0;


        protected void Page_Load(object sender, EventArgs e)
        {
            Time_now = DateTime.Now.Date;
            txtDate.Text = Time_now.ToString();

            if (Session["ProjectCode"] != null && Session["USERID"] != null && Session["SubDepositCode"] != null)
            {   //BranchCode
                lblStaffName.Text = Session["StaffName"].ToString();

                getBranchCode = Session["ProjectCode"].ToString();
                getStaffID = Session["USERID"].ToString();
                getSubDepositCode = Session["SubDepositCode"].ToString();

            }
            else { Response.Redirect("~/Forms/Pages/LoginPage.aspx"); }
        }

        private void GenerateVoucherNo()
        {
            string GeneratedVoucher = txtIdNo.Text + '-' + DateTime.Now.ToString("yyyy-MM-dd-HHmmss-ffff");
            lblVoucherNo.Text = GeneratedVoucher;
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

        protected void DropdownLAno_SelectedIndexChanged(object sender, EventArgs e)
        {

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
            FillLoanInfo();
            FindCustomer();
            FillSavingsInfo();
        }

        private void FindCustomer()
        {
            query = @"select * from CustInfo where CustIDNO = '" + txtIdNo.Text + "'";
            dt = db.ExecuteQuery(query);
            if (dt.Rows.Count > 0)
            {
                GenerateVoucherNo();

                txtCustomerName.Text = dt.Rows[0]["CustName"].ToString();
            }
            else { }
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
        }



        private void LoanInsert()
        {
            if (DropdownLAno.SelectedItem.ToString() != "select" && txtLAAmount.Text != "" && txtLAAmount.Text != null)
            {
                int insertStatus = 0;

                //LedgerCode=1101002
                //Acc Sub subcode=103001
                LoadAccSubSubCode();
                //EntryNo, Notes, Profit, CustAccTrSL,Dr, Profit,  [Excluded]
                query = @"INSERT into Loan_DataEntry (PYear, PDate, LoanNo, Account_Sub_SubCode, Cr,TransactionType, TransactionStatus, LedgerCode, AddDate,StaffID,VoucherNo,BranchCode,UserId)
                        VALUES ('" + Time_now.Year + "', '" + Time_now.Date + "','" + DropdownLAno.SelectedValue + "', '" + getAccSubSubCode + "', " + txtLAAmount.Text + ", 'Reciept', 'Cr', 1101002, '" + DateTime.Now + "','" + getStaffID + "','" + lblVoucherNo.Text + "', '" + getBranchCode + "', '" + getStaffID + "' )";
                try
                {
                    insertStatus = db.ExecuteNonQuery(query);
                }
                catch (Exception exc) { throw exc; }
                if (insertStatus > 0)
                {
                    InsertLoanSchedule();
                    CheckPaymentStatus();

                    DropdownLAno.SelectedItem.Text = "select";
                    txtLAAmount.Text = "";
                }
                else { }
            }
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

        private void InsertLoanSchedule()
        {
            int ScheduleStatus = 0;

            //EntryNo, [Excluded]
            query = @"INSERT into LoanSchedule (PDate, LoanNo, Receipt_amt, VoucherNo,TransactionType,StaffID,UserId) 
                    VALUES ('" + Time_now.Date + "', '" + DropdownLAno.SelectedValue + "', " + txtLAAmount.Text + ", '" + lblVoucherNo.Text + "','Reciept','" + getStaffID + "','" + getStaffID + "' )";
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
            query = @"select * from CustReg where CustIDNO='" + txtIdNo.Text + "'";
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
            FillSAStatusInfo();
        }

        private void SavingsInsert()
        {
            if (DropdownSAno.SelectedItem.ToString() != "select" && txtSAamount.Text != "" && txtSAamount.Text != null)
            {
                int sInsertStatus = 0;

                //, , EntryNo, Dr,Notes,CustAccTrSL
                query = @"INSERT into Deposit_DataEntry (PYear, CustAccNo, PDate, Account_Sub_SubCode,Cr, PMonth, TransactionType, TransactionStatus, AddDate,LedgerCode,StaffID,Vou_ChqNo,BranchCode)
                    VALUES ('" + Time_now.Year + "', '" + DropdownSAno.SelectedValue + "', '" + Time_now.Date + "', '203001112', " + txtSAamount.Text + ", '" + Time_now.Month + "', 'Receipts','Cr', '" + Time_now.Date + "','1101002' ,'1241','" + lblVoucherNo.Text + "','" + getBranchCode + "')";
                try
                {
                    sInsertStatus = db.ExecuteNonQuery(query);
                }
                catch (Exception) { }
                if (sInsertStatus > 0)
                {
                    DropdownSAno.SelectedItem.Text = "select";
                    txtSAamount.Text = "";
                }

            }

        }

        #endregion

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            LoanInsert();
            SavingsInsert();
            BindReport();


        }

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

                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "notify()", true);
                txtIdNo.Text = "";
            }
        }
    }
}