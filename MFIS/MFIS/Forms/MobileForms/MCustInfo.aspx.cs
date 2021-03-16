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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null)
            {   //BranchCode
                getBranchCode = Session["ProjectCode"].ToString();
                GenerateSerialNumberByBranch();
            }
            else { Response.Redirect("~/Forms/Pages/LoginPage.aspx"); }

            if (!IsPostBack)
            {
                GenerateSerialNumber();

                FillDistrictCity();
                FillComAreaName();
            }
        }

        private void GenerateSerialNumberByBranch()
        {
            query = @"  select COUNT(SlNo) as LastCount from CustInfo where BranchCode='" + getBranchCode + "'";
            if (dt.Rows.Count > 0)
            {
                getSlNo = dt.Rows[0]["LastCount"].ToString();
                if (getSlNo == "0")
                {
                    getSlNo = "1";
                }
            }
            else { getSlNo = "1"; }
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

        private void FillComAreaName()
        {
            throw new NotImplementedException();
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

        }
    }
}