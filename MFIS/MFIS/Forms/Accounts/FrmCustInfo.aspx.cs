﻿using MFIS.Models;
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


namespace MFIS.Forms.Accounts
{
    public partial class FrmCustInfo : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        int AutoGenSlNo = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProjectCode"] != null)
            {
                txtPrjCode.Text = Session["ProjectCode"].ToString();

            }
            else { Response.Redirect("~/Forms/Pages/LoginPage.aspx"); }
            //GetDeviceInfo();
            if (Request.QueryString["AutoGenSlNo"] != null)
            {
                AutoGenSlNo = int.Parse(Request.QueryString["AutoGenSlNo"]);
                FillFromAutoGen(AutoGenSlNo);
            }
            else
            {
                try
                {
                    GenerateSerialNumber();
                }
                catch (Exception exc) { throw exc; }
            }

            if (!IsPostBack)
            {
                FillDistrictCity();
                FillComAreaName();
            }
        }

        private void FillDistrictCity()
        {
            Datum obj_District = new Datum();

            string json = File.ReadAllText(Server.MapPath("DistrictList.json"));

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

        private void FillFromAutoGen(int autoGenSlNo)
        {
            query = @"select * from CustInfo where AutoSLNo =" + autoGenSlNo;
            dt = db.ExecuteQuery(query);

            FillTextbox(dt);

        }

        private void FillTextbox(DataTable dt)
        {
            if (dt.Rows.Count > 0)
            {
                TxtSlNoAll.Text = dt.Rows[0]["SlNoAll"].ToString();
                //TxtSlNo.Text = dt.Rows[0]["SlNo"].ToString();
                txtCustIDNO.Text = dt.Rows[0]["CustIDNO"].ToString();
                TxtAccName.Text = dt.Rows[0]["AccName"].ToString();
                TxtCustName.Text = dt.Rows[0]["CustName"].ToString();
                TxtFName.Text = dt.Rows[0]["FName"].ToString();
                TxtMName.Text = dt.Rows[0]["MName"].ToString();
                TxtSpouse.Text = dt.Rows[0]["SpouseName"].ToString();
                TxtParmanent_Add.Text = dt.Rows[0]["Parmanent_Add"].ToString();
                TxtPresent_Add.Text = dt.Rows[0]["Present_Add"].ToString();
                TxtPS.Text = dt.Rows[0]["PS"].ToString();
                TxtCityDistrict.SelectedValue = dt.Rows[0]["CityDistrict"].ToString();

                TxtDOB.Text = dt.Rows[0]["DateOfBirth"].ToString();
                TxtAdDate.Text = dt.Rows[0]["AdDate"].ToString();

                TxtPostCode.Text = dt.Rows[0]["PostCode"].ToString();
                TxtCountry.Text = dt.Rows[0]["Country"].ToString();
                TxtTel.Text = dt.Rows[0]["Tel"].ToString();
                TxtMobileNo.Text = dt.Rows[0]["Mobile"].ToString();
                TxtMail.Text = dt.Rows[0]["Mail"].ToString();
                TxtRefAccNo.Text = dt.Rows[0]["RefAccNo"].ToString();
                TxtRefName.Text = dt.Rows[0]["RefName"].ToString();
                TxtNIDNo.Text = dt.Rows[0]["NIDNo"].ToString();

                ComAccType.SelectedValue = dt.Rows[0]["AccType"].ToString();
                ComSex.SelectedValue = dt.Rows[0]["Sex"].ToString();
                CmbAreaCode.SelectedValue = dt.Rows[0]["AreaCode"].ToString();
                TxtOccupation.SelectedValue = dt.Rows[0]["Occupation"].ToString();
                ComReligion.SelectedValue = dt.Rows[0]["Religion"].ToString();
            }
        }

        public void ClearAll()
        {

            TxtSlNoAll.Text = txtCustIDNO.Text = TxtAccName.Text = TxtCustName.Text = TxtFName.Text = TxtMName.Text = TxtSpouse.Text = TxtParmanent_Add.Text = TxtPresent_Add.Text = TxtPS.Text = "";
            TxtPostCode.Text = TxtTel.Text = TxtMobileNo.Text = TxtMail.Text = TxtRefAccNo.Text = TxtRefName.Text = TxtNIDNo.Text = "";

        }

        private void FillComAreaName()
        {
            query = @"select * from Area";
            dt = db.ExecuteQuery(query);
            if (dt.Rows.Count > 0)
            {
                CmbAreaCode.DataSource = dt;
                CmbAreaCode.DataTextField = "AreaName";
                CmbAreaCode.DataValueField = "AreaCode";
                CmbAreaCode.DataBind();
            }
        }

        private void GenerateSerialNumber()
        {
            query = @"SELECT MAX(SlNoAll) AS SlNoAll FROM CustInfo";
            dt = db.ExecuteQuery(query);
            if (dt.Rows.Count > 0)
            {
                TxtSlNoAll.Text = (int.Parse(dt.Rows[0]["SlNoAll"].ToString()) + 1).ToString();
            }
            else { TxtSlNoAll.Text = "1"; }

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string Criteria = "";

            if (dropdownSearchCriteria.SelectedValue != "select")
            {
                if (dropdownSearchCriteria.SelectedValue == "Serial")
                {
                    Criteria = "SlNoAll";
                }
                else if (dropdownSearchCriteria.SelectedValue == "AccountType")
                {
                    Criteria = "AccType";
                }
                else if (dropdownSearchCriteria.SelectedValue == "CustomerID")
                {
                    Criteria = "CustIDNO";
                }
                else if (dropdownSearchCriteria.SelectedValue == "NID")
                {
                    Criteria = "NIDNo";
                }

                query = @"select * from CustInfo where " + Criteria + " = '" + txtSearch.Text + "'";
                try
                {
                    dt = db.ExecuteQuery(query);
                    FillTextbox(dt);
                }
                catch (Exception exc) { throw exc; }

            }

        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            int insertStatus = 0;
            if (Request.QueryString["AutoGenSlNo"] != null)
            {
                query = @"select * from CustInfo where AutoSLNo =" + AutoGenSlNo;
                dt = db.ExecuteQuery(query);

                if (dt.Rows.Count > 0)
                {
                    query = @"UPDATE [MFiS-4].[dbo].[CustInfo] SET [AccType] = '" + ComAccType.SelectedValue + "',[AccName] = '" + TxtAccName.Text + "' ,[CustName] = '" + TxtCustName.Text + "',[Sex] = '" + ComSex.SelectedValue + "',[FName] ='" + TxtFName.Text + "',[MName] ='" + TxtMName.Text + "',[SpouseName] = '" + TxtSpouse.Text + "',[DateOfBirth] = '" + TxtDOB.Text + "',[Parmanent_Add] ='" + TxtParmanent_Add.Text + "',[Present_Add] = '" + TxtPresent_Add.Text + "',[PS] ='" + TxtPS.Text + "',[CityDistrict] = '" + TxtCityDistrict.SelectedValue + "',[PostCode] = '" + TxtPostCode.Text + "',[Country] ='" + TxtCountry.Text + "',[Tel] = '" + TxtTel.Text + "',[Mobile] ='" + TxtMobileNo.Text + "',[Mail] ='" + TxtMail.Text + "',[Religion] = '" + ComReligion.SelectedValue + "',[Occupation] = '" + TxtOccupation.SelectedValue + "',[RefAccNo] = '" + TxtRefAccNo.Text + "',[RefName] ='" + TxtRefName.Text + "',[NIDNo] ='" + TxtNIDNo.Text + "' WHERE AutoSLNo = " + AutoGenSlNo + "";

                }
            }
            else if (txtCustIDNO.Text != "")
            {
                query = @"INSERT into CustInfo (SlNoAll,SlNo,AdDate,BranchCode,AreaCode,CustIDNO,AccType,AccName,CustName,Sex,FName,MName,SpouseName,DateOfBirth,Parmanent_Add,Present_Add,PS,CityDistrict,PostCode,Country,Tel,Mobile,Mail,Religion,Occupation,RefAccNo,RefName,NIDNo) 
                      VALUES (" + TxtSlNoAll.Text + "," + TxtSlNoAll.Text + ", '" + TxtAdDate.Text + "','" + txtPrjCode.Text + "', '" + CmbAreaCode.SelectedValue + "', '" + txtCustIDNO.Text + "', '" + ComAccType.SelectedValue + "', '" + TxtAccName.Text + "','" + TxtCustName.Text + "','" + ComSex.SelectedValue + "', '" + TxtFName.Text + "', '" + TxtMName.Text + "','" + TxtSpouse.Text + "','" + TxtDOB.Text + "', '" + TxtParmanent_Add.Text + "','" + TxtPresent_Add.Text + "', '" + TxtPS.Text + "','" + TxtCityDistrict.SelectedValue + "', '" + TxtPostCode.Text + "', '" + TxtCountry.Text + "', '" + TxtTel.Text + "','" + TxtMobileNo.Text + "', '" + TxtMail.Text + "', '" + ComReligion.SelectedValue + "', '" + TxtOccupation.SelectedValue + "','" + TxtRefAccNo.Text + "','" + TxtRefName.Text + "','" + TxtNIDNo.Text.Trim() + "')";


            }
            try { insertStatus = db.ExecuteNonQuery(query); }
            catch (Exception exc) { throw exc; }
            if (insertStatus != 0)
            {
                ClearAll();
            }

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["AutoGenSlNo"] != null)
            {
                Response.Redirect("FrmCustInfo.aspx");
            }
            else
            {
                ClearAll();
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Response.Redirect("FrmMemberView.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int US = 0;

            if (txtCustIDNO.Text != "")
            {
                query = @"select * from CustInfo where CustIDNO ='" + txtCustIDNO.Text + "'";
                try
                {
                    dt = db.ExecuteQuery(query);
                }
                catch (Exception) { }
                if (dt.Rows.Count > 0)
                {
                    query = @"UPDATE [MFiS-4].[dbo].[CustInfo] SET [AccType] = '" + ComAccType.SelectedValue + "',[AccName] = '" + TxtAccName.Text + "' ,[CustName] = '" + TxtCustName.Text + "',[Sex] = '" + ComSex.SelectedValue + "',[FName] ='" + TxtFName.Text + "',[MName] ='" + TxtMName.Text + "',[SpouseName] = '" + TxtSpouse.Text + "',[DateOfBirth] = '" + TxtDOB.Text + "',[Parmanent_Add] ='" + TxtParmanent_Add.Text + "',[Present_Add] = '" + TxtPresent_Add.Text + "',[PS] ='" + TxtPS.Text + "',[CityDistrict] = '" + TxtCityDistrict.SelectedValue + "',[PostCode] = '" + TxtPostCode.Text + "',[Country] ='" + TxtCountry.Text + "',[Tel] = '" + TxtTel.Text + "',[Mobile] ='" + TxtMobileNo.Text + "',[Mail] ='" + TxtMail.Text + "',[Religion] = '" + ComReligion.SelectedValue + "',[Occupation] = '" + TxtOccupation.SelectedValue + "',[RefAccNo] = '" + TxtRefAccNo.Text + "',[RefName] ='" + TxtRefName.Text + "',[NIDNo] ='" + TxtNIDNo.Text + "' WHERE AutoSLNo = " + AutoGenSlNo + "";
                }
                try { US = db.ExecuteNonQuery(query); }
                catch (Exception exc) { throw exc; }
                if (US != 0)
                {
                    ClearAll();
                }
            }
        }

        protected void btnAccReg_Click(object sender, EventArgs e)
        {
            string CustomerID = "";

            if (txtCustIDNO.Text != "")
            {
                query = @"select * from CustInfo where CustIDNO ='" + txtCustIDNO.Text + "'";
                try
                {
                    dt = db.ExecuteQuery(query);
                }
                catch (Exception) { }
                if (dt.Rows.Count > 0)
                {
                    CustomerID = txtCustIDNO.Text;
                    Response.Redirect("FrmAccReg.aspx?CustomerID=" + CustomerID);
                }

            }
        }

    }
}