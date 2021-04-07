<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MCustReg.aspx.cs" Inherits="MFIS.Forms.MobileForms.MCustReg" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="../Scripts/Bootstrap5.css" rel="stylesheet" />
    <link rel="stylesheet" href="footer.css" />


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

    <script src="../Scripts/bootstrap.min.js"></script>

    <form runat="server">
        <asp:ScriptManager runat="server" ID="Script1"></asp:ScriptManager>
        <asp:Label runat="server" ID="TxtSlNo" Visible="false"></asp:Label>


         <!-- Preloader -->
        <div id="spinner">
        </div>


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
                    <asp:Label runat="server" ID="txtCustIDNO"></asp:Label>
                </p>
            </div>
        </div>
        <div class="progress" style="height: 30px">
            <div class="progress-bar bg-info" role="progressbar" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100" style="width: 66%">Account Info</div>
        </div>
        <div class="container">

            <br />

            <div>

                <%-- CustAccNo --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-4">Account No </span>
                    <asp:TextBox runat="server" class="form-control" ID="txtCustAccNo" aria-describedby="basic-addon1" Enabled="false" Text="Select Scheme to Auto-generate"></asp:TextBox>
                    <%--<asp:Label runat="server" CssClass="form-control" ID="txtCustAccNo"></asp:Label>--%>
                </div>

                <%-- Min Interest --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-4">Interest</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="TxtMIntr" Enabled="false" aria-describedby="basic-addon1" required />
                </div>


                <%--Deposit Scheme/ SubdepositCodeNo --%>
                <div class="input-group mb-2">
                    <span class="input-group-text col-6">Deposit Scheme</span>
                    <asp:DropDownList ID="ComSub_DepositScheme" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ComSub_DepositScheme_SelectedIndexChanged" required>
                    </asp:DropDownList>
                </div>





                <%-- Month Duration --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-6">Duration(Months)</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="txtDuration" TextMode="Number" min="6" max="60" step="6" aria-describedby="basic-addon1" AutoPostBack="true" OnTextChanged="txtDuration_TextChanged" required />
                </div>

                <%--Interest Draw status --%>
                <div class="input-group mb-2">
                    <span class="input-group-text col-6">Interest Draw status</span>
                    <asp:DropDownList ID="ComInterestDrawStatus" runat="server" CssClass="form-control" required>
                        <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
                        <asp:ListItem Text="Quarterly" Value="Quarterly"></asp:ListItem>
                        <asp:ListItem Text="HalfYearly" Value="HalfYearly"></asp:ListItem>
                        <asp:ListItem Text="Annually" Value="Annually"></asp:ListItem>
                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                    </asp:DropDownList>
                </div>


                <%--btn--%>
                <div class="footer">
                    <p class="justify-content-center">
                        <asp:Button ID="btnSubmitAccountInfo" CssClass="btn" Style="background-color: #221181; width: 100%; color: white" runat="server" Text="Save & Continue" OnClick="btnSubmitAccountInfo_Click" />
                    </p>
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
