using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Views
{
    public partial class AccountInfoPage : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                ClearAll();
                GenerateSerialNumber();
            }
            catch (Exception exc) { throw exc; }
            if (!IsPostBack)
            {
                FillComAreaName();
            }
        }

        public void ClearAll()
        {
            //VALUES('" + TxtSlNoAll.Text + "', '" + TxtSlNo.Text + "', '" + TxtAdDate.Text + "', '" + CmbAreaCode.Text + "', '" + txtCustIDNO.Text + "', '" + ComAccType.Text + "',
            //'" + TxtAccName.Text + "', '" + TxtCustName.Text + "', '" + ComSex.Text + "', '" + TxtFName.Text + "', '" + TxtMName.Text + "', '" + TxtSpouse.Text + "',
            //'" + TxtDOB.Text + "', '" + TxtParmanent_Add.Text + "', '" + TxtPresent_Add.Text + "', '" + TxtPS.Text + "', '" + TxtCityDistrict.Text + "', '" + TxtPostCode.Text + "',
            //'" + TxtCountry.Text + "', '" + TxtTel.Text + "', '" + TxtMobileNo.Text + "', '" + TxtMail.Text + "',
            //'" + ComReligion.SelectedValue + "', '" + TxtOccupation.SelectedValue + "', '" + TxtRefAccNo.Text + "', '" + TxtRefName.Text + "', '" + TxtNIDNo.Text.Trim() + "')";

            TxtSlNoAll.Text = TxtSlNo.Text = txtCustIDNO.Text = TxtAccName.Text = TxtCustName.Text = TxtFName.Text = TxtMName.Text = TxtSpouse.Text = TxtParmanent_Add.Text = TxtPresent_Add.Text = TxtPS.Text = "";
            TxtCityDistrict.Text = TxtCityDistrict.Text = TxtPostCode.Text = TxtCountry.Text = TxtTel.Text = TxtMobileNo.Text = TxtMail.Text = TxtRefAccNo.Text = TxtRefName.Text = TxtNIDNo.Text = "";

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

        protected void dropdownSearchCriteria_SelectedIndexChanged(object sender, EventArgs e)
        {
            SearchPanel.Visible = true;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (dropdownSearchCriteria.SelectedValue != "select")
            {
                if (dropdownSearchCriteria.SelectedValue == "Serial")
                {

                }
                else if (dropdownSearchCriteria.SelectedValue == "AccountType")
                {

                }
                else if (dropdownSearchCriteria.SelectedValue == "CustomerID")
                {

                }
                else if (dropdownSearchCriteria.SelectedValue == "NID")
                {

                }
            }

        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            //BranchCode TxtBrCode removed
            //,'" + TxtUserID.Text + "'         UserID removed
            //,'" + ComSMS_Service_Yes_No.Text) + "'   SMS_Service_Yes_No removed
            //2 TxtParmanent_Add_Bangla notfound
            //AutoSLno

            int insertStatus = 0;

            try
            {
                query = @"INSERT into CustInfo (SlNoAll,SlNo,AdDate,AreaCode,CustIDNO,AccType,AccName,CustName,Sex,FName,MName,SpouseName,DateOfBirth,Parmanent_Add,Present_Add,PS,CityDistrict,PostCode,Country,Tel,Mobile,Mail,Religion,Occupation,RefAccNo,RefName,NIDNo) 
                      VALUES ('" + TxtSlNoAll.Text + "','" + TxtSlNo.Text + "', '" + TxtAdDate.Text + "', '" + CmbAreaCode.SelectedValue + "', '" + txtCustIDNO.Text + "', '" + ComAccType.SelectedValue + "', '" + TxtAccName.Text + "','" + TxtCustName.Text + "','" + ComSex.SelectedValue + "', '" + TxtFName.Text + "', '" + TxtMName.Text + "','" + TxtSpouse.Text + "','" + TxtDOB.Text + "', '" + TxtParmanent_Add.Text + "','" + TxtPresent_Add.Text + "', '" + TxtPS.Text + "','" + TxtCityDistrict.Text + "', '" + TxtPostCode.Text + "', '" + TxtCountry.Text + "', '" + TxtTel.Text + "','" + TxtMobileNo.Text + "', '" + TxtMail.Text + "', '" + ComReligion.SelectedValue + "', '" + TxtOccupation.SelectedValue + "','" + TxtRefAccNo.Text + "','" + TxtRefName.Text + "','" + TxtNIDNo.Text.Trim() + "')";
                insertStatus = db.ExecuteNonQuery(query);
            }
            catch (Exception exc) { throw exc; }
            if (insertStatus != 0)
            {
                ClearAll();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearAll();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/AccountDetailsPage.aspx");
        }

    }
}