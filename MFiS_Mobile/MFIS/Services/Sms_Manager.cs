using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

namespace MFIS.Services
{
    public class Sms_Manager
    {

        internal void SendSMS(string rcvrNumber, string msg)
        {
            string result = "";
            WebRequest request = null;
            HttpWebResponse response = null;

            try
            {
                //Dim url As String = "http://portal.greenheritageit.com/smsapi?api_key=C20002325f59ca1460f2d0.63815738&type=text&contacts=" & Me.TxtMobileNo.Text & " &senderid=8809612440620&msg=" & Me.TxtSMSBody.Text & " "


                String to = rcvrNumber;
                String message = System.Uri.EscapeUriString(msg); //do not use single quotation   (') in the message to avoid forbidden result

                String url = "http://portal.greenheritageit.com/smsapi?api_key=C20002325f59ca1460f2d0.63815738&type=text&contacts=" + to + " &senderid=8809612440620&msg=" + message;
                request = WebRequest.Create(url);


                response = (HttpWebResponse)request.GetResponse();
                Stream stream = response.GetResponseStream();
                Encoding ec = System.Text.Encoding.GetEncoding("utf-8");
                StreamReader reader = new
                System.IO.StreamReader(stream, ec);
                result = reader.ReadToEnd();
                Console.WriteLine(result);
                reader.Close();
                stream.Close();
            }
            catch (Exception exc)
            {
                throw exc;
            }
            finally
            {
                if (response != null)
                    response.Close();
            }
        }
    }
}




