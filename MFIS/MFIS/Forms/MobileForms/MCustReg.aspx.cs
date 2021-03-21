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
    public partial class MCustReg : System.Web.UI.Page
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
        DateTime getAdDate;
        string getCustIDNo = "";
        string getAreaCodeForBranch = "";
        string getCustAccNo = "";
        DateTime getMaturedDate;

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null && Session["USERID"] != null)
            {   //BranchCode
                getBranchCode = Session["ProjectCode"].ToString();
                getStaffID = Session["USERID"].ToString();
            }
            else
            {
                Response.Redirect("~/Forms/Pages/LoginPage.aspx");
            }

            if (Request.QueryString["CustIDNo"] != "")
            {
                getCustIDNo = Request.QueryString["CustIDNo"];
                txtCustIDNO.Text = getCustIDNo;
                GenerateCustAccountNo();
            }
            if (!IsPostBack)
            {
                FillDropdownSubdepositCodeNo();
            }
            getAdDate = DateTime.Now;
        }

        #region AccountInfo

        private void FillDropdownSubdepositCodeNo()
        {
            query = @"select *,SubDepositCodeNo from Deposit_SubScheme ";
            dt = db.ExecuteQuery(query);
            ComSub_DepositScheme.DataSource = dt;
            ComSub_DepositScheme.DataTextField = "SubDepositCodeNo";
            ComSub_DepositScheme.DataValueField = "SubDepositCodeNo";
            ComSub_DepositScheme.DataBind();
        }


        protected void ComSub_DepositScheme_SelectedIndexChanged(object sender, EventArgs e)
        {
            GenerateCustAccountNo();
        }


        private void GenerateCustAccountNo()
        {
            int newSL = 0;

            query = @"select * from CustInfo where CustIDNO='" + txtCustIDNO.Text + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception) { }
            if (dt.Rows.Count > 0)
            {
                query = @"SELECT TOP (1) PERCENT CustInfo.BranchCode, CustReg.SlNo as lastSL FROM CustInfo 
                          INNER JOIN CustReg ON CustInfo.CustIDNO = CustReg.CustIDNO
                          WHERE (CustInfo.BranchCode = '" + getBranchCode + "') ORDER BY CustReg.SlNo desc";
                //and CustReg.CustIDNO = '" + getCustIDNo + "'
                try { dt = db.ExecuteQuery(query); } catch (Exception exc) { }
                if (dt.Rows.Count > 0)
                {
                    newSL = int.Parse(dt.Rows[0]["lastSL"].ToString()) + 1;
                    TxtSlNo.Text = newSL.ToString();
                    getCustAccNo = getBranchCode + "-" + ComSub_DepositScheme.SelectedValue + "-" + newSL;
                    txtCustAccNo.Text = getCustAccNo;
                }
                else
                {
                    getCustAccNo = getBranchCode + "-" + ComSub_DepositScheme.SelectedValue + "-" + 1;
                    txtCustAccNo.Text = getCustAccNo;
                    TxtSlNo.Text = "1";
                }
            }
            else
            {
                //Accounts Not Found
            }

        }


        protected void txtDuration_TextChanged(object sender, EventArgs e)
        {
            getMaturedDateFunc();
        }

        //returns Date
        private DateTime getMaturedDateFunc()
        {
            getMaturedDate = DateTime.Now.AddMonths(int.Parse(txtDuration.Text));
            return getMaturedDate;
        }


        protected void btnSubmitAccountInfo_Click(object sender, EventArgs e)
        {
            int insertStatus = 0;
            try
            {

                query = @"INSERT into CustReg (SlNo,Pyear,PDate,CustIDNO,CustAccNo,SubDepositCodeNo,DurationOfMonth,MaturedDate,MInterest,InterestDrawStatus,Active_InActive,Active_InActive_Date,MemStatus) 
                      VALUES ('" + TxtSlNo.Text + "','" + getAdDate.Year + "', '" + getAdDate + "', '" + txtCustIDNO.Text + "', '" + getCustAccNo + "','" + ComSub_DepositScheme.SelectedValue + "', " + txtDuration.Text + ", '" + getMaturedDateFunc() + "'," + TxtMIntr.Text + ",'" + ComInterestDrawStatus.SelectedValue + "','Active', '" + DateTime.Now + "', 'Active' )";
                insertStatus = db.ExecuteNonQuery(query);
            }
            catch (Exception exc) { throw exc; }
            if (insertStatus > 0)
            {
                Response.Redirect("~/Forms/MobileForms/MCustReg.aspx?CustIDNo=" + getCustIDNo + "&CustAccNo=" + getCustAccNo);
            }
        }

        #endregion

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


    }

}