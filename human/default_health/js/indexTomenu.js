// 페이지 이동용 js 파일

// 헤더 로고 클릭 시 메인 이동용
function goMain() {
    location.href = "../html/index.html";
}

// 로그인 페이지로 
function goLogin() {
    location.href = "../html/user/login.html?login";
}

// 아이디 찾기 페이지로
function searchId() {
    location.href = "../html/user/login.html?searchId";
}

// 비밀번호 찾기 페이지로
function searchPw() {
    location.href = "../html/user/login.html?searchPw";
}

// 회원가입 페이지로
function goJoin() {
    location.href = "../html/user/login.html?goJoin";
}

// 뒤로가기
function goBack() {
    history.back();
}

// 운동법 페이지로
function goEx() {
    location.href = "../html/exercise/exMet.html";
}

// 운동장비 페이지로
function goEq() {
    location.href = "../html/healthcare/equipments.html";
}

// 보조식품 페이지로
function goSup() {
    location.href = "./healthcare/supplements.html";
}

// 게시판 페이지로
function goBoard() {
    location.href = "../html/board/board.html";
}

//공통상품 페이지로
function goProduct(){
    location.href="../html/healthcare/product.html";
}

//공통식품 구매링크로 이동
function siteLink() {
    window.open("https://brand.naver.com/thebenefood/products/11586271837?nl-query=%EB%8B%A8%EB%B0%B1%EC%A7%88%EB%B3%B4%EC%B6%A9%EC%A0%9C&nl-au=3d137eba157c4f3faf82341b42696832&NaPm=ci%3D3d137eba157c4f3faf82341b42696832%7Cct%3Dm9kqoiex%7Ctr%3Dnslsl%7Csn%3D197344%7Chk%3D3ffad8a8dd60584da5c23f30914001f7b657667f'");
}