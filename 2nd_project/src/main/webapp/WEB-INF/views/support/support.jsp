<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>NEXTROZI 고객센터</title>
    <style>
        body {
            margin: 0;
            font-family: 'Apple SD Gothic Neo', sans-serif;
            background-color: #ffffff;
        }

        .monoton {
            font-family: "Monoton", sans-serif;
            font-weight: 400;
            font-size: 22px;
            font-style: normal;
        }

        /* ✅ 로고 고정 (상단 중앙) */
        .logo-fixed {
            position: fixed;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
        }

        .logo-fixed h2 {
            margin: 0;
        }

        /* ✅ 로그인/회원가입 고정 (상단 우측) */
        .auth-buttons {
            position: fixed;
            top: 10px;
            right: 20px;
            z-index: 1000;
        }

        .auth-buttons button {
            padding: 8px 12px;
            font-size: 13px;
            border: 0px solid #2c3e50;
            border-radius: 5px;
            margin-left: 6px;
            cursor: pointer;
        }

        .btn-login {
            background-color: #2c3e50;
            color: white;
        }

        .btn-signup {
            background-color: white;
            color: #2c3e50;
        }

        .top-image-container {
            width: 100%;
            height: 400px;
            overflow: hidden;
            position: relative;
        }

        .top-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .top-text-overlay {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: white;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.8);
        }

        .top-text-overlay h1 {
            font-size: 34px;
        }

        .top-text-overlay p {
            font-size: 15px;
            line-height: 1.5;
        }

        .middle-section {
            max-width: 864px;
            margin: 60px auto 30px;
            text-align: center;
        }

        .middle-section img {
            width: 864px;
            height: 333px;
            display: block;
            margin: 0 auto;
        }

        .middle-text {
            font-size: 30px;
            font-weight: bold;
            margin: 40px 0 10px;
        }

        .middle-subtext {
            font-size: 30px;
            color: #333;
        }

        .divider {
            width: 1px;
            height: 30px;
            background-color: #ccc;
            margin: 30px auto;
        }

        .bottom-section {
            max-width: 864px;
            margin: 30px auto 60px;
            text-align: center;
        }

        .bottom-section img {
            width: 864px;
            height: 316px;
            display: block;
            margin: 0 auto;
        }

         a {
                text-decoration: none;
                }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Monoton&display=swap" rel="stylesheet">
</head>
<body>

<!-------------------------고정 로고 ------------------------->
<div class="logo-fixed">
    <a href="/purchase/purchase_list.do" style="text-decoration: none;">
    <a href="/main">
        <h2>
            <span style="color:#2F58B8;">NEX</span><span style="color:#B3B3B4;" class="monoton">T</span><span style="color:#707070;">ROZ<span class="monoton">I</span></span>
        </h2>
        </a>
    </a>
</div>
<!-----------------------고정 로고 끝 ---------------------------->

<!-- 상단 이미지 및 텍스트 -->
<div class="top-image-container">
    <img src="<c:url value='/images/main_image001.png'/>" alt="메인 이미지" />
    <div class="top-text-overlay">
        <h1>계획과 성과, 더 쉽게</h1>
        <p>
            복잡한 스프레드시트와 따로 노는 일정표는 이제 그만.<br>
            우리 팀의 계획, 일정까지 한 곳에서 쉽게 보고, 함께 관리하세요.
        </p>
    </div>
</div>