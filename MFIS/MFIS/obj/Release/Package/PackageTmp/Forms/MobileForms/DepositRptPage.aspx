<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DepositRptPage.aspx.cs" Inherits="MFIS.Forms.MobileForms.DepositRptPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
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
    <form id="form1" runat="server" style="font-size: 20px">

        <div align="right">
            <p style="font-size: 14px;">
                Print:
                <asp:Label runat="server" ID="lblPrintDate" Text='<%# DateTime.Now.ToString() %>'></asp:Label>
            </p>
        </div>
        <div style="margin-top: 15%; margin-left: 5%; margin-right: 5%">



            <table>
                <tr>
                    <td colspan="2">
                        <p style="font: bold">
                            ID:
                            <asp:Label runat="server" ID="lblID">112-004941</asp:Label>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="font: bold">Name:
                        <asp:Label runat="server" ID="lblName">Afsal Ali Akando</asp:Label></p></td>
                </tr>
                <tr>
                    <td colspan="2" style="font: bold">
                        <asp:Label runat="server" ID="lblVouchar">1231231231231231231231231231</asp:Label></p></td>
                </tr>
            </table>

            <asp:GridView runat="server" ID="gridReport" CssClass="table"
                ShowFooter="true" AutoGenerateColumns="false"
                BorderStyle="Dotted">
                <Columns>

                    <asp:TemplateField HeaderText="A/C No" Visible="true">
                        <ItemTemplate>
                            <asp:Label ID="lblAccNo" runat="server" Text='<%# Bind("AccountNo")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Type" Visible="true">
                        <ItemTemplate>
                            <asp:Label ID="lblAccType" runat="server" Text='<%# Bind("DType")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Amount" Visible="true">
                        <ItemTemplate>
                            <asp:Label ID="lblAmount" runat="server" Text='<%# Bind("Cr")%>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>


            </asp:GridView>

        </div>
    </form>
</body>
</html>
