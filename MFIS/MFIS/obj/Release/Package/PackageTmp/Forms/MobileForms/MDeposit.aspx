<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MDeposit.aspx.cs" Inherits="MFIS.Forms.MobileForms.MDeposit" %>

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


    <%--Notification--%>
    <link rel="stylesheet" href="https://unpkg.com/izitoast/dist/css/iziToast.min.css">
    <script src="https://unpkg.com/izitoast/dist/js/iziToast.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        function notify(Amount) {

            var Credit = Amount
            iziToast.success({
                title: 'Successfully',
                position: 'topCenter',
                message: 'Inserted Deposit: ' + Credit + '\n',
            });
        }
    </script>

    <%--Sweet Alert Scripts--%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.0.2/dist/sweetalert2.all.min.js"></script>
    <!-- Optional: include a polyfill for ES6 Promises for IE11 -->
    <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>

    <script>
        function InsertComplete() {

            <%--var username = "<%=Session["UserName"].ToString() %>";--%>

            Swal.fire({
                position: 'center',
                icon: 'success',
                title: 'Successful',
                text: 'Redirecting..',
                showConfirmButton: false,
                timer: 1000
                //footer: '<a href>Why do I have this issue?</a>'
            }, function () {
                window.location = "~/Forms/MobileForms/MCustInfo.aspx";
            });

        }

    </script>

    <link rel="stylesheet" href="footer.css" />

</head>

<body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>

    <form runat="server">

        <asp:ScriptManager runat="server" ID="Script1"></asp:ScriptManager>
        <asp:Label runat="server" ID="TxtSlNo" Visible="false"></asp:Label>
        <asp:Label runat="server" ID="lblStaffName" Visible="false"></asp:Label>
        <asp:Label runat="server" ID="lblAddedVoucher" Visible="false"></asp:Label>

        <script type="text/javascript">
            function Report() {
                $.ajax({
                    type: "POST",
                    url: "default.aspx/DayBook",
                    data: "{Project: '" + $('#cboProjectName').val() + "',datestart: '" + $('#txtStartDate').val() + "',dateend: '" + $('#txtEndDate').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        window.location.href = "../../../Home/admin/ReportPreview/ReportViewer.aspx";
                    }
                });
            }
        </script>


        <div class="form-row">
            <div class="col-12" align="right">
                <asp:Label runat="server" ID="Label1"></asp:Label>&nbsp &nbsp &nbsp
                    <asp:LinkButton ID="btnLogout" runat="server" CssClass="btn btn-sm btn-danger" Text="logout" OnClick="btnLogout_Click"></asp:LinkButton>
            </div>
        </div>

        <div class="text-white" style="background-color: #221181">
            <div class="card-body">
                <h5 class="card-title text-center">Customer ID</h5>
                <p class="card-text text-center">
                    <asp:Label runat="server" ID="txtCustIDNO"></asp:Label>
                </p>
            </div>
        </div>
        <%--ProgressBar--%>
        <div class="progress" style="height: 30px">
            <div class="progress-bar bg-success" role="progressbar" aria-valuenow="99" aria-valuemin="0" aria-valuemax="100" style="width: 99%">Deposit</div>
        </div>

        <div class="container">

            <br />

            <div>
                <%-- CustAccNo --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Account No</span>
                    <asp:Label runat="server" CssClass="form-control" ID="txtCustAccNo"></asp:Label>
                </div>

                <%-- Amount --%>
                <div class="input-group mb-3">
                    <span class="input-group-text col-3">Amount</span>
                    <asp:TextBox runat="server" type="text" class="form-control" ID="txtSAamount" aria-describedby="basic-addon1" required />
                </div>

                <%-- Print btn --%>
                <div class="input-group mb-3">
                    <div align="center">
                        <asp:Button runat="server" ID="btnSaveDeposit" CssClass="btn btn-sm btn-success" Text="Deposit" OnClick="btnSaveDeposit_Click" />
                        <asp:LinkButton runat="server" ID="btnPrintDepositReciept" CssClass="btn btn-sm btn-light" Text="Get Report" OnClick="btnPrintDepositReciept_Click"></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="linkbtn_PrintHtml" CssClass="btn btn-sm btn-light" Text="View Report" OnClick="linkbtn_PrintHtml_Click"></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="linkbtnPrintNow" CssClass="btn btn-sm btn-light" Text="Print" OnClick="linkbtnPrintNow_Click"></asp:LinkButton>
                    </div>
                </div>

                <%--btn--%>
                <div class="footer">
                    <p class="justify-content-center">
                        <asp:LinkButton ID="btnSkip" CssClass="btn" Style="background-color: #221181; width: 100%; color: white" runat="server" Text="Save & Continue" OnClick="btnSkip_Click" />
                    </p>

                </div>

            </div>








        </div>

    </form>

</body>
</html>
