<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 로그인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #555;
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .login-button {
            width: 100%;
            padding: 12px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .login-button:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>관리자 로그인</h2>
        <form id="masterLoginForm">
            <div class="form-group">
                <label for="masterId">아이디:</label>
                <input type="text" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="masterPwd">비밀번호:</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="login-button">로그인</button>
            <div id="errorMessage" class="error-message"></div>
        </form>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#masterLoginForm').on('submit', function(e) {
                e.preventDefault(); // Prevent default form submission

                var loginData = {
                    email: $('#email').val(),
                    password: $('#password').val()
                };

                $.ajax({
                    type: 'POST',
                    url: '/login/doMasterLogin', // The endpoint in LoginController
                    contentType: 'application/json',
                    data: JSON.stringify(loginData),
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            window.location.href = response.redirectUrl; // Redirect on success
                        } else {
                            $('#errorMessage').text(response.message); // Display error message
                        }
                    },
                    error: function(xhr, status, error) {
                        var errorMessage = "로그인 처리 중 오류가 발생했습니다.";
                        if (xhr.responseJSON && xhr.responseJSON.message) {
                            errorMessage = xhr.responseJSON.message;
                        }
                        $('#errorMessage').text(errorMessage);
                        console.error("AJAX Error: ", status, error, xhr.responseText);
                    }
                });
            });
        });
    </script>
</body>
</html>