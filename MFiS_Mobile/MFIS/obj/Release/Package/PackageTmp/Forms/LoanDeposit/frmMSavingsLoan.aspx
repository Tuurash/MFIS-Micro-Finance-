<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Pages/Home.Master" AutoEventWireup="true" CodeBehind="frmMSavingsLoan.aspx.cs" Inherits="MFIS.Forms.LoanDeposit.frmMSavingsLoan" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:Label ID="lblVoucherNo" runat="server" Visible="false"></asp:Label>


    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Loan & Savings</h3>
                            <br />
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">


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

                            <%--ID--%><br />

                            <div class="form-row">

                                <div class="col-md-auto col-lg-12 col-sm-auto">
                                    <label for="txtIdNo">Customer ID no: </label>

                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox runat="server" ID="txtIdNo" AutoPostBack="true" OnTextChanged="txtIdNo_TextChanged" CssClass="form-control"></asp:TextBox></td>
                                            <td>
                                                <asp:Button runat="server" ID="btnSearch" CssClass="btn btn-default" Text="Show" OnClick="btnSearch_Click" /></td>
                                        </tr>
                                    </table>

                                    <div id="ErrorTxtID" visible="false" runat="server">
                                        <p style="color: red" id="P1">Not Found! Try Again</p>
                                    </div>
                                </div>

                            </div>

                            <div runat="server" id="maindiv">

                                <%--Loan--%>
                                <div class="form-row">

                                    <div class="col-md-6 col-lg-6 col-sm-auto">
                                        <label for="DropdownLAno">L/A(loan Account): </label>
                                        <asp:DropDownList runat="server" ID="DropdownLAno" AutoPostBack="true" OnSelectedIndexChanged="DropdownLAno_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>

                                        <div id="divLoanStatus" visible="false" runat="server">
                                            <p style="color: forestgreen" runat="server" id="AmountPayable"></p>
                                            <br />
                                            <p style="color: forestgreen" runat="server" id="LastPaidDate"></p>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-lg-6 col-sm-auto">
                                        <label for="txtAmount">Amount: </label>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="txtLAAmount" CssClass="form-control"></asp:TextBox>
                                            <asp:DropDownList runat="server" ID="DropdownTransType" Visible="false" CssClass="form-control">
                                                <asp:ListItem Text="Payment" Value="Payment"></asp:ListItem>
                                                <asp:ListItem Text="Reciept" Value="Reciept" Selected="True"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <br />
                                </div>

                                <%--Savings--%>
                                <div class="form-row">

                                    <div class="col-md-6 col-lg-6 col-sm-auto">
                                        <label for="DropdownSAno">S/A(Savings Account): </label>
                                        <asp:DropDownList runat="server" ID="DropdownSAno" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="DropdownSAno_SelectedIndexChanged"></asp:DropDownList>

                                        <div id="divSAStatus" visible="false" runat="server">
                                            <p style="color: forestgreen" runat="server" id="txtSAlastpaidDate"></p>
                                            <br />
                                            <p style="color: forestgreen" runat="server" id="txtSALastPaidAmount"></p>
                                        </div>

                                    </div>

                                    <div class="col-md-6 col-lg-6 col-sm-auto">
                                        <label for="txtAmount">Amount: </label>
                                        <div class="input-group">
                                            <asp:TextBox runat="server" ID="txtSAamount" CssClass="form-control"></asp:TextBox>
                                            <%--<asp:Button runat="server" ID="btnSAsubmit" CssClass="btn btn-sm btn-light" Text="Submit" />--%>
                                        </div>
                                    </div>
                                    <br />
                                </div>
                                <br />

                                <%--FinalStatus--%>
                                <div class="form-row">
                                    <div id="divPaymentStatus" visible="false" runat="server">
                                        <p style="color: green" id="lblPaymentStatus" runat="server">Not Fuound! Try Again</p>
                                        <p style="color: green" id="lblSAPaymentStatus" runat="server">Not Fuound! Try Again</p>

                                    </div>
                                </div>
                                <br />
                                <br />
                                <%--btn--%>
                                <div class="form-row">
                                    <div class="col" align="right">
                                        <%--<asp:Button runat="server" ID="btnPrint" Text="Print" CssClass="btn btn-sm btn-light" />--%>
                                        <asp:Button runat="server" ID="btnShow" Text="Show All" OnClick="btnShow_Click" CssClass="btn btn-default" />
                                        <asp:Button runat="server" ID="btnClear" Text="Clear" CssClass="btn btn-default" />
                                        <asp:Button runat="server" ID="btnSubmit" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn btn-default" />
                                    </div>
                                    <br />

                                </div>


                            </div>
                            <!-- /.card-body -->
                        </div>

                    </div>

                </div>

            </div>
    </section>


</asp:Content>
