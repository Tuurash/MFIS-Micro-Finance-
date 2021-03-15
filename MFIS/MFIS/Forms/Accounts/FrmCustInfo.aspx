<%@ Page Title="" Language="C#" MasterPageFile="~/Forms/Pages/Home.Master" AutoEventWireup="true" CodeBehind="FrmCustInfo.aspx.cs" Inherits="MFIS.Forms.Accounts.FrmCustInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="col">

        <%--##########--%>

        <div class="d-flex justify-content-center">

            <asp:DropDownList ID="dropdownSearchCriteria" runat="server" CssClass="form-control">
                <asp:ListItem Text="Select Search Criteria" Value="select"></asp:ListItem>
                <asp:ListItem Text="Search By Serial No " Value="Serial"></asp:ListItem>
                <asp:ListItem Text="Search By A/C type " Value="AccountType"></asp:ListItem>
                <asp:ListItem Text="Search By Customer ID " Value="CustomerID"></asp:ListItem>
                <asp:ListItem Text="Search By NID " Value="NID"></asp:ListItem>
            </asp:DropDownList>

            <div class="input-group rounded col-md-12 col-lg-12 col-sm-12">
                <asp:TextBox type="search" runat="server" ID="txtSearch" class="form-control rounded" placeholder="Search"></asp:TextBox>
                <span class="input-group-text border-0" id="search-addon">
                    <a runat="server" id="A1" onserverclick="btnSearch_Click">Search</a>
                </span>
            </div>

        </div>

        <%--##############--%>


        <br />

        <div class="container">

            <div class="row">

                <div id="InsertionPanel" runat="server" class="col-md-6 col-lg-6 col-sm-12">

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
                                    <asp:TextBox ID="TxtAdDate" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox></td>
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
                                    <asp:DropDownList ID="TxtCityDistrict" runat="server" CssClass="form-control">
                                    </asp:DropDownList></td>
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
                                    <asp:TextBox ID="TxtDOB" TextMode="Date" runat="server" CssClass="form-control"></asp:TextBox></td>
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

                <div id="div2" runat="server" class="col-md-6 col-lg-6 col-sm-12">

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
                                <asp:TextBox ID="TxtMobileNo" runat="server" CssClass="form-control" placeholder="01712xxxxxx"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ControlToValidate="TxtMobileNo" ErrorMessage="11 Character Required"
                                    ValidationExpression="[0-9]{11}"></asp:RegularExpressionValidator>
                            </td>

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
                        <asp:Button ID="btnInsert" runat="server" Text="Save" class="btn btn-light col" OnClick="btnInsert_Click" />
                        <asp:LinkButton ID="btnView" runat="server" Text="View" CssClass="btn btn-light col" OnClick="btnView_Click"></asp:LinkButton><br />
                        <asp:LinkButton ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-light col" OnClick="btnCancel_Click"></asp:LinkButton>
                    </div>

                </div>

            </div>

        </div>

    </div>




</asp:Content>
