<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MSavingsLoan.aspx.cs" Inherits="MFIS.Forms.MobileForms.MSavingsLoan" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <%-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" crossorigin="anonymous"></script>--%>


    <script src="../../Reports/crystalreportviewers13/js/crviewer/crv.js"></script>

</head>


<body>
    <form id="form1" runat="server">
        <div class="form-row">
            <div class="col-12" align="right">
                <asp:Label runat="server" ID="lblStaffName"></asp:Label>&nbsp &nbsp &nbsp
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-sm btn-danger" Text="logout" OnClick="btnLogout_Click"></asp:LinkButton>
            </div>
        </div>
        <div class="text-white" style="background-color: #221181">
            <div class="card-body">
                <h5 class="card-title text-center">Customer ID</h5>
                <p class="card-text text-center">
                    <div class="input-group col-12">
                        <asp:TextBox runat="server" ID="txtIdNo" CssClass="form-control" placeholder="Enter Customer ID" AutoPostBack="true" OnTextChanged="txtIdNo_TextChanged"></asp:TextBox>
                        <asp:LinkButton runat="server" ID="btnSearch" CssClass="btn btn-sm btn-light" OnClick="btnSearch_Click">Search</asp:LinkButton>
                    </div>
                </p>
            </div>
        </div>
        <div>
            
            <div class="container">

                
                <br />

                <%--txtDate--%>
                <asp:Label runat="server" ID="txtDate" Visible="false"></asp:Label>
                <asp:Label runat="server" ID="lblVoucherNo" Visible="false"></asp:Label>
                <%-- Name --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Name </span>
                    <asp:TextBox runat="server" type="text" class="form-control" Style="text-transform: capitalize;" ID="txtCustomerName" aria-describedby="basic-addon1" />
                </div>
                <%-- L/A(loan Account): --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">L/A: </span>
                    <asp:DropDownList runat="server" ID="DropdownLAno" AutoPostBack="true" OnSelectedIndexChanged="DropdownLAno_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                </div>
                <%-- Amount --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Amount </span>
                    <asp:TextBox runat="server" class="form-control" Style="text-transform: capitalize;" ID="txtLAAmount" aria-describedby="basic-addon1" />
                </div>

                <%-- S/A(loan Account): --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">S/A: </span>
                    <asp:DropDownList runat="server" ID="DropdownSAno" AutoPostBack="true" OnSelectedIndexChanged="DropdownSAno_SelectedIndexChanged1" CssClass="form-control"></asp:DropDownList>
                </div>
                <%-- Amount --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Amount </span>
                    <asp:TextBox runat="server" type="txtSAamount" class="form-control" Style="text-transform: capitalize;" ID="txtSAamount" aria-describedby="basic-addon1" />
                </div>

                <div class="col-12">

                    <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-light" Style="width: 100%;" Text="Submit" OnClick="btnSubmit_Click" />

                </div>
                <br />
                <div class="col-12" runat="server" id="divPrint" visible="false">

                    <div style="height:60px;width:auto">
                        <input type="button" id="btnPrint" class="btn btn-light" style="width: 100%; height: 60px" value="Print" onclick="Print()" />
                        <div id="dvReport" style="color:white; overflow:hidden;display: none;" class="col" >

                        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"
                            AutoDataBind="true"
                            HasToggleGroupTreeButton="false"
                            HasToggleParameterPanelButton="false"
                            HasPageNavigationButtons="False"
                            ShowToggleSidePanelButton="False"
                            ShowStatusbar="False"
                            ShowLogo="False"
                            GroupTreeStyle-ShowLines="False"
                            DisplayStatusbar="False"
                            EnableToolTips="False"
                            Font-Bold="False"
                            Font-Strikeout="False" ToolPanelView="None" BestFitPage="True" />

                    </div>
                    </div>

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
    </form>
</body>
</html>
