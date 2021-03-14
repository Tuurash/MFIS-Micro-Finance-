<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Pages/Home.Master" AutoEventWireup="true" CodeBehind="FrmMemberView.aspx.cs" Inherits="MFIS.Forms.Accounts.FrmMemberView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container">
        <div class="row">

            <div class="col-12">

                <table>
                    <tr>
                        <td>
                            <asp:DropDownList runat="server" ID="dropDownSort" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dropDownSort_SelectedIndexChanged">
                                <asp:ListItem Text="Sort By" Value="SortBy"></asp:ListItem>
                                <asp:ListItem Text="Serial" Value="SlNoAll"></asp:ListItem>
                                <asp:ListItem Text="Opening Date" Value="AdDate"></asp:ListItem>
                                <asp:ListItem Text="Customer Name" Value="CustName"></asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:TextBox type="search" runat="server" ID="txtSearch" class="form-control rounded" placeholder="Search By A/C Name"></asp:TextBox>

                        </td>
                        <td>
                            <asp:Button runat="server" ID="btnSearch" Text="Search" CssClass="btn btn-light" OnClick="Search" />
                        </td>

                    </tr>
                </table>

                <div align="right">
                    <asp:LinkButton ID="btnGetReport" runat="server" Text="Genearate Report" CssClass="btn btn-success" CommandArgument='<%# Bind("AutoSLNo")%>' OnClick="btnEdit_Click" />
                </div>

                <hr />
            </div>

            <div class="col-12" runat="server">
            </div>

        </div>
    </div>

    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"></h3>
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <%--<table id="example2" class="table table-bordered table-hover">--%>
                            <asp:GridView runat="server" ID="GridAccountList" CssClass="table table-bordered table-hover" AllowPaging="true"
                                AutoGenerateColumns="false" HeaderStyle-CssClass="thead-dark" PageSize="50" OnPageIndexChanging="OnPaging">
                                <Columns>

                                    <asp:TemplateField HeaderText="Options" Visible="true">
                                        <ItemTemplate>

                                            <asp:LinkButton ID="btnEdit" runat="server" Text="Update" CssClass="btn btn-sm btn-light" CommandArgument='<%# Bind("AutoSLNo")%>' OnClick="btnEdit_Click" />
                                            <asp:LinkButton ID="btnGetReportByID" runat="server" Text="Report" CssClass="btn btn-sm btn-light" CommandArgument='<%# Bind("AutoSLNo")%>' OnClick="btnEdit_Click" />
                                            <asp:LinkButton ID="btnAccountReg" runat="server" Text="Account Reg." CssClass="btn btn-sm btn-light" CommandArgument='<%# Bind("CustIDNO")%>' OnClick="btnAccountReg_Click" />

                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Sl No">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblSlNo" Text='<%# Bind("SlNO")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Date" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAdDate" Text='<%# Bind("AdDate")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="ID no">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblCustIDNo" Text='<%# Bind("CustIDNO")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Type">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAcType" Text='<%# Bind("AccType")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="A/C Name">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAccName" Text='<%# Bind("AccName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Perm_Address" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblPerm_Address" Text='<%# Bind("Parmanent_Add")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="NID">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblNIDNo" Text='<%# Bind("NIDNo")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Mobile">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblMobile" Text='<%# Bind("Mobile")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Ref_A/C" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblRefAc" Text='<%# Bind("RefAccNo")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Ref_Name" Visible="false">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblRefName" Text='<%# Bind("RefName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="BranchCode">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblBranchCode" Text='<%# Bind("BranchCode")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="AreaCode">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="lblAreaCode" Text='<%# Bind("AreaCode")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                        </div>
                        <!-- /.card-body -->
                    </div>

                </div>

            </div>

        </div>

    </section>


</asp:Content>
