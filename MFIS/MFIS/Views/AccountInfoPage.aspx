<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountInfoPage.aspx.cs" Inherits="MFIS.Views.AccountInfoPage" %>

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

            <div align="center">

                <asp:DropDownList ID="dropdownSearchCriteria" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="dropdownSearchCriteria_SelectedIndexChanged">
                    <asp:ListItem Text="Select Search Criteria" Value="select"></asp:ListItem>
                    <asp:ListItem Text="Search By Serial No " Value="Serial"></asp:ListItem>
                    <asp:ListItem Text="Search By A/C type " Value="AccountType"></asp:ListItem>
                    <asp:ListItem Text="Search By Customer ID " Value="CustomerID"></asp:ListItem>
                    <asp:ListItem Text="Search By NID " Value="NID"></asp:ListItem>
                </asp:DropDownList>
                <%--<asp:TextBox ID="txtSearch" runat="server" CssClass="form-control-lg col" placeholder="Search" Enabled="false"></asp:TextBox>--%>
                <div class="input-group" runat="server" id="SearchPanel" visible="false">
                    <asp:TextBox AutoCompleteType="Search" ID="txtSearch" runat="server" CssClass="form-control-lg col" placeholder="Search" aria-label="Search"
                        aria-describedby="search-addon"></asp:TextBox>
                    <asp:Button type="button" runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click" class="btn btn-outline-primary" />
                </div>

            </div>

            <br />

            <div class="container">

                <div class="row">

                    <div id="InsertionPanel" runat="server" class="col">

                        <table class="d-flex justify-content-center">

                            <tbody>

                                <tr runat="server" visible="false">
                                    <td>
                                        <p style="font: small">Serial No: </p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox required ID="TxtSlNoAll" Enabled="false" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small; align-content: center">Branch Serial No: </p>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtSlNo" required runat="server" CssClass="form-control"></asp:TextBox></td>
                                    <td align="center">
                                        <p style="font: small; align-content: center">Date: </p>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtAdDate" required TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small; align-content: center">A/C Type: </p>
                                    </td>
                                    <td colspan="3">
                                        <asp:DropDownList required ID="ComAccType" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Business Account" Value="IT"></asp:ListItem>
                                            <asp:ListItem Text="Joint Account" Value="Finance"></asp:ListItem>
                                            <asp:ListItem Text="Single Account" Value="Management"></asp:ListItem>
                                            <asp:ListItem Text="Staff Account" Value="Management"></asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small; align-content: center">FieldName: </p>
                                    </td>
                                    <td>
                                        <asp:DropDownList required ID="CmbAreaCode" runat="server" CssClass="form-control">
                                        </asp:DropDownList></td>
                                    <td>
                                        <p style="font: small">City/District</p>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtCityDistrict" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Customer ID</p>
                                    </td>
                                    <td>
                                        <asp:TextBox required ID="txtCustIDNO" runat="server" CssClass="form-control"></asp:TextBox></td>

                                    <td align="center">
                                        <p style="font: small">A/C Name: </p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox required ID="TxtAccName" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Customer Name: </p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox required ID="TxtCustName" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Sex: </p>
                                    </td>
                                    <td>
                                        <asp:DropDownList required ID="ComSex" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                        </asp:DropDownList></td>
                                    <td align="center">
                                        <p style="font: xx-small">Date of Birth: </p>
                                    </td>
                                    <td>
                                        <asp:TextBox required ID="TxtDOB" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Father's Name</p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtFName" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Mother's Name</p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtMName" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Present Address</p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtPresent_Add" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Permanent Address</p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtParmanent_Add" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Spouse's Name</p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtSpouse" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>

                                <tr>
                                    <td>
                                        <p style="font: small">Police Station: </p>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtPS" runat="server" CssClass="form-control"></asp:TextBox></td>
                                    <td>
                                        <p style="font: small; align-content: center">Nationality: </p>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtCountry" runat="server" CssClass="form-control" Text="Bangladeshi"></asp:TextBox></td>
                                </tr>

                                <%-- <tr>
                                    <td>
                                        <p style="font: small">City/District</p>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtCityDistrict" runat="server" CssClass="form-control"></asp:TextBox></td>
                                </tr>--%>

                                <tr>
                                    <td>
                                        <p style="font: small">Post Code</p>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtPostCode" runat="server" CssClass="form-control"></asp:TextBox></td>

                                    <td>
                                        <p style="font: small">Religion</p>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ComReligion" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="Islam" Value="Islam"></asp:ListItem>
                                            <asp:ListItem Text="Hindu" Value="Hindu"></asp:ListItem>
                                            <asp:ListItem Text="Cristian" Value="Cristian"></asp:ListItem>
                                            <asp:ListItem Text="Buddho" Value="Buddho"></asp:ListItem>
                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                        </asp:DropDownList></td>
                                </tr>

                            </tbody>

                        </table>

                    </div>

                    <div id="div2" runat="server" class="col">

                        <table class="d-flex justify-content-center">

                            <tr>
                                <td colspan="2" align="center">
                                    <img src="../Images/ProfileImage.png" alt="profile_pic" class="img img-thumbnail" style="width: 140px; height: 140px" />
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2" align="center">
                                    <img src="../Images/autography.png" alt="profile_pic" class="img img-thumbnail" style="width: 140px; height: 70px" />
                                </td>

                            </tr>

                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button ID="btnSaveImage" runat="server" Text="Update" CssClass="btn btn-sm btn-success" />
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <br />

                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <p style="font: small">Occupation </p>
                                </td>
                                <td colspan="2">
                                    <asp:DropDownList ID="TxtOccupation" runat="server" CssClass="form-control">

                                        <asp:ListItem Text="Agriculture" Value="Agriculture"></asp:ListItem>
                                        <asp:ListItem Text="Govt Job" Value="Govt Job"></asp:ListItem>
                                        <asp:ListItem Text="Non Govt Job" Value="Non Govt Job"></asp:ListItem>
                                        <asp:ListItem Text="Housewife" Value="Housewife"></asp:ListItem>
                                        <asp:ListItem Text="Business" Value="Business"></asp:ListItem>
                                        <asp:ListItem Text="Student" Value="Student"></asp:ListItem>
                                        <asp:ListItem Text="Others" Value="Others"></asp:ListItem>

                                    </asp:DropDownList></td>
                            </tr>

                            <tr>
                                <td>
                                    <p style="font: small">Mobile No: </p>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="TxtMobileNo" runat="server" CssClass="form-control"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td>
                                    <p style="font: small">Telephone No: </p>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="TxtTel" runat="server" CssClass="form-control"></asp:TextBox></td>
                            </tr>

                            <tr>

                                <td>
                                    <asp:TextBox ID="TxtRefAccNo" placeholder="Ref ID No: " runat="server" CssClass="form-control"></asp:TextBox></td>

                                <td>
                                    <asp:TextBox ID="TxtRefName" placeholder="Ref Name:" runat="server" CssClass="form-control"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td>
                                    <p style="font: small">NID: </p>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="TxtNIDNo" runat="server" CssClass="form-control"></asp:TextBox></td>
                            </tr>

                            <tr>
                                <td>
                                    <p style="font: small">Mail</p>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="TxtMail" TextMode="Email" runat="server" CssClass="form-control"></asp:TextBox></td>
                            </tr>

                        </table>

                        <br />

                        <div id="btnPanel" class="d-flex">
                            <asp:Button ID="btnInsert" runat="server" Text="Insert" class="btn btn-success col" OnClick="btnInsert_Click" />
                            <asp:LinkButton ID="btnView" runat="server" Text="View" CssClass="btn btn-info col" OnClick="btnView_Click"></asp:LinkButton><br />
                            <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger col" OnClick="btnCancel_Click"></asp:LinkButton>
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
