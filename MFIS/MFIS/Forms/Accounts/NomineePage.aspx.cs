using MFIS.Pages;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Forms.Accounts
{
    public partial class NomineePage : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        //string CustomerAccNo = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (txtCustAcNo.Text != "")
                {
                    LoadAccountData();
                }
                else
                {
                    if (Request.QueryString["CustAcNo"] != null)
                    {
                        txtCustAcNo.Text = Request.QueryString["CustAcNo"];
                    }

                }
            }


        }

        private void LoadAccountData()
        {
            if (txtCustAcNo.Text != "")
            {

                string CustAcNo = txtCustAcNo.Text;
                query = @"select * from Nominee where CustAccNo='" + CustAcNo + "'";
                try
                {
                    dt = db.ExecuteQuery(query);
                }
                catch (Exception exc) { throw exc; }
                if (dt.Rows.Count > 0)
                {

                    txtName1.Text = dt.Rows[0]["Name1"].ToString();
                    txtName2.Text = dt.Rows[0]["Name2"].ToString();
                    txtName3.Text = dt.Rows[0]["Name3"].ToString();
                    txtName4.Text = dt.Rows[0]["Name4"].ToString();

                    txtAge1.Text = dt.Rows[0]["Age1"].ToString();
                    txtAge2.Text = dt.Rows[0]["Age2"].ToString();
                    txtAge3.Text = dt.Rows[0]["Age3"].ToString();
                    txtAge4.Text = dt.Rows[0]["Age4"].ToString();

                    txtGuardians1.Text = dt.Rows[0]["Guardians1"].ToString();
                    txtGuardians2.Text = dt.Rows[0]["Guardians2"].ToString();
                    txtGuardians3.Text = dt.Rows[0]["Guardians3"].ToString();
                    txtGuardians4.Text = dt.Rows[0]["Guardians4"].ToString();

                    txtPercent1.Text = dt.Rows[0]["Percent1"].ToString();
                    txtPercent2.Text = dt.Rows[0]["Percent2"].ToString();
                    txtPercent3.Text = dt.Rows[0]["Percent3"].ToString();
                    txtPercent4.Text = dt.Rows[0]["Percent4"].ToString();


                    txtAddress1.Text = dt.Rows[0]["Address1"].ToString();
                    txtAddress2.Text = dt.Rows[0]["Address2"].ToString();
                    txtAddress3.Text = dt.Rows[0]["Address3"].ToString();
                    txtAddress4.Text = dt.Rows[0]["Address4"].ToString();

                    txtRelation1.Text = dt.Rows[0]["Relation1"].ToString();
                    txtRelation2.Text = dt.Rows[0]["Relation2"].ToString();
                    txtRelation3.Text = dt.Rows[0]["Relation3"].ToString();
                    txtRelation4.Text = dt.Rows[0]["Relation4"].ToString();

                }

            }
        }

        protected void btnInsertNominee_Click(object sender, EventArgs e)
        {
            int InsertSatatus = 0;

            query = @"INSERT into Nominee (CustAccNo, Name1, Name2, Name3, Name4, Age1, Age2,Age3, Age4, Guardians1, Guardians2,Guardians3, Guardians4,Percent1,Percent2, Percent3,Percent4,Address1,Address2,Address3,Address4,Relation1,Relation2,Relation3,Relation4)
                      VALUES ('" + txtCustAcNo.Text + "', '" + txtName1.Text + "', '" + txtName2.Text + "', '" + txtName3.Text + "', '" + txtName4.Text + "', '" + txtAge1.Text + "', '" + txtAge2.Text + "', '" + txtAge3.Text + "', '" + txtAge4.Text + "', '" + txtGuardians1.Text + "', '" + txtGuardians2.Text + "', '" + txtGuardians3.Text + "', '" + txtGuardians4.Text + "', '" + txtPercent1.Text + "','" + txtPercent2.Text + "',  '" + txtPercent3.Text + "','" + txtPercent4.Text + "','" + txtAddress1.Text + "','" + txtAddress2.Text + "','" + txtAddress3.Text + "','" + txtAddress4.Text + "','" + txtRelation1.Text + "','" + txtRelation2.Text + "','" + txtRelation3.Text + "','" + txtRelation4.Text + "')";
            try
            {
                InsertSatatus = db.ExecuteNonQuery(query);
            }
            catch (Exception exc) { throw exc; }
            if (InsertSatatus > 0)
            {
                LoadAccountData();
            }
        }

        protected void btnSearch_ServerClick(object sender, EventArgs e)
        {
            LoadAccountData();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int UpdateStatus = 0;
            query = @"Update Nominee set Name1= '" + txtName1.Text + "',Name2= '" + txtName2.Text + "',Name3= '" + txtName3.Text + "',Name4= '" + txtName4.Text + "', Age1= '" + txtAge1.Text + "',  Age2= '" + txtAge2.Text + "', Age3= '" + txtAge3.Text + "', Age4= '" + txtAge4.Text + "',Guardians1 = '" + txtGuardians1.Text + "',Guardians2 = '" + txtGuardians2.Text + "',Guardians3 = '" + txtGuardians3.Text + "',Guardians4 = '" + txtGuardians4.Text + "',Percent1= '" + txtPercent1.Text + "',Percent2= '" + txtPercent2.Text + "',Percent3= '" + txtPercent3.Text + "',Percent4= '" + txtPercent4.Text + "',Address1 = '" + txtAddress1.Text + "',Address2 = '" + txtAddress2.Text + "',Address3 = '" + txtAddress3.Text + "',Address4 = '" + txtAddress4.Text + "',Relation1 = '" + txtRelation1.Text + "',Relation2 = '" + txtRelation2.Text + "',Relation3 = '" + txtRelation3.Text + "',Relation4 = '" + txtRelation4.Text + "' where  CustAccNo = '" + txtCustAcNo.Text + "' ";
            try
            {
                UpdateStatus = db.ExecuteNonQuery(query);
            }
            catch (Exception exc) { throw exc; }
            if (UpdateStatus > 0)
            {
                LoadAccountData();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int DeleteStatus = 0;
            query = @"delete from Nominee where CustAccNo='" + txtCustAcNo.Text + "'";
            try
            {
                DeleteStatus = db.ExecuteNonQuery(query);
            }
            catch (Exception exc) { throw exc; }
            if (DeleteStatus > 0)
            {
                LoadAccountData();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtName1.Text = txtAddress1.Text = txtAge1.Text = txtPercent1.Text = txtRelation1.Text = txtGuardians1.Text = "";
            txtName2.Text = txtAddress2.Text = txtAge2.Text = txtPercent2.Text = txtRelation2.Text = txtGuardians2.Text = "";
            txtName3.Text = txtAddress3.Text = txtAge3.Text = txtPercent3.Text = txtRelation3.Text = txtGuardians3.Text = "";
            txtName4.Text = txtAddress4.Text = txtAge4.Text = txtPercent4.Text = txtRelation4.Text = txtGuardians4.Text = "";
        }
    }

}