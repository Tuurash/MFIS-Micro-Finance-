<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportViewer.aspx.cs" Inherits="MFIS.Reports.ReportViewer" %>


<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

    <script type="text/javascript" src="crystalreportviewers13/js/crviewer/crv.js"></script>
</head>
<body>


    <form id="form1" runat="server">

        <input type="button" id="btnPrint" value="Print" onclick="Print()" />

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>

            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <%--<CR:CrystalReportViewer  ID="CrystalReportViewer" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="False" HasRefreshButton="True" BestFitPage="True" HasToggleGroupTreeButton="False" Height="50px" ToolPanelView="ParameterPanel" ToolPanelWidth="0px" Width="350px" />--%>

                        <div id="dvReport">
                            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
                                Height="400" Width="600" BestFitPage="False" />
                        </div>
                        <br />
                        <script type="text/javascript">
                            function Print() {
                                var dvReport = document.getElementById("dvReport");
                                var frame1 = dvReport.getElementsByTagName("iframe")[0];
                                if (navigator.appName.indexOf("Internet Explorer") != -1 || navigator.appVersion.indexOf("Trident") != -1) {
                                    frame1.name = frame1.id;
                                    window.frames[frame1.id].focus();
                                    window.frames[frame1.id].print();
                                }
                                else {
                                    var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
                                    frameDoc.print();
                                }
                            }
                        </script>
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
