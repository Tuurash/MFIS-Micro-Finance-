<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Pages/Home.Master" AutoEventWireup="true" CodeBehind="NomineePage.aspx.cs" Inherits="MFIS.Forms.Accounts.NomineePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




    <section class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">Nominee</h3>
                            <br />
                        </div>
                        <!-- /.card-header -->
                        <div class="card-body">
                            <%--<table id="example2" class="table table-bordered table-hover">--%>


                            <div class="col-12">
                                
                                <table>
                                    <tr>
                                        <td><asp:TextBox type="search" runat="server" ID="txtCustAcNo" class="form-control rounded" placeholder="Search By A/C ID"></asp:TextBox></td>
                                        <td><a runat="server" id="btnSearch" class="btn btn-default" onserverclick="btnSearch_ServerClick">Search</a></td>
                                    </tr>
                                </table>

                            </div>

                            <br />

                            <div class="col-12">
                                <table class="table table-bordered table-hover">
                                    <tr>
                                        <th align="center">Name</th>
                                        <th align="center">Age</th>
                                        <th align="center">Guardian</th>
                                        <th align="center">(%)</th>
                                        <th align="center" colspan="2">Address</th>
                                        <th align="center">Relation</th>
                                    </tr>
                                    <%--1--%>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtName1" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAge1" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGuardians1" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPercent1" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRelation1" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <%--2--%>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtName2" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAge2" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGuardians2" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPercent2" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtAddress2" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRelation2" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <%--3--%>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtName3" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAge3" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGuardians3" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPercent3" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtAddress3" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRelation3" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <%--4--%>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="txtName4" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAge4" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtGuardians4" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPercent4" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtAddress4" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtRelation4" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>

                                <br />

                                <div class="d-flex align-content-center">

                                    <asp:Button ID="btnInsertNominee" runat="server" Text=" Save " CssClass="btn btn-default" OnClick="btnInsertNominee_Click" />
                                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-default" OnClick="btnUpdate_Click" />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-default" OnClick="btnDelete_Click" />
                                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-default" OnClick="btnClear_Click" />

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
