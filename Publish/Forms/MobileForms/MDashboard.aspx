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

        function loader() { $("#spinner").fadeOut(1000); }
    </script>

</head>


<body>
    <form id="form1" runat="server">
         <!-- Preloader -->
        <div id="spinner">
        </div>

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

    <script src="../Scripts/dist/jquery1.11.js"></script>
    <script>
        $(document).ready(function () { $("#spinner").fadeOut(1000); });
    </script>


</body>
</html>
