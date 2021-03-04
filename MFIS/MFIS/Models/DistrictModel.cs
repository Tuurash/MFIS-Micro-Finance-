using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MFIS.Models
{
    //public class DistrictModel
    //{
    //}
    public class Datum
    {
        public string id { get; set; }
        public string division_id { get; set; }
        public string name { get; set; }
        public string bn_name { get; set; }
        public string lat { get; set; }
        public string lon { get; set; }
        public string url { get; set; }
    }
}