<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmDepositGrid.aspx.cs" Inherits="MFIS.Forms.Deposit.LoanDeposit.frmDepositGrid" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title></title>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />--%>
    <link rel="stylesheet" href="../Scripts/bootstrap.min.css" />

    <style>
        html {
            margin-top: 2%;
            margin-left: 10%;
            margin-right: 10%;
        }
    </style>

</head>

<body>
    <form id="form1" runat="server">
        <div>

            <div class="container">
                <div class="form-row">

                    <%--Grid--%>
                    <div class="form-row">

                        <div class="col">
                            <asp:GridView runat="server" ID="dgHistory" CssClass="table table-hover table-responsive" HeaderStyle-CssClass="thead-dark">
                                <Columns>

                                    <asp:TemplateField HeaderText="Customer A/C no" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCustAcNo" Text="loanNo">asdas</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Amount" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount" Text="Aaa">asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="L/C no:" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblLC" Text="Aaa">asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Amount" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount2" Text="Aaa">asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                        </div>

                    </div>

                </div>
            </div>

        </div>
    </form>

    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>--%>
    <script src="../Scripts/bootstrap.min.js"></script>
</body>

</html>
