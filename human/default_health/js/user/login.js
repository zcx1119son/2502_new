// 로그인 페이지 js

// 넘어오는 파라미터에 따라 폼을 숨김
var urlValue = window.location.search;

if (urlValue == "?login") {
    $(".searchId").hide();
    $(".idList").hide();
    $(".joinUser").hide();
    $(".changePwd").hide();
    $(".changePwdSend").hide();
    $(".joinUser").hide();
}

if (urlValue == "?searchId") {
    $(".loginForm").hide();
    $(".idList").hide();
    $(".joinUser").hide();
    $(".changePwd").hide();
    $(".changePwdSend").hide();
    $(".joinUser").hide();
}

if (urlValue == "?searchPw") {

    $(".loginForm").hide();
    $(".searchId").hide();
    $(".idList").hide();
    $(".joinUser").hide();
    //$("#changePwd").hide();
    $(".changePwdSend").hide();
    $(".joinUser").hide();


}

if (urlValue == "?goJoin") {
    $(".loginForm").hide();
    $(".searchId").hide();
    $(".idList").hide();
    $(".changePwd").hide();
    $(".changePwdSend").hide();
}

// 정규식으로 아이디 형식 체크
function idCheck() {
    var id = document.getElementById("userid").value;
    var idRegex = /^[A-za-z0-9]/g;
    if (!idRegex.test(id)) {
        alert("아이디 형식에 맞게 적어주세요.");
        return false;
    } else {
        return true;
    }
}

// 정규식으로 비밀번호 형식 체크
function pwCheck() {
    var pw = document.getElementById("password").value;
    var pwRegex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9])/;
    if (!pwRegex.test(pw)) {
        alert("비밀번호 형식에 맞게 적어주세요.");
        return false;
    } else {
        return true;
    }
}

// 로그인 체크용
function login() {

    // id값으로 입력값을 얻어와서 각각의 변수에 저장
    var userid = document.getElementById("userid").value;
    var password = document.getElementById("password").value;
    var check1 = false;
    var check2 = false;

    // 입력체크 시작
    if (userid == null || userid == "") {
        alert("아이디를 입력해주세요.");
        return false;
    } else {
        check1 = true;
    }

    if (password == null || password == "") {
        alert("비밀번호를 입력해주세요.");
        return false;
    } else {
        check2 = true;
    }

    // 아이디와 비밀번호 체크
    if (idCheck() && pwCheck()) {
        if (check1 && check2) {
            if (userid == "admin") {
                location.href = '../index_admin.html';
                return true;
            } else {
                alert(userid + "님 환영합니다!");
                location.href = '../index_user.html';
                return true;
            }
        }
    }
}



// 정규식으로 아이디 형식 체크
function searchIdCheck() {
    var id = document.getElementById("searchLoginId").value;
    var idRegex = /^[A-za-z0-9]/g;
    if (!idRegex.test(id)) {
        alert("아이디 형식에 맞게 적어주세요.");
        return false;
    } else {
        return true;
    }
}

// 정규식으로 주민등록번호 체크
function snoCheck() {
    var sno1 = document.getElementById("searchSno1").value;
    var sno2 = document.getElementById("searchSno2").value;
    var snoRegex = /^(?=.*\d)/;
    if (!snoRegex.test(sno1) || !snoRegex.test(sno2)) {
        alert("주민등록번호 형식에 맞게 적어주세요.");
        return false;
    } else if (sno1.length < 6 || sno2.length < 7) {
        alert("주민등록 번호 자릿수를 정확히 입력해주세요.");
        return false;
    } else {
        return true;
    }
}

