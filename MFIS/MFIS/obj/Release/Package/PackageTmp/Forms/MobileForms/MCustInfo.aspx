<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MCustInfo.aspx.cs" Inherits="MFIS.Forms.MobileForms.MCustInfo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html>

<html lang="en">

<head runat="server">
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">



    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="footer.css" />

</head>

<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

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
            <div class="progress-bar bg-success" role="progressbar" aria-valuenow="33" aria-valuemin="0" aria-valuemax="100" style="width: 33%;">Custumer Info</div>
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

</body>

</html>
