using ACC_WEB_V_0_1.Controllers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRM.system.admin.priviledge
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //-----Get Console ------//
        [WebMethod]
        public static List<ListItem> project_code()
        {
            db_class Connstring = new db_class();
            string query = @"SELECT  ID, Name FROM   Console";

            using (SqlConnection con = Connstring.getcon)
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> customers = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(new ListItem
                            {
                                Value = sdr["ID"].ToString(),
                                Text = sdr["Name"].ToString()
                            });
                        }
                    }
                    con.Close();
                    return customers;
                }

            }
        }
        //-----Get Module ------//
        [WebMethod]
        public static List<ListItem> Module_code()
        {
            db_class Connstring = new db_class();
            string query = @"SELECT   ID, Name, DepartmentID FROM    Module";

            using (SqlConnection con = Connstring.getcon)
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> customers = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(new ListItem
                            {
                                Value = sdr["ID"].ToString(),
                                Text = sdr["Name"].ToString()
                            });
                        }
                    }
                    con.Close();
                    return customers;
                }

            }
        }


        //-----Get Parent ------//
        [WebMethod]
        public static List<ListItem> parent_code()
        {
            db_class Connstring = new db_class();
            string query = @"SELECT      ID, Name  FROM  Privilege";

            using (SqlConnection con = Connstring.getcon)
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    List<ListItem> customers = new List<ListItem>();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(new ListItem
                            {
                                Value = sdr["ID"].ToString(),
                                Text = sdr["Name"].ToString()
                            });
                        }
                    }
                    con.Close();
                    return customers;
                }

            }
        }
        //Save Master data
        [WebMethod]
        public static void insertDt(string dll_project, string dll_module, string txt_pv_name, string dll_parent, string txt_url, string dll_active)
        {    
            db_class Connstring = new db_class();
            string sql = @"INSERT INTO Privilege
                         (Name, ParentID, URL, ModuleID, ConsuleID, Active)
                        VALUES(@Name, @ParentID, @URL, @ModuleID, @ConsuleID, @Active)";
            SqlCommand MyCommand = new SqlCommand(sql, Connstring.conn);
            MyCommand.Parameters.AddWithValue("@Name", txt_pv_name);
            MyCommand.Parameters.AddWithValue("@ParentID", dll_parent);
            MyCommand.Parameters.AddWithValue("@URL", txt_url);
            MyCommand.Parameters.AddWithValue("@ModuleID", dll_module);
            MyCommand.Parameters.AddWithValue("@ConsuleID", dll_project);
            MyCommand.Parameters.AddWithValue("@Active", dll_active);        
            Connstring.conn.Open();
            MyCommand.ExecuteNonQuery();
            Connstring.conn.Close();

        }

    }
}