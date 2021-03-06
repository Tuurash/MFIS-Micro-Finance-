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

        private void FillCustomerDropdown()
        {
            query = @"select * from CustInfo ";
            dt = db.ExecuteQuery(query);
            ComSub_DepositScheme.DataSource = dt;
            ComSub_DepositScheme.DataTextField = "CustIDNO";
            ComSub_DepositScheme.DataValueField = "CustIDNO";
            ComSub_DepositScheme.DataBind();
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

            query = @"select * from CustReg where CustIDNO = '" + txtCustIDNO.Text + "' Order by SlNo";
            FillGrid(query);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string SubDepositCodeNo = btn.CommandArgument.ToString();

            query = @"select * from CustReg where SubDepositCodeNo = '" + SubDepositCodeNo + "' and CustIDNO='" + txtCustIDNO.Text + "'";
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
    }
}