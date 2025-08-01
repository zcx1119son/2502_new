<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기업등록</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f8f9fc;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .login-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-box {
            background-color: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            width: 500px;
        }

        .login-box h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            font-weight: bold;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 14px;
            gap: 10px;
        }

        .form-group input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 12px;
            font-size: 14px;
            box-sizing: border-box;
        }

        .form-group.double input {
            width: 48%;
        }

        .form-group button {
            padding: 10px 16px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 12px;
            font-size: 14px;
            cursor: pointer;
        }

        .form-group button:hover {
            background-color: #eee;
        }

        .submit-btn {
            width: 100%;
            padding: 14px;
            background-color: #0066ff;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            margin-top: 30px;
        }

        .submit-btn:hover {
            background-color: #0050d7;
        }

        .monoton {
            font-family: "Monoton", sans-serif;
            font-weight: 400;
            font-size: 22px;
            font-style: normal;
        }

        a {
            text-decoration: none;
        }
        .error-message {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
        .success-message {
            color: green;
            font-size: 12px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<link href="https://fonts.googleapis.com/css2?family=Monoton&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> <div class="login-container">
        <div class="login-box">
        <a href="/main">
            <h2><h2><div class="logo"><font color="2F58B8">NEX</font><font color="B3B3B4"><span class="monoton">T</span></font><font color="707070">ROZ<span class="monoton">I</span></div></font></h2></h2>
        </a>
            <form id="signupForm" action="/login/registerCompany" method="post">

                <label>E-mail</label>
                <div class="form-group">
                    <input type="email" name="email" id="email" placeholder="이메일 입력" required>
                    <button type="button" id="getEmailCodeBtn">인증번호 받기</button>
                </div>
                <div id="emailMessage" class="error-message"></div>

                <label>인증번호</label>
                <div class="form-group">
                    <input type="text" name="authCode" id="authCode" placeholder="숫자 6자리">
                    <button type="button" id="verifyCodeBtn">확인</button>
                </div>
                <div id="authCodeMessage" class="error-message"></div>

                <label>비밀번호</label>
                <div class="form-group">
                    <input type="password" name="password" id="password" placeholder="특수문자 포함 8자 이상" required>
                </div>
                <div id="passwordMessage" class="error-message"></div>

                 <label>비밀번호 확인</label>
                <div class="form-group">
                    <input type="password" name="confirmPassword" id="confirmPassword" placeholder="비밀번호 확인 입력" required>
                    <button type="button" id="confirmPasswordBtn">확인</button>
                </div>
                <div id="confirmPasswordMessage" class="error-message"></div>

                 <label>이름</label>
                <div class="form-group">
                    <input type="text" name="ownerName" id="ownerName" placeholder="이름 입력" required>
                </div>

                 <label>기업 이름</label>
                <div class="form-group">
                    <input type="text" name="companyName" id="companyName" placeholder="기업 이름" required>
                </div>

                <label>기업코드 입력 </label>
                <div class="form-group">
                    <input type="text" name="companyCode" id="companyCode" placeholder="회사 코드" required>
                    <button type="button" id="validateCompanyCodeBtn">확인</button>
                </div>
                <div id="companyCodeMessage" class="error-message"></div>


                <label>전화번호</label>
                <div class="form-group">
                    <input type="tel" name="companyPhone" id="companyPhone" placeholder="'-'없이 입력" required>
                </div>

                <button type="submit" class="submit-btn">완료</button>
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

        // Function to display messages
        function displayMessage(elementId, message, isError) {
            const element = $('#' + elementId);
            element.text(message);
            if (isError) {
                element.removeClass('success-message').addClass('error-message');
            } else {
                element.removeClass('error-message').addClass('success-message');
            }
        }

        // Email verification - Get verification code
        $('#getEmailCodeBtn').on('click', function() {
            const email = $('#email').val();
            if (!email) {
                displayMessage('emailMessage', '이메일을 입력해주세요.', true);
                return;
            }

            $.ajax({
                url: '/login/checkEmail',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ email: email }),
                success: function(response) {
                    if (response.exists) {
                        displayMessage('emailMessage', '이미 등록된 이메일입니다.', true);
                    } else {
                        // Email does not exist, proceed to get verification code
                        $.ajax({
                            url: '/login/getVerificationCode',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({ email: email }),
                            success: function(codeResponse) {
                                if (codeResponse.status === 'success') {
                                    displayMessage('emailMessage', codeResponse.message, false); // Display message from server
                                } else {
                                    displayMessage('emailMessage', codeResponse.message, true); // Display error message from server
                                }
                            },
                            error: function() {
                                displayMessage('emailMessage', '서버 오류 발생.', true);
                            }
                        });
                    }
                },
                error: function() {
                    displayMessage('emailMessage', '서버 오류 발생.', true);
                }
            });
        });

        // Email verification - Verify code
        $('#verifyCodeBtn').on('click', function() {
            const email = $('#email').val();
            const authCode = $('#authCode').val();

            if (!email || !authCode) {
                displayMessage('authCodeMessage', '이메일과 인증번호를 모두 입력해주세요.', true);
                return;
            }

            $.ajax({
                url: '/login/verifyCode',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ email: email, code: authCode }),
                success: function(response) {
                    if (response.verified) {
                        displayMessage('authCodeMessage', '인증번호가 확인되었습니다.', false);
                    } else {
                        displayMessage('authCodeMessage', '인증번호가 일치하지 않습니다.', true);
                    }
                },
                error: function() {
                    displayMessage('authCodeMessage', '서버 오류 발생.', true);
                }
            });
        });

        // Password confirmation
        $('#confirmPasswordBtn').on('click', function() {
            const password = $('#password').val();
            const confirmPassword = $('#confirmPassword').val();

            if (!password || !confirmPassword) {
                displayMessage('confirmPasswordMessage', '비밀번호를 모두 입력해주세요.', true);
                return;
            }

            if (password === confirmPassword) {
                displayMessage('confirmPasswordMessage', '비밀번호가 일치합니다.', false);
            } else {
                displayMessage('confirmPasswordMessage', '비밀번호가 일치하지 않습니다.', true);
            }
        });

        // Client-side password strength check (optional, but good practice)
        $('#password').on('keyup', function() {
            const password = $(this).val();
            // This regex checks for at least 8 characters, including one special character, one letter, and one number.
            const passwordRegex = /^(?=.*[!@#$%^&*])(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;
            if (passwordRegex.test(password)) {
                displayMessage('passwordMessage', '유효한 비밀번호입니다.', false);
            } else {
                displayMessage('passwordMessage', '특수문자, 영문, 숫자 포함 8자 이상.', true);
            }
        });


        // Validate Company Code
        $('#validateCompanyCodeBtn').on('click', function() {
            const companyCode = $('#companyCode').val();
            if (!companyCode) {
                displayMessage('companyCodeMessage', '기업코드를 입력해주세요.', true);
                return;
            }

            $.ajax({
                url: '/login/validateCompanyCode',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ companyCode: companyCode }),
                success: function(response) {
                    if (response.isValid) {
                        displayMessage('companyCodeMessage', '유효한 기업코드입니다.', false);
                    } else {
                        displayMessage('companyCodeMessage', '유효하지 않거나 이미 사용 중인 기업코드입니다.', true);
                    }
                },
                error: function() {
                    displayMessage('companyCodeMessage', '서버 오류 발생.', true);
                }
            });
        });


        // Final form submission validation (optional, as server-side validation is crucial)
        $('#signupForm').on('submit', function(event) {
            const password = $('#password').val();
            const confirmPassword = $('#confirmPassword').val();

            if (password !== confirmPassword) {
                alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                event.preventDefault(); // Prevent form submission
            }
            // Add other client-side validations here if needed
            // Ensure email and auth code are verified before final submission for better UX
        });
    });
</script>
</body>
</html>