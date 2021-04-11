using MFIS.Models;
using MFIS.Pages;
using MFIS.Services;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;

namespace MFIS.Forms.MobileForms
{
    public partial class MCustInfo : System.Web.UI.Page
    {
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null && Session["USERID"] != null)
            {   //BranchCode
                lblStaffName.Text = Session["StaffName"].ToString();

                getBranchCode = Session["ProjectCode"].ToString();
                getStaffID = Session["USERID"].ToString();
                GenerateSerialNumberByBranch();
                GenerateSerialNumber();
                GetAreaCode();
            }
            else { Response.Redirect("~/Forms/Pages/LoginPage.aspx"); }

            if (!IsPostBack)
            {
                try { GenerateCustIDNo(); } catch (Exception) { }
                FillDistrictCity();
            }
            getAdDate = DateTime.Now;
        }

        private void GetAreaCode()
        {
            query = @"select AreaCode from Area_StaffWise where BranchCode='" + getBranchCode + "' and StaffID='" + getStaffID + "' and Status='Active'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { }
            if (dt.Rows.Count != 0)
            {
                getAreaCodeForBranch = dt.Rows[0]["AreaCode"].ToString();
            }
        }

        private string GenerateCustIDNo()
        {
            getCustIDNo = getBranchCode + "-" + int.Parse(getSlNo).ToString("D6");
            txtCustIDNO.Text = getCustIDNo;
            return getCustIDNo;
        }

        private void GenerateSerialNumberByBranch()
        {
            query = @"select MAX(SlNo)+1 as LastCount from CustInfo where BranchCode='" + getBranchCode + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception) { }

            if (dt.Rows.Count > 0)
            {
                getSlNo = dt.Rows[0]["LastCount"].ToString();
                if (getSlNo == "0" || getSlNo == null)
                {
                    getSlNo = 1.ToString("D6");
                }
            }
            else { getSlNo = 1.ToString("D6"); }
        }

        private void GenerateSerialNumber()
        {
            query = @"SELECT MAX(SlNoAll)+1 AS SlNoAll FROM CustInfo";
            dt = db.ExecuteQuery(query);
            if (dt.Rows.Count > 0)
            {
                getSlNoAll = int.Parse(dt.Rows[0]["SlNoAll"].ToString()).ToString();
            }
            else { getSlNoAll = "1"; }

        }

        private void FillDistrictCity()
        {
            Datum obj_District = new Datum();
            string json = File.ReadAllText(Server.MapPath("../DistrictList.json"));
            // Create JavascriptSerializer object
            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
            List<Datum> ob = new List<Datum>();
            ob = JsonConvert.DeserializeObject<List<Datum>>(json);
            ob = ob.ToList();
            var finalList = ob.OrderBy(x => x.name).ToList();
            TxtCityDistrict.DataSource = finalList;
            TxtCityDistrict.DataTextField = "name";
            TxtCityDistrict.DataValueField = "name";
            TxtCityDistrict.DataBind();
        }

        //CustInfo
        protected void btnSubmitCustInfo_Click(object sender, EventArgs e)
        {
            InsertCustInfo();
        }

        private void InsertCustInfo()
        {
            int insertStatus = 0;
            if (txtCustIDNO.Text != "")
            {
                query = @"INSERT into CustInfo (SlNoAll,SlNo,AdDate,BranchCode,AreaCode,CustIDNO,AccType,AccName,CustName,Sex,DateOfBirth,CityDistrict,Mobile,NIDNo,AccName_Bangla) 
                      VALUES (" + getSlNoAll + "," + getSlNo + ", '" + getAdDate + "','" + getBranchCode + "'," + getAreaCodeForBranch + ", '" + GenerateCustIDNo() + "', '" + ComAccType.SelectedValue + "', '" + TxtCustName.Text + "','" + TxtCustName.Text + "','" + ComSex.SelectedValue + "','" + TxtDOB.Text + "','" + TxtCityDistrict.SelectedValue + "','" + TxtMobileNo.Text + "','" + TxtNIDNo.Text.Trim() + "','" + Translate(TxtCustName.Text) + "')";


            }
            try { insertStatus = db.ExecuteNonQuery(query); }
            catch (Exception exc) { throw exc; }
            if (insertStatus != 0)
            {
                Session["CustMobileNo"] = TxtMobileNo.Text;
                Sms_Manager sms = new Sms_Manager();
                try
                {
                    string msg = "Dear Sir, An Account has been opened for you on " + DateTime.Now.Date + " Your ID No " + txtCustIDNO.Text + " Thanks, Safety MCL.";
                    sms.SendSMS(TxtMobileNo.Text, msg);
                }
                catch (Exception) { }
                getCustIDNo = GenerateCustIDNo();
                ShowCustInfoScuccessMsg();
                Response.Redirect("~/Forms/MobileForms/MCustReg.aspx?CustIDNo=" + getCustIDNo);
            }
        }

        private void ShowCustInfoScuccessMsg()
        {
            lblCustinfoStatus.Text = "Success! Proceed To Accounts.";
            lblCustinfoStatus.Visible = true;
        }


        #region Services

        private string Translate(string input)
        {
            string Translated_Text = "";
            Translator t = new Translator();
            string bengaliSpeech = "";
            try
            {
                Translated_Text = t.Translate(input.Trim(), "English", "Bengali");
                if (t.Error == null)
                {

                    bengaliSpeech = t.TranslationSpeechUrl;
                }
                else
                {
                    // MessageBox.Show(t.Error.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }

            }
            catch (Exception ex)
            {
                //MessageBox.Show(ex.Message, this.Text, MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

            return Translated_Text;

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



        #endregion

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Forms/MobileForms/MDashboard.aspx");
        }
    }
}