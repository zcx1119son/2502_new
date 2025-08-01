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
    </style>
</head>
<body>
<link href="https://fonts.googleapis.com/css2?family=Monoton&display=swap" rel="stylesheet">
    <div class="login-container">
        <div class="login-box">
        <a href="/main">
            <h2><h2><div class="logo"><font color="2F58B8">NEX</font><font color="B3B3B4"><span class="monoton">T</span></font><font color="707070">ROZ<span class="monoton">I</span></div></font></h2></h2>
        </a>
            <form action="/login/registerCompany" method="post">

                <!-- 이메일 -->
                <label>E-mail</label>
                <div class="form-group">
                    <input type="email" name="email" placeholder="이메일 입력" required>
                    <button type="button">인증번호 받기</button>
                </div>

                <!-- 인증번호 -->
                <label>인증번호</label>
                <div class="form-group">
                    <input type="text" name="authCode" placeholder="숫자 4자리">
                    <button type="button">확인</button>
                </div>

                <!-- 비밀번호 -->
                <label>새로운 비밀번호</label>
                <div class="form-group">
                    <input type="password" name="password" placeholder="특수문자 포함 8자 이상">
                </div>
                 <!-- 비밀번호 확인 -->
                                <label>새로운 비밀번호 확인</label>
                                <div class="form-group">
                                    <input type="password" name="confirmPassword" placeholder="비밀번호 확인 입력">
                                    <button type="button">확인</button>
                                </div>

                <!-- 전화번호 -->
                <label>전화번호</label>
                <div class="form-group">
                    <input type="tel" name="phone" placeholder="'-'없이 입력">
                </div>

                <!-- 완료 버튼 -->
                <button type="submit" class="submit-btn">완료</button>
            </form>
            <div class="links">
                            <a href="/login/loginfirst">회원가입</a> |
                            <a href="/login/loginpass">비밀번호 변경</a> |
                            <a href="/login/logincompany">기업등록</a>
                        </div>
        </div>
    </div>
</body>
</html>