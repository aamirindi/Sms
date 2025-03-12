<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SocietyManagementSystem.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SMS - Register</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

    <!-- Bootstrap 3.3.2 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            height: 100vh;
        }

        .login-page {
            background: transparent;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .login-box {
            width: 360px;
            margin: 0 auto;
            padding: 0;
        }

        .login-logo {
            margin-bottom: 25px;
        }

            .login-logo a {
                color: #3c8dbc;
                font-size: 28px;
                letter-spacing: -0.5px;
            }

                .login-logo a b {
                    font-weight: 700;
                    color: #2c3e50;
                }

        .login-box-body {
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .login-box-msg {
            margin-bottom: 25px;
            font-size: 16px;
            color: #555;
            text-align: center;
            font-weight: 500;
        }

        .form-control {
            height: 45px;
            border-radius: 5px;
            box-shadow: none;
            border: 1px solid #ddd;
            padding-left: 45px;
            transition: all 0.3s ease;
        }

            .form-control:focus {
                border-color: #3c8dbc;
                box-shadow: 0 0 0 0.2rem rgba(60, 141, 188, 0.25);
            }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        .form-control-feedback {
            position: absolute;
            top: 0;
            left: 0;
            z-index: 2;
            display: block;
            width: 45px;
            height: 45px;
            line-height: 45px;
            text-align: center;
            color: #3c8dbc;
        }

        .btn-primary {
            background-color: #3c8dbc;
            border-color: #367fa9;
            font-weight: 500;
            padding: 10px 16px;
            font-size: 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

            .btn-primary:hover, .btn-primary:focus, .btn-primary:active {
                background-color: #367fa9;
                border-color: #2e6da4;
            }

        .social-auth-links {
            margin: 20px 0;
            text-align: center;
        }

            .social-auth-links p {
                margin-bottom: 15px;
                color: #777;
                position: relative;
            }

                .social-auth-links p:before, .social-auth-links p:after {
                    content: "";
                    position: absolute;
                    top: 50%;
                    width: 40%;
                    height: 1px;
                    background-color: #ddd;
                }

                .social-auth-links p:before {
                    left: 0;
                }

                .social-auth-links p:after {
                    right: 0;
                }

        .text-center {
            text-align: center;
            margin-top: 15px;
        }

            .text-center a {
                color: #3c8dbc;
                text-decoration: none;
                transition: all 0.3s ease;
            }

                .text-center a:hover {
                    color: #2e6da4;
                    text-decoration: underline;
                }
    </style>
</head>
<body class="login-page">
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="login-logo">
                <a href="#"><b>Society</b>Management</a>
            </div>
            <div class="login-box-body">
                <p class="login-box-msg">Create a new account</p>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="row">
                    <div class="col-xs-12">
                        <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary btn-block btn-flat" Text="Sign Up" OnClick="btnRegister_Click" />
                    </div>
                </div>
                <div class="social-auth-links text-center">
                    <p>- OR -</p>
                </div>
                <div class="text-center">
                    <a href="Login.aspx" class="text-center">Already have an account? Sign in</a>
                </div>
            </div>
        </div>
    </form>

    <!-- jQuery 2.1.3 -->
    <script src="plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script>
        $(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%'
            });
        });
    </script>
</body>
</html>
<%--<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SocietyManagementSystem.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SMS - Register</title>
    <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>

    <!-- Bootstrap 3.3.2 -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- FontAwesome 4.3.0 -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons 2.0.0 -->
    <link href="http://code.ionicframework.com/ionicons/2.0.0/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
    <link href="dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <!-- iCheck -->
    <link href="plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body class="login-page">
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="login-logo">
                <a href="#"><b>Society</b>Management</a>
            </div>
            <div class="login-box-body">
                <p class="login-box-msg">Sign Up to get started</p>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Username"></asp:TextBox>
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password"></asp:TextBox>
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary btn-block btn-flat" Text="Sign Up" OnClick="btnRegister_Click" />
                    </div>
                </div>
                <div class="social-auth-links text-center">
                    <p>- OR -</p>
                </div>
                <a href="Login.aspx" class="text-center">Already a member</a>
            </div>
        </div>
    </form>

    <!-- jQuery 2.1.3 -->
    <script src="plugins/jQuery/jQuery-2.1.3.min.js"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- iCheck -->
    <script src="plugins/iCheck/icheck.min.js" type="text/javascript"></script>
    <script>
        $(function () {
            $('input').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%'
            });
        });
    </script>
</body>
</html>--%>