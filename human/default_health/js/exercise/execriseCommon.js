// 뒤로가기
function goBack() {
    history.back();
}

// 메인 화면으로
function goMain() {
    location.href = "../index.html";
}

// 로그인 페이지로
function goLogin() {
    location.href = "../user/login.html?login";
}

// 운동법 페이지로
function goEx() {
    location.href = "./exMet.html";
}

// 운동장비 페이지로
function goEq() {
    location.href = "../healthcare/equipments.html";
}

// 보조식품 페이지로
function goSup() {
    location.href = "../healthcare/supplements.html";
}

// 운동법 상세 페이지로
function goDetailEx() {
    location.href = "./exerciseMethodDetailed.html";
}

// 게시판 페이지로
function goBoard() {
    location.href = "../board/board.html";
}