// 아이디 찾기용
function searchId() {

    // id값으로 입력값을 얻어와서 각각의 변수에 저장
    var searchLoginId = document.getElementById("searchLoginId").value;
    var searchSno1 = document.getElementById("searchSno1").value;
    var searchSno2 = document.getElementById("searchSno2").value;
    var check1 = false;
    var check2 = false;

    // 입력체크 시작
    if (searchLoginId == null || searchLoginId == "") {
        alert("아이디를 입력해주세요.");
        return false;
    } else {
        check1 = true;
    }

    if (searchSno1 == null || searchSno1 == "" || searchSno2 == null || searchSno2 == "") {
        alert("주민등록 번호를 입력해주세요.");
        return false;
    } else {
        check2 = true;
    }

    //
    if (searchIdCheck() && snoCheck()) {
        $(".searchId").hide();
        $(".idList").show();
    }
}

// 정규식으로 특수문자 확인
function nameCheck() {
    var name = document.getElementById("userName").value;
    var nameRegex1 = /^[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
    var nameRegex2 = /^(?=.*\d)/;
    if (nameRegex1.test(name) || nameRegex2.test(name)) {
        alert("이름에는 특수문자나 숫자를 입력할수 없습니다.");
        return false;
    } else {
        return true;
    }
}


// 정규식으로 아이디 형식 체크
function searchPwdIdCheck() {
    var id = document.getElementById("searchPwdId").value;
    var idRegex = /^[A-za-z0-9]/g;
    if (!idRegex.test(id)) {
        alert("아이디 형식에 맞게 적어주세요.");
        return false;
    } else {
        return true;
    }
}

// 정규식으로 주민등록번호 체크
function snoPwCheck() {
    var sno1 = document.getElementById("userSno1").value;
    var sno2 = document.getElementById("userSno2").value;
    var snoRegex = /^(?=.*\d)/;
    if (!snoRegex.test(sno1) || !snoRegex.test(sno2)) {
        alert("주민등록번호 형식에 맞게 적어주세요.");
        return false;
    } else if (sno1.length < 6 || sno2.length < 7) {
        alert("주민등록 번호 자릿수를 정확히 입력해주세요.");
        return false;
    } else {
        return true;
    }
}

// 비밀번호 찾기용
function changePwd() {
    var userName = document.getElementById("userName").value;
    var userSno1 = document.getElementById("userSno1").value;
    var userSno2 = document.getElementById("userSno2").value;
    var searchPwdId = document.getElementById("searchPwdId").value;

    var check1 = false;
    var check2 = false;
    var check3 = false;

    // 입력체크 시작
    if (userName == null || userName == "") {
        alert("이름을 입력해주세요.");
        return false;
    } else {
        check1 = true;
    }

    if (userSno1 == null || userSno1 == "" || userSno2 == null || userSno2 == "") {
        alert("주민등록 번호를 입력해주세요.");
        return false;
    } else {
        check2 = true;
    }

    if (searchPwdId == null || searchPwdId == "") {
        alert("아이디를 입력해주세요.");
        return false;
    } else {
        check3 = true;
    }

    if (nameCheck() && searchPwdIdCheck() && snoPwCheck()) {
        if (check1 && check2 && check3) {
            $("#changePwd").hide();
            $("#changePwdSend").show();
        }
    }

}

// 정규식으로 비밀번호 형식 체크
function newPwdCheck() {
    var newPw = document.getElementById("newChangePwd").value;
    var newConfirmPw = document.getElementById("newPasswordConfirm").value;
    var pwRegex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])/;
    if (!pwRegex.test(newPw) || !pwRegex.test(newConfirmPw)) {
        alert("비밀번호 형식에 맞게 적어주세요.");
        return false;
    } else if (newPw.length < 13) {
        alert("비밀번호 자릿수는 최소 12자리 입니다.");
        return false;
    } else {
        return true;
    }
}

