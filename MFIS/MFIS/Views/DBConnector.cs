using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace MFIS.Views
{
    public class DBConnector
    {
        private SqlConnection connection;
        string connectionString;
        public DBConnector()
        {
            connectionString = ConfigurationManager.ConnectionStrings["MFIS"].ConnectionString;
        }

        public SqlConnection Connection()
        {
            return new SqlConnection(connectionString);
        }

        public DataTable ExecuteQuery(string sqlQuery)
        {
            DataTable dt = new DataTable();
            using (connection = Connection())
            {

                SqlDataAdapter da = new SqlDataAdapter(sqlQuery, connection);

                da.Fill(dt);
            }

            return dt;
        }
        public int ExecuteNonQuery(string sqlQuery)
        {
            int res = -1;
            using (connection = Connection())
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                SqlCommand cmd = new SqlCommand(sqlQuery, connection);
                res = cmd.ExecuteNonQuery();
                if (connection.State == ConnectionState.Open)
                    connection.Close();
            }

            return res;
        }
        public object ExecuteScalar(string sqlQuery)
        {
            object res;
            using (connection = Connection())
            {
                if (connection.State == ConnectionState.Closed)
                    connection.Open();
                SqlCommand cmd = new SqlCommand(sqlQuery, connection);
                res = cmd.ExecuteScalar();
                if (connection.State == ConnectionState.Open)
                    connection.Close();
            }

            return res;
        }
    }
}