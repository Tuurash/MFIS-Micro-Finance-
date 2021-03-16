<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MCustInfo.aspx.cs" Inherits="MFIS.Forms.MobileForms.MCustInfo" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>MFIS</title>
    <meta charset="etf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">

    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>--%>
    <%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>--%>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>



</head>
<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <form runat="server">

        <div class="container">

            <%--<div align="right">
                <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-sm btn-danger" Text="logout" />
            </div>--%>

            <nav>
                <div class="nav nav-tabs" align="center" id="nav-tab" role="tablist">
                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Basic Info</button>
                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Account</button>
                    <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">Deposit</button>
                </div>
                <div align="center">
                    <br />
                    <p>
                        <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-sm btn-danger" Text="logout" OnClick="btnLogout_Click" /></p>
                </div>
            </nav>


            <div class="tab-content" id="nav-tabContent">
                <%--Tab Customer Information--%>
                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">

                    <p>
                        <h4>Customer Information</h4>
                    </p>
                    <div class="bg-dark text-white">

                        <div class="card-body">
                            <h5 class="card-title text-center">Customer ID</h5>
                            <p class="card-text text-center">
                                <asp:Label runat="server" ID="txtCustIDNO" Text="112-1010-1-123"></asp:Label>
                            </p>
                        </div>

                    </div>
                    <br />




                    <%-- Name --%>
                    <div class="input-group mb-3">
                        <span class="input-group-text">Name </span>
                        <asp:TextBox runat="server" type="text" class="form-control" ID="TxtCustName" aria-describedby="basic-addon1" required />

                    </div>

                    <%--Gender--%>
                    <div class="input-group mb-2">
                        <span class="input-group-text">Gender</span>
                        <asp:DropDownList ID="ComSex" runat="server" CssClass="form-control" required>
                            <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                            <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <%--Account Type--%>
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon3">Account Type</span>
                        <asp:DropDownList ID="ComAccType" runat="server" CssClass="form-control" aria-describedby="basic-addon3" required>
                            <asp:ListItem Text="Business Account" Value="IT"></asp:ListItem>
                            <asp:ListItem Text="Joint Account" Value="Finance"></asp:ListItem>
                            <asp:ListItem Text="Single Account" Value="Management"></asp:ListItem>
                            <asp:ListItem Text="Staff Account" Value="Management"></asp:ListItem>
                        </asp:DropDownList>

                        <div class="invalid-tooltip">
                            Please provide a valid District.
                        </div>
                    </div>
                    <%--DateOfBirth--%>
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon4">Birth Date</span>
                        <asp:TextBox ID="TxtDOB" runat="server" CssClass="form-control" TextMode="Date" aria-describedby="basic-addon4" required></asp:TextBox>
                    </div>
                    <%--Phone Number--%>
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon5">Phone </span>
                        <asp:TextBox ID="TxtMobileNo" runat="server" CssClass="form-control" Style="padding: 20px" placeholder="01712xxxxxx" MaxLength="11" aria-describedby="basic-addon5" required></asp:TextBox>

                        <div class="invalid-tooltip">
                            Please provide a valid Phone Number.
                        </div>

                    </div>

                    <%--NID--%>
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon3">NID </span>
                        <asp:TextBox runat="server" type="text" class="form-control" ID="TxtNIDNo" aria-describedby="basic-addon3" />
                    </div>
                    <%--City?District--%>
                    <div class="input-group mb-3">
                        <span class="input-group-text">District</span>
                        <asp:DropDownList ID="TxtCityDistrict" runat="server" CssClass="form-control" aria-describedby="basic-addon3">
                            <asp:ListItem Text="Business Account" Value="IT"></asp:ListItem>
                            <asp:ListItem Text="Joint Account" Value="Finance"></asp:ListItem>
                            <asp:ListItem Text="Single Account" Value="Management"></asp:ListItem>
                            <asp:ListItem Text="Staff Account" Value="Management"></asp:ListItem>
                        </asp:DropDownList>
                    </div>


                    <%--Footer--%>

                    <style>
                        .footer {
                            position: fixed;
                            left: 0;
                            bottom: 0;
                            width: 100%;
                            background-color: #343a40;
                            color: white;
                            height: 40px;
                            text-align: center;
                        }
                    </style>

                    <div class="footer">
                        <p class="justify-content-center">
                            <asp:Button ID="btnSubmitCustInfo" CssClass="btn btn-dark" Style="width=100%" runat="server" Text="Save & Continue" OnClick="btnSubmitCustInfo_Click" />
                        </p>


                    </div>

                </div>
                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">...</div>
                <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">...</div>
            </div>


        </div>

    </form>

</body>
</html>