// 비밀번호 재설정용
function newPwd() {

    var newChangePwd = document.getElementById("newChangePwd").value;
    var newPasswordConfirm = document.getElementById("newPasswordConfirm").value;

    var check1 = false;
    var check2 = false;

    if (newChangePwd == null || newChangePwd == "") {
        alert("비밀번호를 입력해주세요.");
        return false;
    } else {
        check1 = true;
    }

    if (newPasswordConfirm == null || newPasswordConfirm == "") {
        alert("비밀번호 확인란을 입력해주세요.");
        return false;
    } else {
        check2 = true;
    }

    if (newChangePwd != newPasswordConfirm) {
        alert("비밀번호를 확인해 주세요.");
        return false;
    }

    if (newPwdCheck()) {
        if (check1 && check2) {
            alert("비밀번호가 변경되었습니다.");
            location.href = '../index.html';
        }
    }
}

// 약관 동의 팝업 함수
function showPopup() {
    window.open("./agreement.html", "target=_blank");
    var radioCheck = document.getElementById("agreementCheck");
    radioCheck.checked = true;
}


// 정규식으로 아이디 형식 체크
function joinIdCheck() {
    var id = document.getElementById("joinId").value;
    var idRegex = /^[A-za-z0-9]/g;
    if (!idRegex.test(id)) {
        alert("아이디 형식에 맞게 적어주세요.");
        return false;
    } else {
        return true;
    }
}

// 정규식으로 비밀번호 형식 체크
function joinPwdCheck() {
    var newPw = document.getElementById("joinPwd").value;
    var newConfirmPw = document.getElementById("joinConfirm").value;
    var pwRegex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])/;
    if (!pwRegex.test(newPw) || !pwRegex.test(newConfirmPw)) {
        alert("비밀번호 형식에 맞게 적어주세요.");
        return false;
    } else if (newPw.length < 13) {
        alert("비밀번호 자릿수는 최소 12자리 입니다.");
        return false;
    } else {
        return true;
    }
}

