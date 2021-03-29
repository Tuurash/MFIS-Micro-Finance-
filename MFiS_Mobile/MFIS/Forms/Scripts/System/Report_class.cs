using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Report_class
/// </summary>
public class Report_class
{
    public Report_class()
    {
    }
        public string ReportConnectionUser()
        {
            string Connection = "sa";

            return Connection;
        }
        public string ReportConnectionPass()
        {
            string Connection = "sa*1209";

            return Connection;
        }
        public string ReportConnectionServer()
        {
            string Connection = "localhost";

            return Connection;
        }
        public string ReportConnectionDatabase()
        {
            string Connection = "GPAC_ERP";

            return Connection;
        }
}