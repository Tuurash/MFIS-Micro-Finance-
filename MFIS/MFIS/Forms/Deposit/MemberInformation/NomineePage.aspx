<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NomineePage.aspx.cs" Inherits="MFIS.Forms.MemberInformation.NomineePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />--%>
    <link rel="stylesheet" href="..\Scripts\bootstrap.min.css" />

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
                <div class="row">
                    <div class="col-12">
                        <div class="input-group rounded">
                            <asp:TextBox type="search" runat="server" ID="txtCustAcNo" class="form-control rounded" placeholder="Search By A/C Name"></asp:TextBox>
                            <span class="input-group-text border-0" id="search-addon">
                                <a runat="server" id="btnSearch" onserverclick="btnSearch_ServerClick">Search</a>
                            </span>
                        </div>
                    </div>
                    <div class="col-12">
                        <table>
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

                            <asp:Button ID="btnInsertNominee" runat="server" Text=" Save " CssClass="btn btn-sm btn-light" OnClick="btnInsertNominee_Click" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-lg btn-light" OnClick="btnUpdate_Click" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-lg btn-light" OnClick="btnDelete_Click" />
                            <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-lg btn-light" OnClick="btnClear_Click" />

                        </div>

                    </div>

                </div>
            </div>

        </div>

    </form>



    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>--%>
    <script src="..\Scripts\bootstrap.min.js"></script>
</body>
</html>
