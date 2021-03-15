<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Pages/Home.Master" AutoEventWireup="true" CodeBehind="FrmAccReg.aspx.cs" Inherits="MFIS.Forms.Accounts.FrmAccReg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">



    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Account Registration</h3>
                            <br />
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">

                            <div class="container">

                                <div class="row">

                                    <div id="InsertionPanel" runat="server" class="col-md-6 col-lg-6 col-sm-12">

                                        <table class="d-flex justify-content-center">

                                            <tbody>
                                                <%--Serial No--%>
                                                <tr runat="server" visible="false">
                                                    <td>
                                                        <p style="font: small">Serial No: </p>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:TextBox required ID="TxtSlNo" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox></td>
                                                </tr>
                                                <%--CustomerId no, Date--%>
                                                <tr>
                                                    <td>
                                                        <p style="font: small; align-content: center">CustomerId no:</p>
                                                    </td>
                                                    <td colspan="">
                                                        <asp:TextBox ID="txtCustIDNO" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox></td>

                                                    <td>
                                                        <asp:LinkButton ID="btnViewCustomer" runat="server" CssClass="btn btn-sm btn-light" Text="view" OnClick="btnViewCustomer_Click"></asp:LinkButton></td>
                                                </tr>


                                                <%--Customer Name--%>
                                                <tr>
                                                    <td>
                                                        <p style="font: small">Customer Name: </p>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:TextBox required ID="TxtCustName" runat="server" CssClass="form-control"></asp:TextBox></td>
                                                </tr>

                                                <%--Deposit Scheme--%>
                                                <tr>
                                                    <td>
                                                        <p style="font: small">Deposit Scheme: </p>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:DropDownList required ID="ComSub_DepositScheme" runat="server" CssClass="form-control">
                                                        </asp:DropDownList></td>
                                                </tr>

                                                <%--Passbook no--%>


                                                <%--TxtSV_AccNo--%>
                                                <tr>
                                                    <td>
                                                        <p style="font: small">Savings Account no:</p>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:TextBox ID="TxtSV_AccNo" runat="server" CssClass="form-control"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <p style="font: small; align-content: center">Date: </p>
                                                    </td>
                                                    <td colspan="3">
                                                        <asp:TextBox ID="txtIssueDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox></td>
                                                </tr>

                                            </tbody>

                                        </table>

                                        <br />

                                        <div id="btnPanel" class="d-flex align-content-end">
                                            <asp:Button ID="btnInsert" runat="server" Text="Save" class="btn btn-default col" OnClick="btnInsert_Click" />
                                            <asp:Button ID="btnUpdate" runat="server" Text="Update" class="btn btn-default col" OnClick="btnUpdate_Click" />
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete" class="btn btn-default col" OnClick="btnDelete_Click" />
                                            <asp:LinkButton ID="btnNominee" runat="server" Text="Nominee" CssClass="btn btn-default col" OnClick="btnNominee_Click"></asp:LinkButton><br />
                                            <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-light col" OnClick="btnCancel_Click"></asp:LinkButton>
                                        </div>

                                        <br />
                                    </div>

                                    <div id="div2" runat="server" class="col-md-6 col-lg-6 col-sm-12">

                                        <table class="d-flex justify-content-center">

                                            <%--Matured Date--%>
                                            <tr>
                                                <td align="center">
                                                    <p style="font: xx-small">Matured Date: </p>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="TxtMaturedDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox></td>
                                            </tr>

                                            <%--Customer Account No--%>
                                            <tr>
                                                <td>
                                                    <p style="font: small">Customer Account No: </p>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtCustAccNo" runat="server" CssClass="form-control"></asp:TextBox></td>
                                            </tr>

                                            <%--Duration(Month)--%>
                                            <tr>
                                                <td>
                                                    <p style="font: small">Duration(Months): </p>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control"></asp:TextBox></td>
                                            </tr>

                                            <%--Rate of Interest--%>
                                            <tr>
                                                <td>
                                                    <p style="font: small">Rate of Interest: </p>
                                                </td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="TxtMIntr" runat="server" CssClass="form-control"></asp:TextBox></td>
                                            </tr>

                                            <%--Interest Draw Status--%>
                                            <tr>
                                                <td>
                                                    <p style="font: small">Interest Draw Status: </p>
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ComInterestDrawStatus" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
                                                        <asp:ListItem Text="Quarterly" Value="Quarterly"></asp:ListItem>
                                                        <asp:ListItem Text="HalfYearly" Value="HalfYearly"></asp:ListItem>
                                                        <asp:ListItem Text="Annually" Value="Annually"></asp:ListItem>
                                                        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <p style="font: small">Active/Inactive</p>
                                                </td>
                                                <td colspan="3">
                                                    <asp:DropDownList ID="ComActive_InActive" TextMode="Email" runat="server" CssClass="form-control">
                                                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                                        <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>

                                        </table>

                                    </div>

                                </div>

                                <div class="col-md-12 col-lg-12 col-sm-12" runat="server">
                                    <asp:GridView runat="server" ID="DataGrid" CssClass="table table-bordered table-hover dataTable dtr-inline" AllowPaging="true"
                                        HeaderStyle-CssClass="thead-dark" PageSize="20" AutoGenerateColumns="false">
                                        <%--OnPageIndexChanging="OnPaging"--%>

                                        <Columns>

                                            <asp:TemplateField HeaderText="DATE" Visible="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate" runat="server" Text='<%# Bind("PDate")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Customer ID" Visible="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCustID" runat="server" Text='<%# Bind("CustIDNO")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Customer A/C" Visible="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCustAcc" runat="server" Text='<%# Bind("CustAccNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Scheme Code" Visible="true">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSchemeCode" runat="server" Text='<%# Bind("SubDepositCodeNo")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Options" Visible="true">
                                                <ItemTemplate>

                                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm btn-default" CommandArgument='<%# Bind("CustAccNo")%>' OnClick="btnEdit_Click" />


                                                    <asp:LinkButton ID="btnGetReportByID" runat="server" Text="Report" CssClass="btn btn-sm btn-default" CommandArgument='<%# Bind("CustIDNO")%>' />

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>

                            </div>

                        </div>
                        <!-- /.card-body -->
                    </div>

                </div>

            </div>

        </div>

    </section>



</asp:Content>
