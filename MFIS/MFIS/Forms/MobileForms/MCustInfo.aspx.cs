using MFIS.Forms.Pages;
using MFIS.Models;
using MFIS.Pages;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
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
        string getSlNoAll = "";
        string getSlNo = "";
        DateTime getAdDate;
        string getCustIDNo = "";
        string getAreaCodeForBranch = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null)
            {   //BranchCode
                getBranchCode = Session["ProjectCode"].ToString();
                GenerateSerialNumberByBranch();
                GenerateCustIDNo();
                GenerateSerialNumber();
                GetAreaCode();
            }
            else { Response.Redirect("~/Forms/Pages/LoginPage.aspx"); }

            if (!IsPostBack)
            {
                FillDistrictCity();
            }
            getAdDate = DateTime.Now;
        }

        private void GetAreaCode()
        {
            query = @"  select AreaCode from Area where BranchCode='" + getBranchCode + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception exc) { }
            if (dt.Rows.Count != 0)
            {
                getAreaCodeForBranch = dt.Rows[0]["AreaCode"].ToString();
            }
        }

        private void GenerateCustIDNo()
        {
            getCustIDNo = getBranchCode + "-" + int.Parse(getSlNo) + 1.ToString("D6"); ;
            txtCustIDNO.Text = getCustIDNo;
        }

        private void GenerateSerialNumberByBranch()
        {
            query = @"select MAX(SlNo) as LastCount from CustInfo where BranchCode='" + getBranchCode + "'";
            try { dt = db.ExecuteQuery(query); } catch (Exception) { }

            if (dt.Rows.Count > 0)
            {
                getSlNo = int.Parse(dt.Rows[0]["LastCount"].ToString()) + 1.ToString();
                if (getSlNo == "0" || getSlNo == null)
                {
                    getSlNo = 1.ToString("D6");
                }
            }
            else { getSlNo = 1.ToString("D6"); }
        }

        private void GenerateSerialNumber()
        {
            query = @"SELECT MAX(SlNoAll) AS SlNoAll FROM CustInfo";
            dt = db.ExecuteQuery(query);
            if (dt.Rows.Count > 0)
            {
                getSlNoAll = (int.Parse(dt.Rows[0]["SlNoAll"].ToString()) + 1).ToString();
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
            TxtCityDistrict.DataSource = ob;
            TxtCityDistrict.DataTextField = "name";
            TxtCityDistrict.DataValueField = "name";
            TxtCityDistrict.DataBind();
        }

        protected void btnSubmitCustInfo_Click(object sender, EventArgs e)
        {
            int insertStatus = 0;
            if (txtCustIDNO.Text != "")
            {
                query = @"INSERT into CustInfo (SlNoAll,SlNo,AdDate,BranchCode,AreaCode,CustIDNO,AccType,AccName,CustName,Sex,DateOfBirth,CityDistrict,Mobile,NIDNo,AccName_Bangla) 
                      VALUES (" + getSlNoAll + "," + getSlNo + ", '" + getAdDate + "','" + getBranchCode + "'," + getAreaCodeForBranch + ", '" + getCustIDNo + "', '" + ComAccType.SelectedValue + "', '" + TxtCustName.Text + "','" + TxtCustName.Text + "','" + ComSex.SelectedValue + "','" + TxtDOB.Text + "','" + TxtCityDistrict.SelectedValue + "','" + TxtMobileNo.Text + "','" + TxtNIDNo.Text.Trim() + "','" + Translate(TxtCustName.Text) + "')";


            }
            try { insertStatus = db.ExecuteNonQuery(query); }
            catch (Exception exc) { throw exc; }
            if (insertStatus != 0) { }
        }


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
    }
}