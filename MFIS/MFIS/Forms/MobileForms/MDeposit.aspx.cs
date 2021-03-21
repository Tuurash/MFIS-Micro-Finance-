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
        DateTime getAdDate;
        string getCustIDNo = "";
        string getAreaCodeForBranch = "";
        string getCustAccNo = "";
        DateTime getMaturedDate;

        #endregion


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSkip_Click(object sender, EventArgs e)
        {

        }

        protected void btnSaveDeposit_Click(object sender, EventArgs e)
        {

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

        protected void txtAmount_TextChanged(object sender, EventArgs e)
        {

        }
    }
}