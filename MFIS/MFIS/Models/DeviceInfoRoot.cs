using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MFIS.Models
{
    public class DeviceInfoRoot
    {
        public string ua { get; set; }
        public string type { get; set; }
        public string brand { get; set; }
        public string name { get; set; }
        public string url { get; set; }

        public device device;
        public os os;
    }
}