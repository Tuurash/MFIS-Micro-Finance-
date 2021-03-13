using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;

namespace GPACACC
{
    public class DataManager
    {       
        public static void ExecuteNonQuery(string ConnectionString, string query)
        {
            using (SqlConnection myConnection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand myCommand = new SqlCommand(query, myConnection))
                {
                    myConnection.Open();
                    myCommand.ExecuteNonQuery();
                }
            }
        }
        
        public static DataTable ExecuteQuery(string ConnectionString, string query, string tableName)
        {
            using (SqlConnection myConnection = new SqlConnection(ConnectionString))
            {
                using (SqlDataAdapter myAdapter = new SqlDataAdapter(query, myConnection))
                {
                    DataSet ds = new DataSet();
                    myAdapter.Fill(ds, tableName);
                    ds.Tables[0].TableName = tableName;
                    return ds.Tables[0];
                }
            }
        }

        public static string OraConnString()
        {
         return String.Format("Server=localhost;Database=GPAC_VAT;User ID=sa;Password=sa*1209;Pooling=False;Trusted_Connection=False;");
          //  return String.Format("Server=Localhost;Database=GPAC_VAT;User ID=sa;Password=ppl@123#;Pooling=False;Trusted_Connection=False;");
        }
        public static string GNISServer()
        {
            // Localhost = IP Address
            //  return String.Format("Server=Software1;Database=GPAC_ERP;User ID=sa;Password=sa*1209;Pooling=False;Trusted_Connection=False;");
            return String.Format("Server=Localhost;Database=GPAC_User_License;User ID=sa;Password=sa*1209;Pooling=False;Trusted_Connection=False;");
        }
    }

}