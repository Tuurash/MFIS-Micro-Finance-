using MFIS.Forms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Forms.Deposit.LoanDeposit
{
    public partial class frmMSavingsLoan : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();
        DateTime Time_now;

        double Balance, TotalPaid = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            Time_now = DateTime.Now.Date;
            txtDate.Text = Time_now.ToString();

        }

        private void GenerateVoucherNo()
        {
            string GeneratedVoucher = txtIdNo.Text + '-' + DateTime.Now.ToString("yyyy-MM-dd-HHmmss-ffff");
            lblVoucherNo.Text = GeneratedVoucher;
        }

        protected void txtIdNo_TextChanged(object sender, EventArgs e)
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
                ErrorTxtID.Visible = false;
                maindiv.Visible = true;
                txtCustomerName.Text = dt.Rows[0]["CustName"].ToString();
            }
            else { ErrorTxtID.Visible = true; maindiv.Visible = false; txtCustomerName.Text = ""; }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FindCustomer();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            LoanInsert();
            SavingsInsert();
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

        protected void DropdownLAno_SelectedIndexChanged(object sender, EventArgs e)
        {
            string getLoanNo = DropdownLAno.SelectedValue;

            query = @"select top 1 * from LoanSchedule where LoanNo = '" + getLoanNo + "' order by PDate desc";
            try
            {
                dt = db.ExecuteQuery(query);

            }
            catch (Exception exc) { throw exc; }
            if (dt.Rows.Count > 0)
            {
                divLoanStatus.Visible = true;
                AmountPayable.InnerText = "Payable: " + dt.Rows[0]["Recievable_amt"].ToString();
                LastPaidDate.InnerText = "Last Entry: " + dt.Rows[0]["PDate"].ToString();
            }
            else { divLoanStatus.Visible = true; }
        }

        private void LoanInsert()
        {
            if (DropdownLAno.SelectedItem.ToString() != "select" && txtLAAmount.Text != "")
            {
                int insertStatus = 0;

                //LedgerCode=1101002
                //Acc Sub subcode=103001
                //BranchCode, EntryNo, Notes, Profit, CustAccTrSL,Dr, Profit, UserId [Excluded]
                query = @"INSERT into Loan_DataEntry (PYear, PDate, LoanNo, Account_Sub_SubCode, Cr,TransactionType, TransactionStatus, LedgerCode, AddDate,StaffID,VoucherNo)
                        VALUES ('" + Time_now.Year + "', '" + Time_now.Date + "','" + DropdownLAno.SelectedValue + "', 103001, " + txtLAAmount.Text + ", '" + DropdownTransType.SelectedValue + "', 'Cr', 1101002, '" + DateTime.Now + "','1241','" + lblVoucherNo.Text + "' )";
                try
                {
                    insertStatus = db.ExecuteNonQuery(query);
                }
                catch (Exception exc) { throw exc; }
                if (insertStatus > 0)
                {
                    InsertLoanSchedule();
                    CheckPaymentStatus();
                }
                else { }
            }
        }

        private void InsertLoanSchedule()
        {
            int ScheduleStatus = 0;

            //EntryNo,UserId [Excluded]
            query = @"INSERT into LoanSchedule (PDate, LoanNo, Receipt_amt, VoucherNo,TransactionType,StaffID) 
                    VALUES ('" + Time_now.Date + "', '" + DropdownLAno.SelectedValue + "', " + txtLAAmount.Text + ", '" + lblVoucherNo.Text + "','" + DropdownTransType.SelectedValue + "','" + txtIdNo.Text + "' )";
            try { ScheduleStatus = db.ExecuteNonQuery(query); } catch (Exception exc) { throw exc; }

        }

        private void CheckPaymentStatus()
        {
            int paidStatus = 0;

            query = @"SELECT LoanNo, SUM(Dr) AS Dr, SUM(Cr) AS Cr, SUM(Dr - Cr) AS Balance FROM Loan_DataEntry GROUP BY LoanNo HAVING LoanNo='" + DropdownLAno.SelectedValue + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { throw exc; }
            if (dt.Rows.Count > 0)
            {
                divPaymentStatus.Visible = true;

                Balance = double.Parse(dt.Rows[0]["Dr"].ToString());
                TotalPaid = double.Parse(dt.Rows[0]["Cr"].ToString());

                if (Balance == TotalPaid)
                {
                    query = @"INSERT into Loan_complate_members (PDate,LoanNo, Remarks) 
                                    VALUES ('" + Time_now + "', '" + DropdownLAno.SelectedValue + "', 'Paid' )";

                    try { paidStatus = db.ExecuteNonQuery(query); } catch (Exception exc) { throw exc; }
                    if (paidStatus > 0)
                    {
                        lblPaymentStatus.InnerText = "Loan Status Changed.";
                        LoanStatusUpdate();
                    }
                }
                else { lblPaymentStatus.InnerText = "Payment Successfull" + txtLAAmount.Text + " tk"; }

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

        protected void DropdownSAno_SelectedIndexChanged(object sender, EventArgs e)
        {
            divSAStatus.Visible = true;
            FillSAStatusInfo();
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
            {
                divSAStatus.Visible = true;
                txtSAlastpaidDate.InnerText = "Last Entry: " + dt.Rows[0]["PDate"].ToString();
                txtSALastPaidAmount.InnerText = "Amount: " + dt.Rows[0]["Cr"].ToString();
            }
        }

        private void SavingsInsert()
        {
            if (DropdownSAno.SelectedItem.ToString() != "select" && txtSAamount.Text != "")
            {
                int sInsertStatus = 0;

                //, BranchCode, EntryNo, Dr,Notes,CustAccTrSL,Vou_ChqNo
                query = @"INSERT into Deposit_DataEntry (PYear, CustAccNo, PDate, Account_Sub_SubCode,Cr, PMonth, TransactionType, TransactionStatus, AddDate,LedgerCode,StaffID)
                    VALUES ('" + Time_now.Year + "', '" + DropdownSAno.SelectedValue + "', '" + Time_now.Date + "', '203001112', " + txtSAamount.Text + ", '" + Time_now.Month + "', 'Receipts','Cr', '" + Time_now.Date + "','1101002' ,'1241')";
                try
                {
                    sInsertStatus = db.ExecuteNonQuery(query);
                }
                catch (Exception exc)
                {

                    throw;
                }
                if (sInsertStatus > 0)
                {
                    lblSAPaymentStatus.InnerText = "Deposit Entry Done: " + txtSAamount.Text + " taka";
                }

            }

        }

        #endregion

        protected void btnShow_Click(object sender, EventArgs e)
        {
            string CustomerID = txtIdNo.Text;
            Response.Redirect("~/Forms/Deposit/LoanDeposit/frmDepositGrid.aspx?CustomerID=" + CustomerID);
        }


    }

}
