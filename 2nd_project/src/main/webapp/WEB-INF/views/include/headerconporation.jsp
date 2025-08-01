<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link href="https://fonts.googleapis.com/css2?family=Monoton&display=swap" rel="stylesheet">

<style>
    .monoton {
        font-family: "Monoton", sans-serif;
        font-weight: 400;
        font-size: 22px;
        font-style: normal;
    }

    .header-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        background-color: #f7f8fc;
        z-index: 1000;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 10px 0;
        box-shadow: 0 2px 6px rgba(0,0,0,0.05);
    }
    .company-info {
        /* 이 선택자는 header-container 내에 있는데, 역할이 불분명하여 비워두었습니다. */
        /* 필요하다면 여기에 스타일을 추가하세요. */
    }

    .logo a {
        text-decoration: none;
    }

    .logo h2 {
        margin: 0;
    }

    .user-info {
        position: absolute;
        right: 40px;
    }

    .user-name-btn,
    .logout-btn {
        padding: 8px 12px;
        font-size: 13px;
        border: 0px solid #2c3e50;
        border-radius: 5px;
        margin-left: 6px;
        cursor: pointer;
    }

    /* 이름 버튼 스타일 (흰 배경, 회색 테두리) */
    .user-name-btn {
        background-color: white;
        color: #333;
        border: none;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        cursor: default;
    }

    /* 로그아웃 버튼 스타일 (어두운 배경, 흰 글자) */
    .logout-btn {
        background-color: #2f2f2f;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .logout-btn:hover {
        background-color: #1c1c1c;
    }


    .navbar {
        position: fixed;
        top: 55px; /* header-container의 높이(약 45px) + padding(10px)을 고려하여 55px */
        left: 0;
        width: 100%;
        background-color: #2F58B8;
        display: flex;
        justify-content: center;
        gap: 60px;
        padding: 5px 0;
        z-index: 999;
    }

    .navbar a {
        color: white;
        text-decoration: none;
        font-weight: bold;
        font-size: 15px;
        padding: 6px 12px;
        transition: background-color 0.2s, text-decoration 0.2s; /* 밑줄 트랜지션 추가 */
    }

    .navbar a:hover {
        background-color: #0033cc;
        border-radius: 4px;
    }

    /* ★★★ 활성화된 탭에 대한 CSS 추가 ★★★ */
    .navbar a.active {
        background-color: #fffff; /* hover와 동일하게 하여 클릭된 상태임을 강조 */
        border-radius: 5px;
        text-decoration: underline; /* 밑줄 추가 */
        text-underline-offset: 13px; /* 밑줄과 텍스트 간격 */
        text-decoration-thickness: 2px; /* 밑줄 두께 */
        /* border-bottom: 2px solid white; /* 또는 하단 테두리 사용 */
    }

    /* header-container의 높이를 정확히 맞추기 위한 조정 */
    /* .header-container { height: 45px; } /* 실제 측정하여 정확히 넣는 것이 좋습니다. */
    /* .navbar { top: 55px; } /* header-container의 정확한 높이 + padding-bottom + navbar의 padding-top */

    .company-info {
        left: 0; /* 이 스타일은 .company-info가 absolute/fixed일 때 유효합니다. 현재는 사용되지 않습니다. */
    }
</style>

<div class="header-container">
    <div class="logo">
        <a href="/home">
            <h2>
                <div class="logo">
                    <a href="/home">
                        <font color="#2F58B8">NEX</font><font color="#B3B3B4"><span class="monoton">T</span></font><font color="#707070">ROZ</font><font color="#707070"><span class="monoton">I</span></font>
                    </a>
                </div>
            </h2>
        </a>
    </div>

    <div class="user-info">
        <button class="user-name-btn">
            <c:out value="${sessionScope.user.companyCode}" default="a11111"/> ||
            <c:out value="${sessionScope.user.companyName}" default="nextrozi"/> ||
            <c:out value="${sessionScope.user.name}" default=" 아아아아아" />
        </button>
        <a href="/main">
            <button class="logout-btn">로그아웃</button>
        </a>
    </div>

</div>

<div class="navbar">
    <a href="/home">HOME</a>
    <a href="/management/management_list.do">직원 관리</a>
</div>

<script>
    // 페이지 로드 시 현재 URL에 해당하는 네비게이션 링크에 'active' 클래스 추가
    document.addEventListener('DOMContentLoaded', function() {
        const currentPath = window.location.pathname; // 현재 페이지의 경로 (예: "/home", "/client/list")
        const navLinks = document.querySelectorAll('.navbar a'); // 모든 네비게이션 링크

        navLinks.forEach(link => {
            const linkPath = new URL(link.href).pathname; // 각 링크의 경로 (예: "/home", "/client/list")

            // 현재 경로와 링크의 경로가 일치하는지 확인
            // "/purchase/purchase_list.do"와 같은 경우를 위해 includes 대신 정확히 일치하는지 확인
            if (currentPath === linkPath) {
                link.classList.add('active');
            }
            // 또는 더 유연하게 특정 경로의 시작 부분만 일치시켜도 됩니다.
            // if (currentPath.startsWith(linkPath)) {
            //     link.classList.add('active');
            // }
        });
    });
</script>