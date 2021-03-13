using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MFIS.Pages.Models
{
    public class device
    {

        public bool is_mobile_device { get; set; }
        public string type { get; set; }
        public string brand { get; set; }
        public string brand_code { get; set; }
        public string brand_url { get; set; }
        public string name { get; set; }
    }
}