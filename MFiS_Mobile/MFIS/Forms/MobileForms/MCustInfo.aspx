<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MCustInfo.aspx.cs" Inherits="MFIS.Forms.MobileForms.MCustInfo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html lang="en">

<head runat="server">
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

     <!-- Preloader -->
        <div id="spinner">
        </div>

    <form runat="server">
        <asp:ScriptManager runat="server" ID="Script1"></asp:ScriptManager>
        <asp:Label runat="server" ID="TxtSlNo" Visible="false"></asp:Label>


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
                    <asp:Label runat="server" ID="txtCustIDNO" Text="112-1010-1-123"></asp:Label>
                </p>
            </div>
        </div>


        <div class="progress" style="height: 30px">
            <div class="progress-bar bg-info" role="progressbar" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100" style="width: 33%;">Custumer Info</div>
        </div>
        <div class="container">
            <br />



            <div>

                <%-- Name --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Name </span>
                    <asp:TextBox runat="server" type="text" class="form-control" Style="text-transform: capitalize;" ID="TxtCustName" aria-describedby="basic-addon1" required />

                </div>

                <%--Gender--%>
                <div class="input-group mb-2">
                    <span class="input-group-text col-3">Gender</span>
                    <asp:DropDownList ID="ComSex" runat="server" CssClass="form-control" required>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <%--Account Type--%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3" id="basic-addon3">Ac Type</span>
                    <asp:DropDownList ID="ComAccType" runat="server" CssClass="form-control" aria-describedby="basic-addon3" required>
                        <asp:ListItem Text="Single Account" Value="Management"></asp:ListItem>
                        <asp:ListItem Text="Business Account" Value="IT"></asp:ListItem>
                        <asp:ListItem Text="Joint Account" Value="Finance"></asp:ListItem>

                        <asp:ListItem Text="Staff Account" Value="Management"></asp:ListItem>
                    </asp:DropDownList>

                    <div class="invalid-tooltip">
                        Please provide a valid District.
                    </div>
                </div>
                <%--DateOfBirth--%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3" id="basic-addon4">DOB</span>
                    <asp:TextBox ID="TxtDOB" runat="server" CssClass="form-control" aria-describedby="basic-addon4" required></asp:TextBox>
                    <asp:CalendarExtender ID="txt_from_CalendarExtender" runat="server" Format="MM-dd-yyyy"
                        SelectedDate='<%# System.DateTime.Now%>'
                        Enabled="True"
                        TargetControlID="TxtDOB"
                        Animated="true"></asp:CalendarExtender>
                </div>
                <%--Phone Number--%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3" id="basic-addon5">Phone </span>
                    <asp:TextBox ID="TxtMobileNo" runat="server" CssClass="form-control" Style="padding: 20px" placeholder="01712xxxxxx" MaxLength="11" aria-describedby="basic-addon5" required></asp:TextBox>

                    <div class="invalid-tooltip">
                        Please provide a valid Phone Number.
                    </div>

                </div>

                <%--NID--%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3" id="basic-addon3">NID </span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="TxtNIDNo" aria-describedby="basic-addon3" />
                </div>
                <%--City?District--%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">District</span>
                    <asp:DropDownList ID="TxtCityDistrict" runat="server" CssClass="form-control" aria-describedby="basic-addon3">
                        <asp:ListItem Text="Business Account" Value="IT"></asp:ListItem>
                        <asp:ListItem Text="Joint Account" Value="Finance"></asp:ListItem>
                        <asp:ListItem Text="Single Account" Value="Management"></asp:ListItem>
                        <asp:ListItem Text="Staff Account" Value="Management"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div align="center">
                    <p>
                        <asp:Label runat="server" ID="lblCustinfoStatus" Style="color: red" Visible="false"></asp:Label>
                    </p>
                </div>

                <%--Footer--%>
                <div class="footer">
                    <p class="justify-content-center">
                        <asp:LinkButton ID="btnSubmitCustInfo" CssClass="btn" Style="background-color: #221181; width: 100%; color: white" runat="server" Text="Save & Continue" OnClick="btnSubmitCustInfo_Click" />
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
