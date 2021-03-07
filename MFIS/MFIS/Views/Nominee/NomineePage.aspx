<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NomineePage.aspx.cs" Inherits="MFIS.Views.Nominee.NomineePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous" />--%>
    <link rel="stylesheet" href="~/Scripts/bootstrap.min.css" />

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
                        <table>
                            <tr>
                                <th align="center">Name</th>
                                <th align="center">Age</th>
                                <th align="center">Guardian</th>
                                <th align="center">(%)</th>
                                <th align="center" colspan="2">Address</th>
                                <th align="center">Relation</th>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="TxtMobileNo" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox3" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="TextBox4" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="TextBox5" runat="server" CssClass="form-control"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <br />
                                <td colspan="7" align="right">
                                    <asp:Button ID="btnInsertNominee" runat="server" Text="Add" CssClass="btn btn-lg btn-light" />
                                </td>
                            </tr>
                        </table>
                    </div>

                </div>
            </div>

        </div>
    </form>
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>--%>
    <script src="~/Scripts/bootstrap.min.js"></script>
</body>
</html>
