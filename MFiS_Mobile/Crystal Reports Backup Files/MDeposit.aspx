<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MDeposit.aspx.cs" Inherits="MFIS.Forms.MobileForms.MDeposit" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap5 CSS -->
    <link href="../Scripts/Bootstrap5.css" rel="stylesheet" />
    <script src="../../Reports/crystalreportviewers13/js/crviewer/crv.js"></script>


    <%--Notification--%>
    <link href="../Scripts/iziToastv1.4.0.css" rel="stylesheet" />
    <script src="../Scripts/iziToastv1.4.0.js"></script>


    <script type="text/javascript">
        function notify(Amount) {

            var Credit = Amount
            iziToast.success({
                title: 'Successfully',
                position: 'topCenter',
                message: 'Inserted Deposit: ' + Credit + '\n',
            });
        }
    </script>

    <link rel="stylesheet" href="footer.css" />

</head>

<body>
    <%--Bootstrap5min.js--%>
    <script src="../Scripts/bootstrap.min.js"></script>
    <form runat="server">

        <asp:ScriptManager runat="server" ID="Script1"></asp:ScriptManager>
        <asp:Label runat="server" ID="TxtSlNo" Visible="false"></asp:Label>
        <asp:Label runat="server" ID="lblStaffName" Visible="false"></asp:Label>
        <asp:Label runat="server" ID="lblAddedVoucher" Visible="false"></asp:Label>

        <script type="text/javascript">
            function Report() {
                $.ajax({
                    type: "POST",
                    url: "default.aspx/DayBook",
                    data: "{Project: '" + $('#cboProjectName').val() + "',datestart: '" + $('#txtStartDate').val() + "',dateend: '" + $('#txtEndDate').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        window.location.href = "../../../Home/admin/ReportPreview/ReportViewer.aspx";
                    }
                });
            }
        </script>


        <div class="form-row">
            <div class="col-12" align="right">
                <asp:Label runat="server" ID="Label1"></asp:Label>&nbsp &nbsp &nbsp
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-sm btn-danger" Text="logout" OnClick="btnLogout_Click"></asp:LinkButton>
            </div>
        </div>

        <div class="text-white" style="background-color: #221181">
            <div class="card-body">
                <h5 class="card-title text-center">Customer ID</h5>
                <p class="card-text text-center">
                    <asp:Label runat="server" ID="txtCustIDNO"></asp:Label>
                </p>
            </div>
        </div>
        <%--ProgressBar--%>
        <div class="progress" style="height: 30px">
            <div class="progress-bar bg-info" role="progressbar" aria-valuenow="99" aria-valuemin="0" aria-valuemax="100" style="width: 99%">Deposit</div>
        </div>

        <div class="container">

            <br />

            <div>
                <%-- CustAccNo --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Account No</span>
                    <asp:Label runat="server" CssClass="form-control" ID="txtCustAccNo"></asp:Label>
                </div>

                <%-- Amount --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Amount</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="txtSAamount" aria-describedby="basic-addon1" required />
                </div>

                <%-- Submit btn --%>
                <div class="col-12">
                    <div align="center">
                        <asp:Button runat="server" ID="btnSaveDeposit" CssClass="btn btn-sm btn-success" Style="width: 100%;" Text="Deposit" OnClick="btnSaveDeposit_Click" />

                    </div>
                </div>
                <br />
                <%--Print btn--%>
                <div class="col-12" runat="server" id="divPrint" visible="false">

                    <div style="height: 60px; width: auto">
                        <input type="button" id="btnPrint" class="btn btn-light" style="width: 100%; height: 60px" value="Print" onclick="Print()" />
                        <div id="dvReport" style="color: white; overflow: hidden; display: none;" class="col">

                            <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server"
                                AutoDataBind="true"
                                HasToggleGroupTreeButton="false"
                                HasToggleParameterPanelButton="false"
                                HasPageNavigationButtons="False"
                                showtogglesidepanelbutton="False"
                                showstatusbar="False"
                                showlogo="False"
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

                    </script>

                </div>


                <%--btn--%>
                <div class="footer">
                    <p class="justify-content-center">
                        <asp:LinkButton ID="btnSkip" CssClass="btn" Style="background-color: #221181; width: 100%; color: white" runat="server" Text="FINISH" OnClick="btnSkip_Click" />
                    </p>

                </div>

            </div>

        </div>

    </form>

</body>

</html>
