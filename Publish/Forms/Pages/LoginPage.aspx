<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="MFIS.Pages.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>GPAC Software</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />

    <%--Jquery--%>
    <script src="../Scripts/dist/jquery1.11.js"></script>



    <!-- Bootstrap 3.3.6 -->
    <link href="../Scripts/Bootstrap5.css" rel="stylesheet" />
    <!-- Font Google -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../Scripts/dist/css/AdminLTE.min.css" />
    <!-- iCheck -->
    <link rel="stylesheet" href="../Scripts/plugins/iCheck/square/blue.css" />

    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

    <script>
        function goto_forget_password() {
            alert("Sorry!!! This feature isn't available right now");
        }
    </script>


    <%--Loading Animation attempt--%>
    <style>
        #spinner {
            position: fixed;
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            z-index: 9999;
            /*Change your loading image here*/
            background: url(../Scripts/dist/img/Loading-unscreen.gif) 50% 50% no-repeat #ede9df;
        }
    </style>
    <script>
        //Change the 5000 to a value which you need so that loading image shows till your page completely
        $(window).load(function () { $("#spinner").fadeOut(500); })

        function loader() { $("#spinner").fadeOut(500); }
    </script>

</head>

<body class="hold-transition login-page">

    <form id="form1" runat="server">

        <!-- Preloader -->
        <div id="spinner">
        </div>


        <div class="login-box">

            <div class="login-box-body">
                <div class="row">
                    <div class="col-lg-12 col-md-12 col-sm-12" align="center">
                        <div class="header" align="center">
                            <h2>User login</h2>
                            <br />
                        </div>
                    </div>

                    <div class="col-sm-12 col-md-6 col-lg-6" align="center">
                        <img src="../Scripts/System/images/icon/Login.png" height="70" width="220" />
                        <br />
                        <%--Detail Segment Start--%>

                        <dl class="dl-horizontal">
                            <dt>E-mail</dt>
                            <dd><a href="mailto:info@gnisbd.com" data-mce-href="mailto:info@gnisbd.com">info@gnisbd.com</a></dd>


                            <dt>Hotline</dt>
                            <dd>+88 0197777GPAC<br />
                                +88 01977774722</dd>
                            <br />

                        </dl>

                        <%--Detail Segment End--%>
                    </div>

                    <div class="col-md-6 col-lg-6">
                        <br />
                        <div class="form-group has-feedback">

                            <asp:TextBox ID="txtUserID" runat="server" class="form-control" placeholder="User ID"></asp:TextBox>
                            <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                        </div>

                        <div class="form-group has-feedback" style="margin-top: 6px;">

                            <asp:TextBox ID="txtPassword" runat="server" class="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>


                        <div class="form-group" align="right">
                            <p style="margin-top: 6px;">
                                <asp:Button ID="btnLogin" runat="server" class="btn btn-primary btn-sm btn-block col-5" Text="login" OnClientClick="loader()"  OnClick="btn_login_Click" />
                                <asp:Button ID="btnLogOut" runat="server" class="btn btn-primary btn-sm btn-block col-5" Text="logout" OnClick="btnLogOut_Click" />
                            </p>
                        </div>
                        <div class="footer" align="right">
                            <a href="#" onclick="goto_forget_password()">I forgot my password</a><br>
                        </div>
                        <br />
                        <br />
                    </div>

                    <div class="col-lg-12 col-md-12 col-sm-12" align="center">
                        <div class="footer" align="center">
                            <p class="font-light" style="font-size: 15px">Copy right by :<a href="http://www.gpacsoftware.com/" target="_blank">Gpacsoftware.com</a></p>
                            <br />
                        </div>
                    </div>
                </div>
                <!-- /.login-box-body -->
            </div>
        </div>
        <!-- /.login-box -->

        <!-- jQuery 2.2.3 -->
        <script src="../Scripts/plugins/jQuery/jquery-2.2.3.min.js"></script>
        <!-- Bootstrap 3.3.6 -->
        <script src="../Scripts/bootstrap.min.js"></script>
        <!-- iCheck -->
        <script src="../Scripts/plugins/iCheck/icheck.min.js"></script>

        <script>
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional
                });
            });
        </script>
    </form>


    <script>
        $(document).ready(function () { $("#spinner").fadeOut(1000); });
    </script>


</body>

</html>
