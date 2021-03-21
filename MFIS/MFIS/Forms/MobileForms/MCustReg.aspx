<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MCustReg.aspx.cs" Inherits="MFIS.Forms.MobileForms.MCustReg" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>--%>
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>--%>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="../Scripts/footer.css" />

</head>

<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <form runat="server">
        <asp:ScriptManager runat="server" ID="Script1"></asp:ScriptManager>
        <asp:Label runat="server" ID="TxtSlNo" Visible="false"></asp:Label>

        <div class="col-12">
            <table>
                <tr>
                    <td class="col">
                        <p>
                            <asp:Label runat="server" ID="lblStaffName"></asp:Label></p>
                    </td>
                    <td class="col" align="right">
                        <asp:Button ID="btnLogout" runat="server" CssClass="btn btn-sm btn-danger" Text="logout" OnClick="btnLogout_Click" /></td>
                </tr>
            </table>
        </div>

        <div class="text-white" style="background-color: #221181">
            <div class="card-body">
                <h5 class="card-title text-center">Customer ID</h5>
                <p class="card-text text-center">
                    <asp:Label runat="server" ID="txtCustIDNO" Text="112-1010-1-123"></asp:Label>
                </p>
            </div>
        </div>

        <div class="container">
            <br />
            <div class="progress">
                <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" aria-valuenow="66" aria-valuemin="0" aria-valuemax="100" style="width: 66%">Account Info</div>
            </div>
            <br />

            <div>

                <%-- CustAccNo --%>
                <div class="input-group mb-3">
                    <span class="input-group-text">Account No </span>
                    <asp:TextBox runat="server" class="form-control" ID="txtCustAccNo" aria-describedby="basic-addon1" Enabled="false" Text="Select Scheme to Auto-generate"></asp:TextBox>
                    <%--<asp:Label runat="server" CssClass="form-control" ID="txtCustAccNo"></asp:Label>--%>
                </div>

                <%--Deposit Scheme/ SubdepositCodeNo --%>
                <div class="input-group mb-2">
                    <span class="input-group-text">Deposit Scheme</span>
                    <asp:DropDownList ID="ComSub_DepositScheme" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ComSub_DepositScheme_SelectedIndexChanged" required>
                    </asp:DropDownList>
                </div>

                <%-- Month Duration --%>
                <div class="input-group mb-3">
                    <span class="input-group-text">Duration(Months)</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="txtDuration" aria-describedby="basic-addon1" AutoPostBack="true" OnTextChanged="txtDuration_TextChanged" required />
                </div>

                <%-- Min Interest --%>
                <div class="input-group mb-3">
                    <span class="input-group-text">Interest</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="TxtMIntr" aria-describedby="basic-addon1" required />
                </div>

                <%--Interest Draw status --%>
                <div class="input-group mb-2">
                    <span class="input-group-text">Interest Draw status</span>
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

</body>


</html>
