using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Views.Nominee
{
    public partial class NomineePage : System.Web.UI.Page
    {
        string query = "";
        DBConnector db = new DBConnector();
        DataTable dt = new DataTable();

        string CustomerAccNo = "";

        protected void Page_Load(object sender, EventArgs e)
        {

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

        }

        protected void btnSearch_ServerClick(object sender, EventArgs e)
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
                txtName1.Text = dt.Rows[0]["Name2"].ToString();
                txtName1.Text = dt.Rows[0]["Name3"].ToString();
                txtName1.Text = dt.Rows[0]["Name4"].ToString();

                txtName1.Text = dt.Rows[0]["Age1"].ToString();
                txtName1.Text = dt.Rows[0]["Age2"].ToString();
                txtName1.Text = dt.Rows[0]["Age3"].ToString();
                txtName1.Text = dt.Rows[0]["Age4"].ToString();

                txtName1.Text = dt.Rows[0]["Guardians1"].ToString();
                txtName1.Text = dt.Rows[0]["Guardians2"].ToString();
                txtName1.Text = dt.Rows[0]["Guardians3"].ToString();
                txtName1.Text = dt.Rows[0]["Guardians4"].ToString();

                txtName1.Text = dt.Rows[0]["Percent1"].ToString();
                txtName1.Text = dt.Rows[0]["Percent2"].ToString();
                txtName1.Text = dt.Rows[0]["Percent3"].ToString();
                txtName1.Text = dt.Rows[0]["Percent4"].ToString();


                txtName1.Text = dt.Rows[0]["Address1"].ToString();
                txtName1.Text = dt.Rows[0]["Address2"].ToString();
                txtName1.Text = dt.Rows[0]["Address3"].ToString();
                txtName1.Text = dt.Rows[0]["Address4"].ToString();

                txtName1.Text = dt.Rows[0]["Relation1"].ToString();
                txtName1.Text = dt.Rows[0]["Relation2"].ToString();
                txtName1.Text = dt.Rows[0]["Relation3"].ToString();
                txtName1.Text = dt.Rows[0]["Relation4"].ToString();

            }
        }
    }
}