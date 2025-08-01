<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f8f9fc;
            font-family: 'Noto Sans KR', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        .login-container {
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-box {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 360px;
            text-align: center;
            box-sizing: border-box;
        }

        .login-box h2 {
            margin-bottom: 30px;
            font-size: 20px;
        }

        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border: 0.1px solid #ddd;
            border-radius: 12px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .login-box button {
            width: 100%;
            padding: 12px;
            background-color: #0066ff;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            margin-top: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .login-box button:hover {
            background-color: #0050d7;
        }

        .login-box .links {
            margin-top: 20px;
            font-size: 12px;
            color: #666;
        }

        .login-box .links a {
            margin: 0 5px;
            text-decoration: none;
            color: #666;
            transition: color 0.3s ease;
        }

        .login-box .links a:hover {
            color: #0066ff;
        }

        .logo {
            margin-bottom: 20px;
            color: #0066ff;
            font-weight: bold;
            font-size: 24px;
        }
        .monoton {
           font-family: "Monoton", sans-serif;
           font-weight: 400;
           font-size: 22px;
         }

        a {
            text-decoration: none;
        }

       .error-message {
           color: red;
           margin-bottom: 15px;
           font-size: 14px;
           text-align: center;
       }

       .login-type-selection {
           margin-bottom: 15px;
           text-align: left;
       }
       .login-type-selection label {
           margin-right: 15px;
           font-size: 14px;
           color: #555;
           cursor: pointer;
       }
       .login-type-selection input[type="radio"] {
           margin-right: 5px;
       }

    </style>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Monoton&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <a href="/main">
                <h2>
                    <div class="logo">
                        <font color="#2F58B8">NEX</font><font color="#B3B3B4"><span class="monoton">T</span></font><font color="#707070">ROZ<span class="monoton">I</span></font>
                    </div>
                </h2>
            </a>

            <div id="errorMessage" class="error-message" style="display:none;"></div>

            <form id="unifiedLoginForm">
                <div class="login-type-selection">
                    <label>
                        <input type="radio" name="loginType" value="member" checked> 멤버
                    </label>
                    <label>
                        <input type="radio" name="loginType" value="company"> 기업
                    </label>
                </div>

                <input type="text" name="email" id="email" placeholder="Email" required>
                <input type="password" name="password" id="password" placeholder="Password" required>
                <input type="text" name="companyCode" id="companyCode" placeholder="Code" required>
                <button type="submit" id="loginButton">로그인</button>
            </form>
            <div class="links">
                <a href="/login/loginfirst">회원가입</a> |
                <a href="/login/loginpass">비밀번호 변경</a> |
                <a href="/login/logincompany">기업등록</a>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            <c:if test="${not empty error}">
                $('#errorMessage').text("${error}").show();
            </c:if>

            $('#unifiedLoginForm').on('submit', function(event) {
                event.preventDefault();

                const email = $('#email').val();
                const password = $('#password').val();
                const companyCode = $('#companyCode').val();
                const loginType = $('input[name="loginType"]:checked').val(); // Get selected login type

                const loginData = {
                    email: email,
                    password: password,
                    companyCode: companyCode
                };

                let ajaxUrl;
                let successRedirectUrl;
                if (loginType === 'company') {
                    ajaxUrl = '/login/doCompanyLogin';
                    successRedirectUrl = '/company/home'; // Redirect for company
                } else { // loginType === 'member'
                    ajaxUrl = '/login/doMemberLogin';
                    successRedirectUrl = '/member/home'; // Redirect for member
                }

                $.ajax({
                    url: ajaxUrl,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(loginData),
                    success: function(response) {
                        if (response.success) {
                            window.location.href = response.redirectUrl || successRedirectUrl;
                        } else {
                            $('#errorMessage').text(response.message).show();
                        }
                    },
                    error: function(xhr, status, error) {
                        let errorMessage = "로그인 처리 중 오류가 발생했습니다. 다시 시도해주세요.";
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMessage = xhr.responseJSON.message;
                        }
                        $('#errorMessage').text(errorMessage).show();
                        console.error("AJAX Error:", status, error, xhr.responseText);
                    }
                });
            });
        });
    </script>
</body>
</html>