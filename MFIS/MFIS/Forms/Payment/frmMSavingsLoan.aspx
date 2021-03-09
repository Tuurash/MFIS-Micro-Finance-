<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMSavingsLoan.aspx.cs" Inherits="MFIS.Forms.Payment.frmMSavingsLoan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />--%>
    <link rel="stylesheet" href="Scripts\bootstrap.min.css" />

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

            <div align="center">
                <h2>
                    <p>Deposit & Loan Form</p>
                </h2>

                <div class="form-check form-check-inline">
                    <asp:RadioButton ID="chkPDF" Text="PDF" CssClass="form-check-input" runat="server" />
                    &nbsp&nbsp<asp:RadioButton ID="chkAll" Text="All" CssClass="form-check-input" Checked="true" runat="server" />
                </div>
            </div>

            <div class="container">
                <br />
                <div class="form-row">
                    <div class="col">
                        <label for="inputEmail4">Date: </label>
                        <asp:TextBox runat="server" ID="txtDate" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col">
                        <label for="inputEmail4">ID no: </label>
                        <asp:TextBox runat="server" ID="txtIdNo" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col">
                        <label for="inputEmail4">Customer Name: </label>
                        <asp:TextBox runat="server" ID="txtCustomerName" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col">
                        <label for="inputEmail4">Voucher no: </label>
                        <asp:TextBox runat="server" ID="txtVoucherNo" CssClass="form-control"></asp:TextBox>
                    </div>



                </div>
                <br />
                <div class="form-row">
                    <div class="col">
                        <asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-sm btn-light" />
                        <asp:Button runat="server" ID="btnShow" Text="Show" CssClass="btn btn-sm btn-light" />
                        <asp:Button runat="server" ID="btnClear" Text="Clear" CssClass="btn btn-sm btn-light" />
                        <asp:Button runat="server" ID="btnSubmit" Text="Submit" CssClass="btn btn-sm btn-light" />
                    </div>
                    <br />

                </div>

                <div class="form-row">

                    <div class="col">
                        <asp:GridView runat="server" ID="dgDeposit" CssClass="table table-hover table-responsive" HeaderStyle-CssClass="thead-dark">
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

                            </Columns>
                        </asp:GridView>
                    </div>

                    <div class="col">
                        <asp:GridView runat="server" ID="dgLoan" CssClass="table table-hover table-responsive" HeaderStyle-CssClass="thead-dark">
                            <Columns>
                                <asp:TemplateField HeaderText="Loan No" Visible="true">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblLoanNo" Text="loanNo">sd</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Amount" Visible="true">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblAmount" Text="Aaa">asdsa</asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </div>

                </div>

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



    </form>

    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>--%>
    <script src="Scripts\bootstrap.min.js"></script>
</body>
</html>
