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


namespace CRM.system.admin.right
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //-----Get user Name ------//
        [WebMethod]
        public static List<ListItem> user_name()
        {
            db_class Connstring = new db_class();
            string query = @"SELECT  ID, Name FROM  [User]";

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
        //-----Get Department ------//
        [WebMethod]
        public static List<ListItem> department()
        {
            db_class Connstring = new db_class();
            string query = @"SELECT  ID,  Name FROM  Department";

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

        //-----Get Pricilege ------//
        [WebMethod]
        public static List<ListItem> privilege()
        {
            db_class Connstring = new db_class();
            string query = @"SELECT  ID, Name FROM   Privilege WHERE  (ID <> 1) AND (ID <> 2) AND (ID <> 3) AND (ID <> 4)";

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

        //---------------Save Details Data-------------------//
        [WebMethod]
        public static string SaveDetails(string[][] array, string[][] array1)
        {
            db_class Connstring = new db_class();
            string result = string.Empty;
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("privilege_id");
                dt.Columns.Add("add");
                dt.Columns.Add("edit");
                dt.Columns.Add("delete");
                dt.Columns.Add("status");
                //-------------Set Data Tbale Value----------------//
                foreach (var arr in array)
                {
                    DataRow dr = dt.NewRow();
                    dr["privilege_id"] = arr[0];
                    dr["add"] = arr[1];
                    dr["edit"] = arr[2];
                    dr["delete"] = arr[3];
                    dr["status"] = arr[4];
                    dt.Rows.Add(dr);
                }
                //--------------Insert Details Data---------------//
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string sql = "INSERT INTO [Right](UserID, PrivilegeID, [Add], Edit, [Delete], [view], Status) VALUES( @UserID, @PrivilegeID, @Add,@Edit, @Delete, @view, @Status)";
                    SqlCommand MyCommand = new SqlCommand(sql, Connstring.conn);
                    MyCommand.Parameters.AddWithValue("@UserID", array1[0][1]);
                    MyCommand.Parameters.AddWithValue("@PrivilegeID", dt.Rows[i]["privilege_id"].ToString().Trim());
                    MyCommand.Parameters.AddWithValue("@Add", dt.Rows[i]["add"].ToString().Trim());
                    MyCommand.Parameters.AddWithValue("@Edit", dt.Rows[i]["edit"].ToString().Trim());
                    MyCommand.Parameters.AddWithValue("@Delete", dt.Rows[i]["edit"].ToString().Trim());
                    MyCommand.Parameters.AddWithValue("@view", dt.Rows[i]["edit"].ToString().Trim());
                    MyCommand.Parameters.AddWithValue("@Status", dt.Rows[i]["status"].ToString().Trim());
                    Connstring.conn.Open();
                    MyCommand.ExecuteNonQuery();
                    Connstring.conn.Close();
                }
            }
            catch (Exception ex)
            {
                result = ex.Message;
            }
            return result;
        }
        //------------Show/Search Master Data----------------//
        [System.Web.Services.WebMethod]
        public static writer[] show_data(string search_data, string action)
        {
            string sql;
            db_class Connstring = new db_class();
            if (action == "show")
                sql = "SELECT Id,FirstName,LastName,Age,Address,comments,Course FROM [Table] ORDER BY Id DESC";
            else if (action == "search")
                sql = @"SELECT PDate, VoucherNo, PrjCode, CC_Name, TransactionType
                        FROM dbo.AccountsTransaction
                        GROUP BY PDate, VoucherNo, PrjCode, CC_Name, TransactionType
                        HAVING (TransactionType = 'Opening Balance') AND (VoucherNo = '" + search_data + "')";
            else
                sql = @"SELECT PDate, VoucherNo, PrjCode, CC_Name, TransactionType
                        FROM dbo.AccountsTransaction
                        GROUP BY PDate, VoucherNo, PrjCode, CC_Name, TransactionType
                        HAVING (TransactionType = 'Opening Balance') AND (VoucherNo = '" + search_data + "')";
            List<writer> customers = new List<writer>();

            using (SqlConnection con = Connstring.getcon)
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        writer writers = new writer();
                        writers.PDate = reader.GetDateTime(0);
                        writers.VoucherNo = reader.GetString(1);
                        writers.PrjCode = reader.GetDecimal(2);
                        writers.CC_Name = reader.GetString(3);
                        customers.Add(writers);
                    }
                }
            }
            return customers.ToArray();

        }

        //-------------For Master Data-------------------//
        public class writer
        {
            public DateTime PDate { get; set; }
            public string VoucherNo { get; set; }
            public Decimal PrjCode { get; set; }
            public string CC_Name { get; set; }

        }

    }
}