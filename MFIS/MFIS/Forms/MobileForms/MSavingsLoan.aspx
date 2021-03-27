<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MSavingsLoan.aspx.cs" Inherits="MFIS.Forms.MobileForms.MSavingsLoan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
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
                    <asp:Label runat="server" ID="txtCustIDNO" Text="Select "></asp:Label>
                </p>
            </div>
        </div>
        <div>
            <%-- Name --%>
            <div class="input-group mb-3">
                <span class="input-group-text col-3">Name </span>
                <asp:TextBox runat="server" type="text" class="form-control" Style="text-transform: capitalize;" ID="TxtCustName" aria-describedby="basic-addon1" required />
            </div>
            <%-- L/A(loan Account): --%>
            <div class="input-group mb-3">
                <span class="input-group-text col-3">L/A: </span>
                <asp:DropDownList runat="server" ID="DropdownLAno" AutoPostBack="true" OnSelectedIndexChanged="DropdownLAno_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
            </div>
            <%-- Amount --%>
            <div class="input-group mb-3">
                <span class="input-group-text col-3">Amount </span>
                <asp:TextBox runat="server" type="txtLAAmount" class="form-control" Style="text-transform: capitalize;" ID="TextBox1" aria-describedby="basic-addon1" required />
            </div>

            <%-- S/A(loan Account): --%>
            <div class="input-group mb-3">
                <span class="input-group-text col-3">S/A: </span>
                <asp:DropDownList runat="server" ID="DropdownSAno" AutoPostBack="true" OnSelectedIndexChanged="DropdownSAno_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
            </div>
            <%-- Amount --%>
            <div class="input-group mb-3">
                <span class="input-group-text col-3">Amount </span>
                <asp:TextBox runat="server" type="txtSAamount" class="form-control" Style="text-transform: capitalize;" ID="TextBox2" aria-describedby="basic-addon1" required />
            </div>
        </div>
    </form>
</body>
</html>
