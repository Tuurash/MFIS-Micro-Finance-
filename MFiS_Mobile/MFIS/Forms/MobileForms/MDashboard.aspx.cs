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
    public partial class MDashboard : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string getBranchCode = "";
        string getStaffID = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null && Session["USERID"] != null)
            {   //BranchCode
                lblStaffName.Text = Session["StaffName"].ToString();

                getBranchCode = Session["ProjectCode"].ToString();
                getStaffID = Session["USERID"].ToString();

            }
            else { Response.Redirect("~/Forms/Pages/LoginPage.aspx"); }
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


        protected void btnNwEntry_Click(object sender, EventArgs e)
        {
            Response.Redirect("MCustInfo.aspx");
        }


        protected void btnLS_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Forms/MobileForms/MSavingsLoan.aspx");
        }

    }
}