<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmMSavingsLoan.aspx.cs" Inherits="MFIS.Forms.Payment.frmMSavingsLoan" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:Label ID="lblVoucherNo" runat="server" Visible="false"></asp:Label>

        <div>

            <div align="center">
                <h2>
                    <p>Deposit & Loan Form</p>
                </h2>

                <%--<div class="form-check form-check-inline">
                    <asp:RadioButton ID="chkPDF" Text="PDF" CssClass="form-check-input" runat="server" />
                    &nbsp&nbsp<asp:RadioButton ID="chkAll" Text="All" CssClass="form-check-input" Checked="true" runat="server" />
                </div>--%>
            </div>

            <div class="container">
                <br />

                <%--Date&NAMe--%>
                <div class="form-row">
                    <div class="col-md-auto col-lg-6 col-sm-auto">
                        <label for="txtDate">Date: </label>
                        <asp:TextBox runat="server" ID="txtDate" CssClass="form-control" Enabled="false"></asp:TextBox>
                        <asp:CalendarExtender ID="txt_from_CalendarExtender" runat="server" Format="MM-dd-yyyy" SelectedDate='<%# System.DateTime.Now%>'
                            Enabled="True" TargetControlID="txtDate" Animated="true"></asp:CalendarExtender>
                    </div>

                    <div class="col-md-auto col-lg-6 col-sm-auto">
                        <label for="txtCustomerName">Customer Name: </label>
                        <asp:TextBox runat="server" ID="txtCustomerName" Enabled="false" CssClass="form-control"></asp:TextBox>
                    </div>

                </div>

                <%--ID--%>
                <div class="form-row">

                    <div class="col-md-auto col-lg-12 col-sm-auto">
                        <label for="txtIdNo">Staff ID no: </label>
                        <div class="input-group">

                            <asp:TextBox runat="server" ID="txtIdNo" AutoPostBack="true" OnTextChanged="txtIdNo_TextChanged" CssClass="form-control"></asp:TextBox>
                            <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-sm btn-light" Text="Show" OnClick="btnSearch_Click" />
                        </div>

                        <div id="ErrorTxtID" visible="false" runat="server">
                            <p style="color: red" id="P1">Not Fuound! Try Again</p>
                        </div>
                    </div>

                </div>

                <div runat="server" id="maindiv" visible="false">

                    <%--Loan--%>
                    <div class="form-row">

                        <div class="col-md-auto col-lg-6 col-sm-auto">
                            <label for="DropdownLAno">L/A(loan Account): </label>
                            <asp:DropDownList runat="server" ID="DropdownLAno" AutoPostBack="true" OnSelectedIndexChanged="DropdownLAno_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>

                            <div id="divLoanStatus" class="input-group" visible="false" runat="server">
                                <p style="color: forestgreen" runat="server" id="AmountPayable"></p>
                                &nbsp 
                                <p style="color: forestgreen" runat="server" id="LastPaidDate"></p>
                            </div>
                        </div>

                        <div class="col-md-auto col-lg-6 col-sm-auto">
                            <label for="txtAmount">Amount: </label>
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txtLAAmount" CssClass="form-control"></asp:TextBox>
                                <asp:DropDownList runat="server" ID="DropdownTransType" CssClass="form-control">
                                    <asp:ListItem Text="Payment" Value="Payment"></asp:ListItem>
                                    <asp:ListItem Text="Reciept" Value="Reciept"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <br />
                    </div>

                    <%--Savings--%>
                    <div class="form-row">

                        <div class="col-md-auto col-lg-6 col-sm-auto">
                            <label for="DropdownSAno">S/A(Savings Account): </label>
                            <asp:DropDownList runat="server" ID="DropdownSAno" CssClass="form-control"></asp:DropDownList>
                        </div>

                        <div class="col-md-auto col-lg-6 col-sm-auto">
                            <label for="txtAmount">Amount: </label>
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="txtSAamount" CssClass="form-control"></asp:TextBox>
                                <%--<asp:Button runat="server" ID="btnSAsubmit" CssClass="btn btn-sm btn-light" Text="Submit" />--%>
                            </div>
                        </div>
                        <br />
                    </div>
                    <br />

                    <%--btn--%>
                    <div class="form-row">
                        <div id="divPaymentStatus" visible="false" runat="server">
                            <p style="color: green" id="lblPaymentStatus" runat="server">Not Fuound! Try Again</p>
                            <br />
                        </div>
                        <div class="col">
                            <asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-sm btn-light" />
                            <asp:Button runat="server" ID="btnShow" Text="Show" CssClass="btn btn-sm btn-light" />
                            <asp:Button runat="server" ID="btnClear" Text="Clear" CssClass="btn btn-sm btn-light" />
                            <asp:Button runat="server" ID="btnSubmit" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-sm btn-light" />
                        </div>
                        <br />

                    </div>

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
    <script src="Scripts\bootstrap.min.js"></script>
</body>

</html>
