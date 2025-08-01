// 운동장비 페이지용 js

// 넘어오는 파라미터에 따라 해당하지 않는 페이지를 숨김
var urlValue = window.location.search;
if (urlValue == "?Product") {
    $(".product-section-supplement").hide();
} else {
    $(".product-section-equipment").hide();
}


// 메인화면으로
function goMain() {
    location.href = "../index.html";
}

// 상세화면으로
function goDetail() {
    location.href = "../healthcare/product.html";
}

function goDetailProduct() {
    location.href = "../healthcare/product.html?Product";
}

// 운동법 페이지로
function goEx() {
    location.href = "../exercise/exMet.html";
}

// 운동장비 페이지로
function goEq() {
    location.href = "../healthcare/equipments.html";
}

// 건강보조 페이지로
function goSup() {
    location.href = "../healthcare/supplements.html";
}

// 리뷰 작성페이지로
function regRiv() {
    location.href = "review.html";
}

// 게시판 페이지로
function goBoard() {
    location.href = "../board/board.html";
}
//공통식품 구매링크로 이동
function siteLink() {
    window.open("https://brand.naver.com/thebenefood/products/11586271837?nl-query=%EB%8B%A8%EB%B0%B1%EC%A7%88%EB%B3%B4%EC%B6%A9%EC%A0%9C&nl-au=3d137eba157c4f3faf82341b42696832&NaPm=ci%3D3d137eba157c4f3faf82341b42696832%7Cct%3Dm9kqoiex%7Ctr%3Dnslsl%7Csn%3D197344%7Chk%3D3ffad8a8dd60584da5c23f30914001f7b657667f'");
}

function siteLinkProduct() {
    window.open("https://www.coupang.com/vp/products/6731316412?itemId=15685536906&vendorItemId=82900528192");
}

// 로그인 화면으로
function goLogin() {
    location.href = "../user/login.html?login";
}

// 취소용
function cancel() {
    history.back();
}

function reg() {
    if (confirm("작성하시겠습니까?")) {
        alert("작성이 완료되었습니다.");
        history.back();
    } else {
        alert("취소하였습니다.");
    }
}