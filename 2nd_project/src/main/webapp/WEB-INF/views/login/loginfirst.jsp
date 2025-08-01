<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <div class="login-container">
        <div class="login-box">
        <a href="/main">
            <h2><h2><div class="logo"><font color="2F58B8">NEX</font><font color="B3B3B4"><span class="monoton">T</span></font><font color="707070">ROZ<span class="monoton">I</span></div></font></h2></h2>
        </a>
            <form id="memberSignupForm" action="/membersignup/registerMember" method="post">

                <label>E-mail</label>
                <div class="form-group">
                    <input type="email" name="member_email" id="member_email" placeholder="이메일 입력" required>
                    <button type="button" id="getEmailCodeBtn">인증번호 받기</button>
                </div>
                <div id="emailMessage" class="error-message"></div>

                <label>인증번호</label>
                <div class="form-group">
                    <input type="text" name="authCode" id="authCode" placeholder="숫자 4자리">
                    <button type="button" id="verifyCodeBtn">확인</button>
                </div>
                <div id="authCodeMessage" class="error-message"></div>

                <label>비밀번호</label>
                <div class="form-group">
                    <input type="password" name="member_pwd" id="member_pwd" placeholder="특수문자 포함 8자 이상" required>
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
                    <input type="text" name="member_name" id="member_name" placeholder="이름 입력" required>
                </div>

                <label>기업코드 입력 </label>
                <div class="form-group">
                    <input type="text" name="company_code" id="company_code" placeholder="회사 코드" required>
                </div>

                <label>전화번호</label>
                <div class="form-group">
                    <input type="tel" name="member_phone" id="member_phone" placeholder="'-'없이 입력" required>
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

        // Email verification - Check if email exists and send verification code
        $('#getEmailCodeBtn').on('click', function() {
            const email = $('#member_email').val();
            if (!email) {
                displayMessage('emailMessage', '이메일을 입력해주세요.', true);
                return;
            }

            $.ajax({
                url: '/membersignup/checkEmail',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ email: email }),
                success: function(response) {
                    if (response.exists) {
                        displayMessage('emailMessage', '이미 등록된 이메일입니다.', true);
                    } else {
                        // Email is available, now request for verification code
                        $.ajax({
                            url: '/membersignup/getVerificationCode',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify({ email: email }),
                            success: function(codeResponse) {
                                if (codeResponse.status === 'success') {
                                    displayMessage('emailMessage', codeResponse.message, false);
                                } else {
                                    displayMessage('emailMessage', codeResponse.message, true);
                                }
                            },
                            error: function() {
                                displayMessage('emailMessage', '인증번호 발송 서버 오류 발생.', true);
                            }
                        });
                    }
                },
                error: function() {
                    displayMessage('emailMessage', '이메일 확인 서버 오류 발생.', true);
                }
            });
        });

        // Email verification - Verify code (Server-side check via AJAX)
        $('#verifyCodeBtn').on('click', function() {
            const email = $('#member_email').val(); // Ensure email is also sent for verification
            const authCode = $('#authCode').val();
            if (!email || !authCode) {
                displayMessage('authCodeMessage', '이메일과 인증번호를 모두 입력해주세요.', true);
                return;
            }

            $.ajax({
                url: '/membersignup/verifyCode', // New endpoint for server-side verification
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
                    displayMessage('authCodeMessage', '인증번호 확인 중 서버 오류 발생.', true);
                }
            });
        });

        // Password confirmation (Server-side check via AJAX)
        $('#confirmPasswordBtn').on('click', function() {
            const password = $('#member_pwd').val();
            const confirmPassword = $('#confirmPassword').val();

            if (!password || !confirmPassword) {
                displayMessage('confirmPasswordMessage', '비밀번호를 모두 입력해주세요.', true);
                return;
            }

            $.ajax({
                url: '/membersignup/confirmPassword', // New endpoint for server-side confirmation
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ password: password, confirmPassword: confirmPassword }),
                success: function(response) {
                    if (response.match) {
                        displayMessage('confirmPasswordMessage', '비밀번호가 일치합니다.', false);
                    } else {
                        displayMessage('confirmPasswordMessage', '비밀번호가 일치하지 않습니다.', true);
                    }
                },
                error: function() {
                    displayMessage('confirmPasswordMessage', '비밀번호 확인 중 서버 오류 발생.', true);
                }
            });
        });

        // Client-side password strength check
        $('#member_pwd').on('keyup', function() {
            const password = $(this).val();
            const passwordRegex = /^(?=.*[!@#$%^&*])(?=.*[a-zA-Z])(?=.*[0-9]).{8,}$/;
            if (passwordRegex.test(password)) {
                displayMessage('passwordMessage', '유효한 비밀번호입니다.', false);
            } else {
                displayMessage('passwordMessage', '특수문자, 영문, 숫자 포함 8자 이상.', true);
            }
        });

        // Company Code validation (Server-side check via AJAX)
        $('#company_code').on('blur', function() { // You can trigger this on blur, or add a dedicated button
            const companyCode = $(this).val();
            if (!companyCode) {
                // Optionally display a message if company code is empty
                return;
            }

            $.ajax({
                url: '/membersignup/validateCompanyCode', // New endpoint for company code validation
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ companyCode: companyCode }),
                success: function(response) {
                    if (response.isValid) {
                        Example: displayMessage('companyCodeMessage', '유효한 기업 코드입니다.', false);
                    } else {
                        Example: displayMessage('companyCodeMessage', '유효하지 않은 기업 코드입니다.', true);
                    }
                },
                error: function() {
                    displayMessage('companyCodeMessage', '기업 코드 확인 중 서버 오류 발생.', true);
                }
            });
        });

        // Final form submission validation
        $('#memberSignupForm').on('submit', function(event) {
            const password = $('#member_pwd').val();
            const confirmPassword = $('#confirmPassword').val();
            let isValid = true;

            if (password !== confirmPassword) {
                displayMessage('confirmPasswordMessage', '비밀번호와 비밀번호 확인이 일치하지 않습니다.', true);
                isValid = false;
            }

            if (!isValid) {
                event.preventDefault(); // Prevent form submission if client-side validation fails
                alert('입력된 정보를 확인해주세요.'); // Alert user to check invalid fields
            }
        });
    });
</script>
</body>
</html>