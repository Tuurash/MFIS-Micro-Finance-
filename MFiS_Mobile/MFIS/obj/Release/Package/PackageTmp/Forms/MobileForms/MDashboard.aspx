<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MDashboard.aspx.cs" Inherits="MFIS.Forms.MobileForms.MDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">


<head runat="server">
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->

    <link href="../Scripts/Bootstrap5.css" rel="stylesheet" />
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

        <br />
        <br />

        <div>
            <%-- Nw Account --%>
            <div class="col-12">
                <asp:Button runat="server" ID="btnNwEntry" CssClass="btn btn-light" Text="New Account" OnClick="btnNwEntry_Click" Style="width: 100%; height: 50px;" />
            </div>
            <br />
            <%-- Loan/Deposit Entry --%>
            <div class="col-12">
                <asp:Button runat="server" ID="btnLS" CssClass="btn btn-light" Text=" Loan/Deposit Entry" OnClick="btnLS_Click" Style="width: 100%; height: 50px;" />
            </div>
        </div>


    </form>
</body>
</html>
