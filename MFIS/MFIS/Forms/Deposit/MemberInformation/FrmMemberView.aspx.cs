using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Forms.MemberInformation
{
    public partial class AccountDetailsPage : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();
        string AutoGenSlNo = "";
        string CustomerID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (txtSearch.Text != "")
                {
                    this.SearchByAccountName();
                }
                else
                {
                    FillGridAccountList();
                }
            }
        }

        public void LoadGrid(string query)
        {
            dt = db.ExecuteQuery(query);
            GridAccountList.DataSource = dt;
            GridAccountList.DataBind();
        }

        private void FillGridAccountList()
        {
            query = @"select * from CustInfo";
            LoadGrid(query);
        }

        protected void GridAccountList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            FillGridAccountList();
            GridAccountList.PageIndex = e.NewPageIndex;
            GridAccountList.DataBind();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            AutoGenSlNo = btn.CommandArgument.ToString();

            Response.Redirect("~/Forms/Deposit/MemberInformation/FrmCustInfo.aspx?AutoGenSlNo=" + AutoGenSlNo);
        }

        protected void Search(object sender, EventArgs e)
        {
            SearchByAccountName();
        }

        private void SearchByAccountName()
        {
            query = @"select * from CustInfo where AccName like '%" + txtSearch.Text + "%'";
            LoadGrid(query);
        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            GridAccountList.PageIndex = e.NewPageIndex;
            this.SearchByAccountName();
        }

        protected void dropDownSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dropDownSort.SelectedValue != "SortBy")
            {
                query = @"select * from CustInfo order by " + dropDownSort.SelectedValue + "";
                LoadGrid(query);
            }
            else
            {
                FillGridAccountList();
            }
        }

        protected void btnAccountReg_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            CustomerID = btn.CommandArgument.ToString();
            Response.Redirect("~/Forms/Deposit/MemberInformation/AccountRegistrationPage.aspx?CustomerID=" + CustomerID);
        }

    }

}