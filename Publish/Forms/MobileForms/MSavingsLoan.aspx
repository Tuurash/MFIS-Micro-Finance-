<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MSavingsLoan.aspx.cs" Inherits="MFIS.Forms.MobileForms.MSavingsLoan" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="../Scripts/Bootstrap5.css" rel="stylesheet" />
    <script src="../../Reports/crystalreportviewers13/js/crviewer/crv.js"></script>

    <%--Notification--%>
    <link href="../Scripts/iziToastv1.4.0.css" rel="stylesheet" />
    <script src="../Scripts/iziToastv1.4.0.js"></script>


    <%--    <script type="text/javascript">
        function notify() {

            var Credit = Amount
            iziToast.success({
                title: 'Submission Successful',
                position: 'topCenter',
                message: 'Print Available',
            });
        }
    </script>--%>


    <%--Loading Animation attempt--%>
    <style>
        #spinner {
            position: fixed;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            z-index: 9999;
            /*Change your loading image here*/
            background: url(../Scripts/dist/img/Loading-unscreen.gif) 50% 50% no-repeat #ede9df;
        }
    </style>
    <script>
        //Change the 5000 to a value which you need so that loading image shows till your page completely
        $(window).load(function () { $("#spinner").fadeOut(500); })

        function loader() { $("#spinner").fadeOut(500); }
    </script>


</head>


<body>
    <form id="form1" runat="server">

        <!-- Preloader -->
        <div id="spinner">
        </div>

        <div class="form-row">
            <div class="col-12 d-flex justify-content-between">
                <asp:LinkButton ID="btnDashboard" runat="server" CssClass="btn btn-sm btn-light" Text="Dashboard" OnClick="btnDashboard_Click"></asp:LinkButton>
                <asp:Label runat="server" ID="lblStaffName"  CssClass="btn btn-sm btn-light"></asp:Label>
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
                    <asp:TextBox runat="server" type="text" class="form-control" Enabled="false" Style="text-transform: capitalize;" ID="txtCustomerName" aria-describedby="basic-addon1" />
                </div>

                <%-- L/A(loan Account): --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">L/A: </span>
                    <asp:DropDownList runat="server" ID="DropdownLAno" Visible="false" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="DropdownLAno_SelectedIndexChanged"></asp:DropDownList>

                    <div id="divLAsearch" runat="server">
                        <asp:TextBox runat="server" ID="txtLANo" CssClass="form-control"></asp:TextBox>
                        <asp:Button ID="btnLASearch" runat="server" CssClass="btn btn-sm btn-light" OnClick="btnLASearch_Click" Text="Check" />
                    </div>

                </div>
                <%-- Amount --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Amount </span>
                    <asp:TextBox runat="server" class="form-control" Style="text-transform: capitalize;" ID="txtLAAmount" aria-describedby="basic-addon1" />
                </div>

                <%-- S/A(loan Account): --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">S/A: </span>
                    <asp:DropDownList runat="server" Visible="false" ID="DropdownSAno" AutoPostBack="true" OnSelectedIndexChanged="DropdownSAno_SelectedIndexChanged1" CssClass="form-control"></asp:DropDownList>
                    <div id="divSASearch" runat="server">
                        <asp:TextBox runat="server" ID="txtSANo" CssClass="form-control"></asp:TextBox>
                        <asp:Button ID="btnSearchSA" runat="server" CssClass="btn btn-sm btn-light" OnClick="btnSearchSA_Click" Text="Check" />
                    </div>
                </div>
                <%-- Amount --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Amount </span>
                    <asp:TextBox runat="server" type="txtSAamount" class="form-control" Style="text-transform: capitalize;" ID="txtSAamount" aria-describedby="basic-addon1" />
                </div>

                <div class="col-12">
                    <style>
                        .radioButtonList input[type="radio"] {
                            width: auto;
                            float: left;
                        }

                        .radioButtonList label {
                            width: auto;
                            display: inline;
                            float: left;
                            font-size: 1rem;
                            color: #0367B2 !important;
                            font-style: italic;
                            padding: 2px;
                        }
                    </style>
                    <%--Payment Option--%>
                    <div class="input-group mb-3">

                        <asp:RadioButtonList runat="server" BorderStyle="None" ClientIDMode="static" RepeatDirection="Horizontal" RepeatLayout="Table"
                            TextAlign="right" ID="RadioPaymnetMethod" CssClass="radioButtonList">

                            <asp:ListItem Text="Online Payment" Value="OnlinePayment" />
                            <asp:ListItem Text="Cash" Selected="True" Value="Cash" />

                        </asp:RadioButtonList>

                    </div>

                    <asp:Button runat="server" ID="btnSubmit" CssClass="btn btn-light" Style="width: 100%;" Text="Submit" OnClick="btnSubmit_Click" />

                </div>
                <br />

                <div class="col-12" runat="server" id="divPrint" visible="false">

                    <div style="height: 60px; width: auto">
                        <input type="button" id="btnPrint" class="btn btn-light" style="width: 100%; height: 60px" value="Print" onclick="Print()" />
                        <div id="dvReport" style="color: white; overflow: hidden; display: none;" class="col">

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

                                Hide();
                            }
                            else {
                                var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
                                frameDoc.print();

                                Hide();
                            }
                        }

                        function Hide() {
                            var x = document.getElementById("divPrint");
                            if (x.style.display === "none") {
                                x.style.display = "block";
                            } else {
                                x.style.display = "none";
                            }

                            window.location.href = "MSavingsLoan.aspx";
                        }

                    </script>

                </div>

            </div>

        </div>
    </form>

    <script src="../Scripts/dist/jquery1.11.js"></script>
    <script>
        $(document).ready(function () { $("#spinner").fadeOut(1000); });
    </script>

</body>

</html>
