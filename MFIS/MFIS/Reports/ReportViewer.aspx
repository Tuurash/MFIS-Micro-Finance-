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
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>

            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <CR:CrystalReportViewer  ID="CrystalReportViewer" runat="server" AutoDataBind="true" EnableDatabaseLogonPrompt="False" HasRefreshButton="True" BestFitPage="True" HasToggleGroupTreeButton="False" Height="50px" ToolPanelView="ParameterPanel" ToolPanelWidth="0px" Width="350px" />
                    </div>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
