using MFIS.Models;
using MFIS.Services;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.IO;

using System.Net;
using System.Net.NetworkInformation;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web;


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

        public static class Utils
        {
            // update : 5/April/2018
            static Regex MobileCheck = new Regex(@"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino", RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Compiled);
            static Regex MobileVersionCheck = new Regex(@"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-", RegexOptions.IgnoreCase | RegexOptions.Multiline | RegexOptions.Compiled);

            public static bool fBrowserIsMobile()
            {
                Debug.Assert(HttpContext.Current != null);

                if (HttpContext.Current.Request != null && HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"] != null)
                {
                    var u = HttpContext.Current.Request.ServerVariables["HTTP_USER_AGENT"].ToString();

                    if (u.Length < 4)
                        return false;

                    if (MobileCheck.IsMatch(u) || MobileVersionCheck.IsMatch(u.Substring(0, 4)))
                        return true;
                }

                return false;
            }
        }

        private void GetDeviceInfo()
        {
            device obj_device = new device();
            var DataObj = new List<DeviceInfoRoot>();
            string Info = "";
            string Ismobile = "";
            string os = "";
            string brand = "";
            string brandCode = "";
            string name = "";

            try
            {
                string json = new WebClient().DownloadString("http://api.userstack.com/detect?access_key=26e642baf121685bb63cf249ef70d791&ua=Mozilla/5.0%20(Windows%20NT%2010.0;%20Win64;%20x64;%20rv:86.0)%20Gecko/20100101%20Firefox/86.0");
                DeviceInfoRoot obj = JsonConvert.DeserializeObject<DeviceInfoRoot>(json);
                DataObj.Add(obj);

                foreach (var data in DataObj)
                {
                    os = data.os.name;
                    Ismobile = data.device.is_mobile_device.ToString();
                    brand = data.device.brand;
                    brandCode = data.device.brand_code;
                    name = data.device.name;
                }
            }
            catch (Exception) { }

            try
            {
                Info = name + os + brand + brandCode;
                string query = @"INSERT INTO MAK_Address (MAK_Addr,ComputerName,PCStatus,IsMobile,Info)
                                     VALUES ('" + GetIP() + "','" + os + "','Active','" + Ismobile + "','" + Info + "')";

                db.ExecuteNonQuery(query);
            }
            catch (Exception) { }
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

        //private void UserPC_IP()
        //{
        //    try
        //    {
        //        hostName = Dns.GetHostName();
        //        Session["hostName"] = hostName;
        //        IPAddress = Dns.GetHostByName(hostName).AddressList[0].ToString();
        //        Session["IPAddress"] = IPAddress;
        //    }
        //    catch
        //    { }

        //}

        private string GetIP()
        {
            string strHostName = "";
            strHostName = System.Net.Dns.GetHostName();
            IPHostEntry ipEntry = System.Net.Dns.GetHostEntry(strHostName);
            IPAddress[] addr = ipEntry.AddressList;
            return addr[addr.Length - 1].ToString();
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

                    Session["StaffName"] = UserName;

                    string query1 = @"select UserID,comName from User_Now where UserId =  '" + txtUserID.Text + "'";
                    DataTable dt1 = db.ExecuteQuery(query1);
                    if (dt1.Rows.Count > 0)
                    {
                        Session["USERID"] = txtUserID.Text;
                        Response.Write("<script>alert('Software is logged with given User ID. Please enter a different User ID.')</script>");
                    }
                    else
                    {
                        query = @"select * from Area_StaffWise where StaffID='" + txtUserID.Text + "' and Status='Active'";
                        dt = db.ExecuteQuery(query);

                        if (dt.Rows.Count > 0)
                        {
                            //Gets Device Information
                            GetDeviceInfo();
                            chk_current_user();
                            Session["USERID"] = txtUserID.Text;
                            Session["EMP_ID"] = "GPAC";
                            Session["USER_NAME"] = row["UserName"].ToString();
                            //Response.Redirect("Dashboard.aspx");

                            if (Utils.fBrowserIsMobile())
                            {
                                Response.Redirect("~/Forms/MobileForms/MDashboard.aspx");
                            }
                            else
                            {
                                Response.Redirect("~/Forms/MobileForms/MDashboard.aspx");
                            }
                        }
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
                //GNIS_server_save();
            }

        }

        private void GNIS_server_save()
        {
            string UserInfo = @"INSERT Into User_Login_Information (User_ID, User_Name, MobileNo, ComputerName, IP_Address, MAK_Address, LoginDateTime, Product_ID)
                                VALUES ('" + txtUserID.Text + "','" + UserName.ToString() + "' , '" + Mobile + "' ,'" + Session["hostName"].ToString() + "','" + Session["IPAddress"].ToString() + "' ,'" + Session["MACAddress"].ToString() + "' ,'" + DateTime.Now + "', '" + Session["ProductCode"].ToString() + "' ) ";

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