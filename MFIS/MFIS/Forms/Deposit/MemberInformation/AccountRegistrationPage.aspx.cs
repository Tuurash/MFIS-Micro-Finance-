using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Views
{
    public partial class AccountRegistrationPage : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string CustomerID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            GenerateSerialNumber();
            if (Request.QueryString["CustomerID"] != null)
            {
                CustomerID = Request.QueryString["CustomerID"];
                FillCustomerInfo(CustomerID);
            }

            if (!IsPostBack)
            {
                FillSchemeDropdown();
                FillCustomerDropdown();
            }

        }

        private void GenerateSerialNumber()
        {
            query = @"SELECT MAX(SlNo) AS SlNoAll FROM CustReg";
            dt = db.ExecuteQuery(query);
            if (dt.Rows.Count > 0)
            {
                TxtSlNo.Text = (int.Parse(dt.Rows[0]["SlNoAll"].ToString()) + 1).ToString();
            }
            else { TxtSlNo.Text = "1"; }

        }

        private void FillCustomerDropdown()
        {
            query = @"select * from CustInfo ";
            dt = db.ExecuteQuery(query);
            txtCustIDNO.DataSource = dt;
            txtCustIDNO.DataTextField = "CustIDNO";
            txtCustIDNO.DataValueField = "CustIDNO";
            txtCustIDNO.DataBind();
            if (CustomerID != "")
            {
                txtCustIDNO.SelectedValue = CustomerID;
            }
        }

        private void FillSchemeDropdown()
        {
            query = @"select *,SubDepositCodeNo+': '+SubDepositName as Name from Deposit_SubScheme ";
            dt = db.ExecuteQuery(query);
            ComSub_DepositScheme.DataSource = dt;
            ComSub_DepositScheme.DataTextField = "Name";
            ComSub_DepositScheme.DataValueField = "SubDepositCodeNo";
            ComSub_DepositScheme.DataBind();
        }

        private void FillGrid(string query)
        {
            dt = db.ExecuteQuery(query);
            DataGrid.DataSource = dt;
            DataGrid.DataBind();
        }

        private void FillCustomerInfo(string customerID)
        {
            query = @"select * from CustInfo where CustIDNO='" + CustomerID + "'";
            dt = db.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                txtCustIDNO.Text = dt.Rows[0]["CustIDNO"].ToString();
                TxtCustName.Text = dt.Rows[0]["CustName"].ToString();

            }

            query = @"select * from CustReg where CustIDNO = '" + CustomerID + "' Order by SlNo";
            FillGrid(query);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string CustAccNo = btn.CommandArgument.ToString();

            query = @"select * from CustReg where CustAccNo = '" + CustAccNo + "' and CustIDNO='" + txtCustIDNO.Text + "'";
            dt = db.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                TxtSlNo.Text = dt.Rows[0]["SlNo"].ToString();
                TxtMIntr.Text = dt.Rows[0]["MInterest"].ToString();
                TxtMaturedDate.Text = dt.Rows[0]["MaturedDate"].ToString();
                txtCustAccNo.Text = dt.Rows[0]["CustAccNo"].ToString();
                txtDuration.Text = dt.Rows[0]["DurationOfMonth"].ToString();
                ComActive_InActive.SelectedValue = dt.Rows[0]["Active_InActive"].ToString();
                //ComSub_DepositScheme.SelectedValue = dt.Rows[0]["SubDepositCodeNo"].ToString();
                txtIssueDate.Text = dt.Rows[0]["PDate"].ToString();
            }
        }

        protected void btnViewCustomer_Click(object sender, EventArgs e)
        {
            FillCustomerInfo(txtCustIDNO.Text);
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            int insertStatus = 0;
            try
            {

                query = @"INSERT into CustReg (SlNo,Pyear,PDate,CustIDNO,CustAccNo,SubDepositCodeNo,DurationOfMonth,MaturedDate,MInterest,InterestDrawStatus,Active_InActive,SV_AccNo,Active_InActive_Date) 
                      VALUES ('" + TxtSlNo.Text + "','" + DateTime.Parse(txtIssueDate.Text).Year + "', '" + txtIssueDate.Text + "', '" + txtCustIDNO.SelectedValue + "', '" + txtCustAccNo.Text + "','" + ComSub_DepositScheme.SelectedValue + "', " + txtDuration.Text + ", '" + TxtMaturedDate.Text + "'," + TxtMIntr.Text + ",'" + ComInterestDrawStatus.SelectedValue + "','" + ComActive_InActive.SelectedValue + "','" + TxtSV_AccNo.Text + "', '" + DateTime.Now + "' )";
                insertStatus = db.ExecuteNonQuery(query);
            }
            catch (Exception exc) { throw exc; }
            if (insertStatus > 0)
            {
                FillCustomerInfo(txtCustIDNO.Text);
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int insertStatus = 0;
            try
            {
                //Comments, MemStatus avoided
                //,'"+txtPYear.Text & "' pyear avoided
                query = @"Update CustReg Set SubDepositCodeNo = '" + ComSub_DepositScheme.SelectedValue + "' , DurationOfMonth = " + txtDuration.Text + ", MaturedDate = '" + TxtMaturedDate.Text + "', InterestDrawStatus = '" + ComInterestDrawStatus.Text + "', MInterest = " + TxtMIntr.Text + " ,Active_InActive = '" + ComActive_InActive.SelectedValue + "', SV_AccNo = '" + TxtSV_AccNo.Text + "',Active_InActive_Date = '" + DateTime.Now + "' where CustAccNo = '" + txtCustAccNo.Text + "' ";
                insertStatus = db.ExecuteNonQuery(query);
            }
            catch (Exception exc) { throw exc; }
            if (insertStatus > 0)
            {
                FillCustomerInfo(txtCustIDNO.Text);
            }
        }

        protected void btnNominee_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Forms/Deposit/MemberInformation/NomineePage.aspx?CustAcNo=" + txtCustAccNo.Text);
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clearAll();
        }

        private void clearAll()
        {
            txtIssueDate.Text = "";
            txtCustAccNo.Text = "";

            txtDuration.Text = "";
            TxtMIntr.Text = "";

            TxtSlNo.Text = "";
            TxtMaturedDate.Text = "";
            ComActive_InActive.SelectedValue = "Active";
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int DeleteStatus = 0;
            if (txtCustAccNo.Text != "")
            {
                try
                {
                    query = @"Delete from CustReg where CustAccNo = '" + txtCustAccNo.Text + "' ";
                    DeleteStatus = db.ExecuteNonQuery(query);
                }
                catch (Exception exc) { throw exc; }
                if (DeleteStatus > 0)
                {
                    FillCustomerInfo(txtCustIDNO.Text);
                }
            }

        }

    }
}