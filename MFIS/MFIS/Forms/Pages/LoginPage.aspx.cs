using MFIS.Models;
using MFIS.Pages;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MFIS.Pages
{
    public partial class LoginPage : System.Web.UI.Page
    {
        DBConnector db = new DBConnector();

        DataTable dt_LogIn = new DataTable();
        string ProductCode = string.Empty;
        string hostName = string.Empty;
        string IPAddress = string.Empty;
        string MACAddress = string.Empty;
        string UserName = string.Empty;
        string Mobile = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            GetDeviceInfo();
            byte[] KEY_128 = { 42, 1, 52, 67, 231, 13, 94, 101, 123, 6, 0, 12, 32, 91, 4, 111, 31, 70, 21, 141, 123, 142, 234, 82, 95, 129, 187, 162, 12, 55, 98, 23 };
            byte[] IV_128 = { 234, 12, 52, 44, 214, 222, 200, 109, 2, 98, 45, 76, 88, 53, 23, 78 };
            RijndaelManaged symmetricKey = new RijndaelManaged();
            symmetricKey.Mode = CipherMode.CBC;
            this.enc = new System.Text.UTF8Encoding();
            this.encryptor = symmetricKey.CreateEncryptor(KEY_128, IV_128);
            this.decryptor = symmetricKey.CreateDecryptor(KEY_128, IV_128);
            if (!IsPostBack)
            {
                // User_license();
                //   User_license_Status();
                //   UserPC_IP();
                //  MAC_Address();
            }
        }

        #region EncryptionRegion

        public System.Text.UTF8Encoding enc { get; set; }

        public ICryptoTransform encryptor { get; set; }

        public ICryptoTransform decryptor { get; set; }

        private string EncryptPassword(string pass)
        {
            byte[] bytes = System.Text.Encoding.Unicode.GetBytes(pass);
            string EncryptedPassword = Convert.ToBase64String(bytes);
            return EncryptedPassword;
            //string passd = "0";
            //return passd;

        }

        private string DecryptPassword(string Encryptedpass)
        {
            byte[] bytes = Convert.FromBase64String(Encryptedpass);
            string Decryptedpassword = System.Text.Encoding.Unicode.GetString(bytes);
            return Decryptedpassword;
        }

        public void encrypt()
        {
            string sPlainText = txtPassword.Text;
            if (!string.IsNullOrEmpty(sPlainText))
            {
                MemoryStream memoryStream = new MemoryStream();
                CryptoStream cryptoStream = new CryptoStream(memoryStream, this.encryptor, CryptoStreamMode.Write);
                cryptoStream.Write(this.enc.GetBytes(sPlainText), 0, sPlainText.Length);
                cryptoStream.FlushFinalBlock();
                Session["pasword"] = Convert.ToBase64String(memoryStream.ToArray());
                memoryStream.Close();
                cryptoStream.Close();
            }
        }

        #endregion

        #region DeviceInformation

        private void GetDeviceInfo()
        {
            device obj_device = new device();
            var DataObj = new List<DeviceInfoRoot>();

            try
            {
                string json = new WebClient().DownloadString("http://api.userstack.com/detect?access_key=26e642baf121685bb63cf249ef70d791&ua=Mozilla/5.0%20(Windows%20NT%2010.0;%20Win64;%20x64;%20rv:86.0)%20Gecko/20100101%20Firefox/86.0");
                DeviceInfoRoot obj = JsonConvert.DeserializeObject<DeviceInfoRoot>(json);
                DataObj.Add(obj);

                foreach (var data in DataObj)
                {
                    string os = data.os.name;
                    string mobile = data.device.is_mobile_device.ToString();
                    string brand = data.device.brand;
                    string brandCode = data.device.brand_code;
                }
            }
            catch (Exception)
            {

            }


        }

        private void MAC_Address()
        {
            try
            {
                MACAddress = GetMacAddress().ToString();
                Session["MACAddress"] = MACAddress;
            }
            catch
            {

                MACAddress = "";
                Session["MACAddress"] = MACAddress;
            }

        }

        public static PhysicalAddress GetMacAddress()
        {
            foreach (NetworkInterface nic in NetworkInterface.GetAllNetworkInterfaces())
            {
                // Only consider Ethernet network interfaces
                if (nic.NetworkInterfaceType == NetworkInterfaceType.Ethernet &&
                    nic.OperationalStatus == OperationalStatus.Up)
                {
                    return nic.GetPhysicalAddress();
                }
            }
            return null;
        }

        private void UserPC_IP()
        {
            try
            {
                hostName = Dns.GetHostName();
                Session["hostName"] = hostName;
                IPAddress = Dns.GetHostByName(hostName).AddressList[0].ToString();
                Session["IPAddress"] = IPAddress;
            }
            catch
            { }

        }

        private void User_license_Status()
        {
            try
            {
                dt_LogIn.Clear();

                string query = "select * from Company_Information where Product_ID = '" + ProductCode.ToString() + "' And Software_Active_Status = 'Yes' ";
                try { dt_LogIn = db.ExecuteQuery(query); } catch (Exception exc) { throw exc; }
                if (dt_LogIn.Rows.Count > 0)
                {

                }
                else
                {
                    btnLogin.Enabled = false;
                    txtPassword.Enabled = false;
                    txtUserID.Enabled = false;
                    Response.Write("<script>alert('Invalid software. Please contact to GPAC Software administrator. Mobile : +8801977774722, Website : wwww.gnisbd.com')</script>");
                }
            }
            catch
            {
                Response.Write("<script>alert('The connection to the server failed. Please Check the Internet connection and try again')</script>");
            }
        }

        private void User_license()
        {
            try
            {
                string query = "select * from Product_License";
                dt_LogIn = db.ExecuteQuery(query);

                if (dt_LogIn.Rows.Count > 0)
                {
                    DataRow row = dt_LogIn.Rows[0];
                    ProductCode = row["Product_ID"].ToString();
                    Session["ProductCode"] = row["Product_ID"].ToString();
                }
                else
                {
                    //In valid Software
                    // Response.Write("In valid Software");
                    Response.Write("<script>alert('In valid Software.')</script>");
                }

            }
            catch { }

        }

        #endregion

        #region UserInteraction

        protected void btn_login_Click(object sender, EventArgs e)
        {
            if (txtUserID.Text != "" && txtPassword.Text != "")
            {
                //string Connstring = DataManager.OraConnString();
                //SqlConnection myConnection = new SqlConnection(Connstring);
                encrypt();
                string query = "SELECT * FROM User_Login WHERE  (User_ID = '" + txtUserID.Text + "') AND (Password = '" + Session["pasword"].ToString() + "') ";
                DataTable dt = db.ExecuteQuery(query);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    UserName = row["User_Name"].ToString();
                    Mobile = row["MobileNo"].ToString();
                    Session["USERID"] = txtUserID.Text;
                    Session["ProjectCode"] = row["PrjCode"].ToString();
                    Session["EMP_ID"] = "GPAC";

                    string query1 = @"select UserID,comName from User_Now where UserId =  '" + txtUserID.Text + "'";
                    DataTable dt1 = db.ExecuteQuery(query1);
                    if (dt1.Rows.Count > 0)
                    {
                        Session["USERID"] = txtUserID.Text;
                        Response.Write("<script>alert('Software is logged with given User ID. Please enter a different User ID.')</script>");
                    }
                    else
                    {
                        //  chk_current_user();
                        Session["USERID"] = txtUserID.Text;
                        Session["EMP_ID"] = "GPAC";
                        Session["USER_NAME"] = row["UserName"].ToString();
                        //Response.Redirect("Dashboard.aspx");
                        Response.Redirect("~/Forms/MobileForms/MCustInfo.aspx");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Please enter valid UserID and Password')</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('Please type UserID and Password')</script>");
            }

        }

        private void chk_current_user()
        {
            string query = @"select UserID,comName from User_Now where UserId =  '" + txtUserID.Text + "'";
            DataTable dt = db.ExecuteQuery(query);

            if (dt.Rows.Count > 0)
            {
                Response.Write("<script>alert('Software is logged in with the given User ID. Please enter a different User ID.')</script>");
            }
            else
            {
                usersaver();
                GNIS_server_save();
            }

        }

        private void GNIS_server_save()
        {
            string UserInfo = @"INSERT Into User_Login_Information (User_ID, User_Name, MobileNo, ComputerName, IP_Address, MAK_Address, LoginDateTime, Product_ID)
                                VALUES ('" + Session["USERID"].ToString() + "','" + UserName.ToString() + "' , '" + Mobile + "' ,'" + Session["hostName"].ToString() + "','" + Session["IPAddress"].ToString() + "' ,'" + Session["MACAddress"].ToString() + "' ,'" + DateTime.Now + "', '" + Session["ProductCode"].ToString() + "' ) ";

            try
            {
                db.ExecuteNonQuery(UserInfo);
            }
            catch (Exception exc)
            {

                throw exc;
            }
        }

        private void usersaver()
        {
            string UserInfo = @"INSERT Into User_Now (UserID,ComName,LoginTime) values ('" + txtUserID.Text + "','" + System.Environment.MachineName + "','" + DateTime.Now + "')";
            try
            {
                db.ExecuteNonQuery(UserInfo);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }

        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            string query = @"select UserID,comName from User_Now where UserId =  '" + txtUserID.Text + "'";

            DataTable dt3 = db.ExecuteQuery(query);

            if (dt3.Rows.Count > 0)
            {
                if (dt3.Rows[0]["comName"].ToString() == System.Environment.MachineName)
                {

                    try
                    {
                        string UserInfo = @"delete from User_Now where UserID='" + Session["USERID"] + "'";
                        db.ExecuteNonQuery(UserInfo);
                    }
                    catch (Exception)
                    {
                        //throw new Exception(ex.Message);
                    }
                    finally
                    {
                        //if (connection.State == ConnectionState.Open)
                        //{
                        //    connection.Close();
                        //}
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
            else
            {
                Response.Write("<script>alert('Please login first')</script>");
            }
        }

        #endregion

    }
}