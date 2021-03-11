﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmDepositGrid.aspx.cs" Inherits="MFIS.Forms.Deposit.LoanDeposit.frmDepositGrid" %>

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

                    <div id="div1" runat="server">

                        <div class="col-12 d-flex align-content-center">
                            <asp:GridView runat="server" ID="gridLastPayment" AutoGenerateColumns="false" CssClass="table table-striped" HeaderStyle-CssClass="thead-dark">

                                <Columns>


                                    <asp:TemplateField HeaderText="Amount" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount" Text='<%# Bind("Cr")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Date" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblLC" Text='<%# Bind("PDate")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Type" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount2" Text='<%# Bind("DType")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>

                            </asp:GridView>
                        </div>

                    </div>

                </div>

                <div runat="server" class="form-row">
                    <div class="col d-flex align-content-center">
                        <asp:Button ID="btnShowAllHistory" runat="server" CssClass="btn btn-sm btn-light" Text="Show All" OnClick="btnShowAllHistory_Click" />
                    </div>

                    <div class="col d-flex align-content-center">
                        <asp:Button ID="btnGetReport" runat="server" CssClass="btn btn-sm btn-light" Text="GetReport" OnClick="btnGetReport_Click" />
                    </div>

                </div>
                <br />
                <%--Grid--%>
                <div class="form-row">

                    <div id="divHistory" runat="server" visible="false">

                        <div class="col-12 d-flex align-content-center">
                            <asp:GridView runat="server" ID="dgHistory" AutoGenerateColumns="false" CssClass="table table-striped" AllowPaging="true" OnPageIndexChanging="dgHistory_PageIndexChanging" PageSize="10" HeaderStyle-CssClass="thead-dark">
                                <Columns>

                                    <asp:TemplateField HeaderText="A/C no" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCustAcNo" Text='<%# Bind("AccountNo")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Amount" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount" Text='<%# Bind("PaidAmount")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Date" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblLC" Text='<%# Bind("PDate","{0:dd.MMM.yy}")%>'>asd</asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Type" Visible="true">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAmount2" Text='<%# Bind("DType")%>'>asd</asp:Label>
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
