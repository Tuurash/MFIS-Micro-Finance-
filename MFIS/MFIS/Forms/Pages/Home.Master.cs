using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Forms.Pages
{
    public partial class Home : System.Web.UI.MasterPage
    {
        DataTable dt = new DataTable();
        DBConnector db = new DBConnector();

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                if (Session["USERID"] == null)
                {
                    //Session["USERID"] = "1";
                    //Session["ProjectCode"] = "1";
                    //Session["USER_NAME"] = "GNIS";
                    //Session["EMP_ID"] = "GPAC";
                    //Session["USER_NAME"] = "Demo";
                    //Session["EMP_ID"] = "GPAC";

                    Response.Redirect("LoginPage.aspx");
                }

            }
        }


        protected void btnSignout_Click(object sender, EventArgs e)
        {
            string DELETEUser_Now = @"DELETE FROM User_Now WHERE(UserID = '" + Session["USERID"].ToString() + "')";

            try
            {
                db.ExecuteNonQuery(DELETEUser_Now);

            }
            catch (Exception)
            {

                throw;
            }

            HttpContext.Current.Session["USERID"] = null;
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.RemoveAll();
            HttpContext.Current.Session.Abandon();
            Response.Redirect("~/default.aspx");
        }
    }
}