// 정규식으로 특수문자 확인
function joinNameCheck() {

    var name = document.getElementById("joinName").value;
    var nameRegex1 = /^[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
    var nameRegex2 = /^(?=.*\d)/;
    if (nameRegex1.test(name) || nameRegex2.test(name)) {
        alert("이름에는 특수문자나 숫자를 입력할수 없습니다.");
        return false;
    } else {
        return true;
    }
}

// 정규식으로 주민등록번호 체크
function joinSnoCheck() {
    var sno1 = document.getElementById("joinSno1").value;
    var sno2 = document.getElementById("joinSno2").value;
    var snoRegex = /^(?=.*\d)/;
    if (!snoRegex.test(sno1) || !snoRegex.test(sno2)) {
        alert("주민등록번호 형식에 맞게 적어주세요.");
        return false;
    } else if (sno1.length < 6 || sno2.length < 7) {
        alert("주민등록번호 자릿수를 정확히 입력해주세요.");
        return false;
    } else {
        return true;
    }
}

// 정규식으로 전화번호 체크
function joinPhoneCheck() {
    var phone1 = document.getElementById("joinPhoneNo1").value;
    var phone2 = document.getElementById("joinPhoneNo2").value;
    var phone3 = document.getElementById("joinPhoneNo3").value;
    var phoneRegex = /^(?=.*\d)/;
    if (!phoneRegex.test(phone1) || !phoneRegex.test(phone2) || !phoneRegex.test(phone3)) {
        alert("전화번호 형식에 맞게 적어주세요.");
        return false;
    } else if (phone1.length < 3 || phone2.length < 4 || phone3.length < 4) {
        alert("전화번호 자릿수를 정확히 입력해주세요.");
        return false;
    } else {
        return true;
    }
}

// 회원 가입 처리용
function joinCheck() {

    // id값으로 입력값을 얻어와서 각각의 변수에 저장
    var joinId = document.getElementById("joinId").value;
    var joinPwd = document.getElementById("joinPwd").value;
    var joinConfirm = document.getElementById("joinConfirm").value;
    var joinName = document.getElementById("joinName").value;
    var joinSno1 = document.getElementById("joinSno1").value;
    var joinSno2 = document.getElementById("joinSno2").value;
    var joinSex = document.getElementById("joinSex").value;
    var joinPhoneNo1 = document.getElementById("joinPhoneNo1").value;
    var joinPhoneNo2 = document.getElementById("joinPhoneNo2").value;
    var joinPhoneNo3 = document.getElementById("joinPhoneNo3").value;
    var joinSex = $('input[name=sex]').is(":checked");
    var checkbox = $('input[name=agreementCheck]').is(":checked");

    var check1 = false;
    var check2 = false;
    var check3 = false;
    var check4 = false;
    var check5 = false;
    var check6 = false;
    var check7 = false;
    var check8 = false;
    var check9 = false;

    // 입력체크 시작
    if (joinId == null || joinId == "") {
        alert("아이디를 입력해주세요.");
        return false;
    } else {
        check1 = true;
    }

    if (joinPwd == null || joinPwd == "") {
        alert("비밀번호를 입력해주세요.");
        return false;
    } else {
        check2 = true;
    }

    if (joinConfirm == null || joinConfirm == "") {
        alert("비밀번호 확인란을 입력해주세요.");
        return false;
    } else {
        check3 = true;
    }

    if (joinPwd != joinConfirm) {
        alert("입력하신 비밀번호를 확인해주세요.");
        return false;
    }

    if (joinName == null || joinName == "") {
        alert("이름을 입력해주세요.");
        return false;
    } else {
        check4 = true;
    }

    if (joinSno1 == null || joinSno1 == "" || joinSno2 == null || joinSno2 == "") {
        alert("주민등록 번호를 입력해주세요.");
        return false;
    } else {
        check5 = true;
    }
    if (joinSex == null || joinSex == "") {
        alert("성별을 선택 해주세요.");
        return false;
    } else {
        check6 = true;
    }
    if (joinPhoneNo1 == null || joinPhoneNo1 == "" || joinPhoneNo2 == null || joinPhoneNo2 == "" || joinPhoneNo3 == null || joinPhoneNo3 == "") {
        alert("핸드폰 번호를 입력해주세요.");
        return false;
    } else {
        check7 = true;
    }
    if (joinName == null || joinName == "") {
        alert("이름을 입력해주세요.");
        return false;
    } else {
        check8 = true;
    }
    if (checkbox == null || checkbox == "") {
        alert("약관을 읽어주세요.");
        return false;
    } else {
        check9 = true;
    }

    if (joinIdCheck() && joinPwdCheck() && joinNameCheck() && joinSnoCheck() && joinPhoneCheck()) {
        if (check1 && check2 && check2 && check3 && check4 && check5 && check6 && check7 && check8 && check9) {
            alert("환영합니다!");
            location.href = '../index.html';
        }
    }
}

// 뒤로가기
function goBack() {

    history.back();

}

// 마이페이지로
function goMypage() {
    location.href = "../html/user/myPage.html";
}

// 관리자페이지로
function goAdminPage() {
    location.href = "../html/admin/admin.html";
}

// 로그아웃
function logOut() {
    if (confirm("로그아웃 하시겠습니까?")) {
        alert("로그아웃 하였습니다.");
        location.href = "./index.html";
    }
}

// 로그아웃
function goLogin() {
    if (confirm("로그아웃 하시겠습니까?")) {
        alert("로그아웃 하였습니다.");
        location.href = "./index.html";
    }
}

function goLogin() {
    location.href = "../user/login.html?login";
}

// 로그인 화면 엔터키 사용
$("#loginForm").keypress(function(e) {
    if (e.keyCode == 13) {
        login();
    }
});

// 아이디 찾기 화면 엔터키 사용
$("#searchId").keypress(function(e) {
    if (e.keyCode == 13) {
        searchId();
    }
});

// 비밀번호 찾기 화면 엔터키 사용
$("#changePwd").keypress(function(e) {
    if (e.keyCode == 13) {
        changePwd();
    }
});

// 회원가입 찾기 화면 엔터키 사용
$("#joinUser").keypress(function(e) {
    if (e.keyCode == 13) {
        joinCheck();
    }
});
// 로그인 페이지 js 끝