<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountDetailsPage.aspx.cs" Inherits="MFIS.Views.AccountDetailsPage" %>

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
        <div class="container">
            <div class="row">

                <div class="col-12">

                    <div class="d-flex justify-content-center">

                        <div class="input-group rounded">
                            <asp:DropDownList runat="server" ID="dropDownSort" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dropDownSort_SelectedIndexChanged">
                                <asp:ListItem Text="Sort By" Value="SortBy"></asp:ListItem>
                                <asp:ListItem Text="Serial" Value="SlNoAll"></asp:ListItem>
                                <asp:ListItem Text="Opening Date" Value="AdDate"></asp:ListItem>
                                <asp:ListItem Text="Customer Name" Value="CustName"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="input-group rounded">
                            <asp:TextBox type="search" runat="server" ID="txtSearch" class="form-control rounded" placeholder="Search By A/C Name"></asp:TextBox>
                            <span class="input-group-text border-0" id="search-addon">
                                <a runat="server" id="btnSearch" onserverclick="Search">Search</a>
                            </span>
                        </div>

                        <asp:LinkButton ID="btnGetReport" runat="server" Text="Genearate Report" CssClass="btn btn-success" CommandArgument='<%# Bind("AutoSLNo")%>' OnClick="btnEdit_Click" />

                    </div>

                    <hr />
                </div>

                <div class="col-12" runat="server">
                    <asp:GridView runat="server" ID="GridAccountList" CssClass="table table-hover table-responsive" AllowPaging="true"
                        HeaderStyle-CssClass="thead-dark" PageSize="5" OnPageIndexChanging="OnPaging">
                        <Columns>
                            <asp:TemplateField HeaderText="Options" Visible="true">
                                <ItemTemplate>
                                    <p>
                                        <asp:LinkButton ID="btnEdit" runat="server" Text="Update" CssClass="btn btn-sm btn-success" CommandArgument='<%# Bind("AutoSLNo")%>' OnClick="btnEdit_Click" />
                                    </p>
                                    <p>
                                        <asp:LinkButton ID="btnGetReportByID" runat="server" Text="Report" CssClass="btn btn-sm btn-info" CommandArgument='<%# Bind("AutoSLNo")%>' OnClick="btnEdit_Click" />
                                    </p>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

            </div>
        </div>
    </form>

    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>--%>
    <script src="../Scripts/bootstrap.min.js"></script>
</body>

</html>
