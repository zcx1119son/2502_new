//  관리자 페이지용 js

// 헤더 로고 클릭 시 메인 이동용
function goMain() {
    window.location.href = "../index.html";
}

// 헤더영역 로그인 클릭 시
function goLogin() {
    window.location.href = "../user/login.html?login";
}

// 운동법 페이지로
function goEx() {
    location.href = "../exercise/exMet.html";
}

// 운동장비 페이지로
function goEq() {
    location.href = "../healthcare/equipments.html";
}

// 보조식품 페이지로
function goSup() {
    location.href = "../healthcare/supplements.html";
}

// 게시판 페이지로
function goBoard() {
    location.href = "../board/board.html";
}

// 관리자 페이지 수정
function updateCheck() {
    if (confirm("수정하시겠습니까?")) {
        alert("수정완료");
    } else {
        alert("취소하였습니다.");
    }
}

// 관리자 페이지(등록) 이동
function goReg() {
    window.location.href = "../admin/adminReg.html";
}

// 관리자 페이지(등록)에서 관리자 페이지 메인으로 이동
function goList() {
    location.href = "../admin/admin.html";
}

function add() {
    if (confirm("수정하시겠습니까?")) {
        alert("수정완료");
    } else {
        alert("취소하였습니다.");
    }
}

// 운동법 탭 탭 추가용
function addExRow() {
    // 현재 선택된 라디오 버튼 찾기
    const selected = document.querySelector('input[name="detailItem"]:checked');
    const selectedId = selected ? selected.id : null;

    if (!selectedId) {
        return
    };

    // 선택된 탭 콘텐츠 ID에 맞는 테이블 찾기
    const table = document.querySelector(`#${selectedId}Content table`);

    if (!table) {
        return
    };

    const newRow = table.insertRow();

    const newCell1 = newRow.insertCell(0);
    newCell1.innerHTML = '<input type="text" placeholder="운동 이름">';

    const newCell2 = newRow.insertCell(1);
    newCell2.innerHTML = '<input type="file">';

    const newCell3 = newRow.insertCell(2);
    newCell3.innerHTML = '<input type="text" placeholder="상세 설명">';

    const newCell4 = newRow.insertCell(3);
    newCell4.innerHTML = `
    <select>
        <option value="O">O</option>
        <option value="X">X</option>
    </select>
`;
    const newCell5 = newRow.insertCell(4);
    newCell5.innerHTML = `
    <td><button type="button" class="button" onclick="deleteRow(this)">삭제</button></td>`;
}

// 광고탭 탭 추가용
function addAdRow() {
    const table = document.querySelector('#adAdd table');                   // 테이블 선택

    if (!table) {
        alert("테이블을 찾을 수 없습니다.");
        return;
    }

    const newRow = table.insertRow();

    newRow.innerHTML = `
        <td><input type="text" placeholder="번호"></td>
        <td><input type="text" placeholder="보충제"></td>
        <td><input type="text" placeholder="광고링크"></td>
        <td>
            <select>
                <option value="O">O</option>
                <option value="X">X</option>
            </select>
        </td>
        <td><button type="button" class="button"">광고 내리기</button></td>
        <td>${getToday()}</td>
        <td>${getToday()}</td>
        <td><button type="button" class="button" onclick="deleteRow(this)">삭제</button></td>
    `;
}

// 보충제, 영양제 탭 추가용
function addHealthRow() {
    const table = document.querySelector('#healthMContent table');
    if (!table) return;

    const newRow = table.insertRow();

    newRow.innerHTML = `
        <td><input type="file"></td>
        <td><input type="text" placeholder="상세설명 / URL"></td>
        <td>
            <select>
                <option value="O">O</option>
                <option value="X">X</option>
            </select>
        </td>
        <td>${getToday()}</td>
        <td>${getToday()}</td>
        <td><button type="button" class="button" onclick="deleteRow(this)">삭제</button></td>
    `;
}

// 운동 기구 탭 추가용
function addEquipRow() {
    const table = document.querySelector('#equipmentContent table');
    if (!table) return;

    const newRow = table.insertRow();

    newRow.innerHTML = `
        <td><input type="file"></td>
        <td><input type="text" placeholder="상세설명 / URL"></td>
        <td>
            <select>
                <option value="O">O</option>
                <option value="X">X</option>
            </select>
        </td>
        <td>${getToday()}</td>
        <td>${getToday()}</td>
        <td><button type="button" class="button" onclick="deleteRow(this)">삭제</button></td>
    `;
}

// 오늘 날짜 확인용
function getToday() {
    const today = new Date();
    return today.toISOString().slice(2, 10).replace(/-/g, '/');
}

// 행 삭제용
function deleteRow(button) {
    const row = button.closest('tr');                   // 버튼이 속한 <tr> 찾기
    if (row) {
        row.remove();                                   // 행 삭제
    }
}

// 관리자페이지에서 메인화면으로
function goMainAdmin() {
    location.href = "../index_admin.html";
}

// 관리자페이지에서 관리자페이지로
function goAdminPage() {
    location.href = "./admin.html";
}

// 로그아웃
function logOut() {
    if (confirm("로그아웃 하시겠습니까?")) {
        alert("로그아웃 하였습니다.");
        location.href = "../index.html";
    }
}

// 운동법 더미데이터
const exerciseData = {
    chest: [
        "벤치프레스", "덤벨 벤치 프레스", "덤벨 풀오버", "덤벨 플라이", "푸쉬업",
        "케이블 크로스오버", "딥스", "체스트 플레스 머신", "스미스 머신 벤치 프레스",
        "인클라인 벤치프레스", "덤벨 인클라인 벤치프레스", "디클라인 벤치프레스",
        "케이블 플라이", "덤벨 체스트 플라이", "체스트 딥스", "머신 체스트 프레스",
        "펙덱 머신", "케이블 크로스오버", "트라이셉 딥스", "덤벨 푸쉬업", "체스트 스트레칭"
    ],
    back: [
        "데드리프트", "바벨 로우", "풀 업", "루마니안 데드리프트", "랫 풀다운",
        "백 익스텐션", "시티드 케이블 로우", "시티드 로우 머신", "덤벨 데드리프트"
    ],
    shoulder: [
        "오버헤드 프레스", "덤벨 숄더 프레스", "덤벨 레터럴 레이즈", "숄더 프레스 머신",
        "레터럴 레이즈 머신", "시티드 오버헤드 프레스", "덤벨 프론트 레이즈",
        "페이스 풀", "리버스 케이블 플라이"
    ],
    under: [
        "바벨 스쿼트", "런지", "레그 프레스", "레그 컬", "바벨 스티프 레그 데드리프트",
        "브이 스쿼트", "레그 익스텐션", "덤벨 런지", "핵 스쿼트 머신"
    ],
    abs: [
        "레그 레이즈", "크런치", "케이블 크런치", "캡틴스 체어 레그 레이즈", "행잉 레그 레이즈",
        "바이시클 크런치", "디클라인 크런치", "덤벨 사이드 밴드", "플랭크"
    ]
};

// 회원 더미 데이터
const userData = [
    { num: "1", id: "김지훈", phone: "010-1234-5678", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/23" },
    { num: "2", id: "유영근", phone: "010-5678-1234", sleepUser: "O", deleteUser: "X", userAdd: "2025/04/20" },
    { num: "3", id: "엄정민", phone: "010-8765-4321", sleepUser: "X", deleteUser: "O", userAdd: "2025/04/22" },
    { num: "4", id: "조현우", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "5", id: "김종국", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "6", id: "더미1", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "7", id: "더미2", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "8", id: "더미3", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "9", id: "더미4", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "10", id: "더미5", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "11", id: "더미6", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "12", id: "유재석", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "13", id: "더미7", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "14", id: "더미8", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "15", id: "더미9", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "16", id: "더미10", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "17", id: "더미11", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "18", id: "더미12", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "19", id: "더미13", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "20", id: "더미14", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "21", id: "김계란", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "22", id: "더미15", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "23", id: "더미16", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "24", id: "더미17", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "25", id: "더미18", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    { num: "26", id: "관라자", phone: "010-2222-3333", sleepUser: "X", deleteUser: "X", userAdd: "2025/04/21" },
    // 더미 데이터 추가
];

// 광고 더미 데이터
const adData = [
    {
        num: "1",
        name: "보충제1",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "2",
        name: "보충제2",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "3",
        name: "보충제3",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "4",
        name: "보충제4",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "5",
        name: "보충제5",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "6",
        name: "보충제6",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "7",
        name: "보충제7",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "8",
        name: "보충제8",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "9",
        name: "영양제1",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "10",
        name: "영양제2",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "11",
        name: "영양제3",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "12",
        name: "영양제4",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
    {
        num: "13",
        name: "영양제5",
        link: "#",
        addAgr: "O",
        deleteFlag: "X",
        addDate: "2025/04/23",
        endDate: "2025/04/23"
    },
];


// 건강보조 더미 데이터
const supplementData = [
    { img: "", detail: "상품입니다1.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다2.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다3.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다4.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다5.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다6.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다7.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다8.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다9.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다10.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다11.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다12.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다13.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다14.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다15.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다16.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다17.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다18.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다19.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다20.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다21.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다22.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다23.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다24.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    // 더미 데이터 추가
];

// 운동기구 더미 데이터
const eqData = [
    { img: "", detail: "상품입니다1.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다2.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다3.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다4.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다5.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다6.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다7.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다8.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다9.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다10.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다11.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다12.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다13.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다14.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다15.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다16.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다17.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다18.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다19.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다20.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다21.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다22.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다23.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    { img: "", detail: "상품입니다24.", addAgr: "O", addDate: "2025/04/23", dueDate: "2025/04/23" },
    // 더미 데이터 추가
];

// 한 페이지에 표시될 데이터
const pageSize = 20;

// 페이지 체크
let currentPage1 = 1;
let currentPage2 = 1;
let currentPage3 = 1;
let currentPage4 = 1;

const state = {
    chest: 1,
    back: 1,
    shoulder: 1,
    under: 1,
    abs: 1
};

// 운동법 페이징 처리용
function renderExercisePage(category) {
    const list = exerciseData[category];
    const page = state[category];
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const sliced = list.slice(start, end);

    const tbody = document.getElementById(`${category}TableBody`);
    tbody.innerHTML = sliced.map(name => `<tr><td>${name}</td></tr>`).join("");

    renderExercisePaging(category);
}

function renderExercisePaging(category) {
    const totalPages = Math.ceil(exerciseData[category].length / pageSize);
    const pagesContainer = document.getElementById(`${category}Pages`);
    pagesContainer.innerHTML = "";

    if (totalPages <= 1) {
        document.getElementById(`${category}Paging`).style.display = "none";
        return;
    } else {
        document.getElementById(`${category}Paging`).style.display = "flex";
    }

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === state[category]) span.classList.add("active");
        span.onclick = () => {
            state[category] = i;
            renderExercisePage(category);
        };
        pagesContainer.appendChild(span);
    }

    if (totalPages > 5) {
        const more = document.createElement("span");
        more.textContent = "...(더보기)";
        pagesContainer.appendChild(more);
    }
}

function goFirst(category) {
    state[category] = 1;
    renderExercisePage(category);
}

function goPrev(category) {
    if (state[category] > 1) {
        state[category]--;
        renderExercisePage(category);
    }
}

function goNext(category) {
    const total = Math.ceil(exerciseData[category].length / pageSize);
    if (state[category] < total) {
        state[category]++;
        renderExercisePage(category);
    }
}

function goLast(category) {
    state[category] = Math.ceil(exerciseData[category].length / pageSize);
    renderExercisePage(category);
}

// 초기화 및 페이지 렌더링
renderExercisePage("chest");
renderExercisePage("back");
renderExercisePage("shoulder");
renderExercisePage("under");
renderExercisePage("abs");


// 회원 정보 페이징 처리
function renderUserPage(page) {
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const slice = userData.slice(start, end);
    const tbody = document.getElementById("userList");

    tbody.innerHTML = slice.map(r => `
        <tr>
            <td></td>
            <td>${r.num}</td>
            <td>${r.id}</td>
            <td>${r.phone}</td>
            <td>${r.sleepUser}</td>
            <td>${r.deleteUser}</td>
            <td>${r.userAdd}</td>
        </tr>
    `).join("");
}

function renderUserPaging() {
    const totalPages = Math.ceil(userData.length / pageSize);
    const pagesContainer = document.querySelector("#users .paging .pages");
    pagesContainer.innerHTML = "";

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === currentPage1) span.classList.add("active");
        span.onclick = () => {
            currentPage1 = i;
            renderUserPage(currentPage1);
            renderUserPaging();
        };
        pagesContainer.appendChild(span);
    }
}

// 페이지 아이콘 연결
document.querySelector("#users #first_page").onclick = () => {
    currentPage1 = 1;
    renderUserPage(currentPage1);
    renderUserPaging();
};

document.querySelector("#users #prev_page").onclick = () => {
    if (currentPage1 > 1) {
        currentPage1--;
        renderUserPage(currentPage1);
        renderUserPaging();
    }
};

document.querySelector("#users #next_page").onclick = () => {
    const totalPages = Math.ceil(userData.length / pageSize);
    if (currentPage1 < totalPages) {
        currentPage1++;
        renderUserPage(currentPage1);
        renderUserPaging();
    }
};

document.querySelector("#users #last_page").onclick = () => {
    currentPage1 = Math.ceil(userData.length / pageSize);
    renderUserPage(currentPage1);
    renderUserPaging();
};

// 초기 렌더링
renderUserPage(currentPage1);
renderUserPaging();

// 배너광고 페이징 처리
function renderAdPage(page) {
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const slice = adData.slice(start, end);
    const tbody = document.getElementById("adContent");

    tbody.innerHTML = slice.map(r => `
        <tr>
            <td>${r.num}</td>
            <td>${r.name}</td>
            <td>${r.link}</td>
            <td>${r.addAgr}</td>
            <td>${r.deleteFlag}</td>
            <td>${r.addDate}</td>
            <td>${r.endDate}</td>
        </tr>
    `).join("");
}

function renderAdPaging() {
    const totalPages = Math.ceil(adData.length / pageSize);
    const pagesContainer = document.querySelector("#ad .paging .pages");
    pagesContainer.innerHTML = "";

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === currentPage2) span.classList.add("active");
        span.onclick = () => {
            currentPage2 = i;
            renderAdPage(currentPage2);
            renderAdPaging();
        };
        pagesContainer.appendChild(span);
    }
}

// 페이지 아이콘 연결
document.querySelector("#ad #first_page").onclick = () => {
    currentPage2 = 1;
    renderAdPage(currentPage2);
    renderAdPaging();
};

document.querySelector("#ad #prev_page").onclick = () => {
    if (currentPage2 > 1) {
        currentPage2--;
        renderAdPage(currentPage2);
        renderAdPaging();
    }
};

document.querySelector("#ad #next_page").onclick = () => {
    const totalPages = Math.ceil(adData.length / pageSize);
    if (currentPage2 < totalPages) {
        currentPage2++;
        renderAdPage(currentPage2);
        renderAdPaging();
    }
};

document.querySelector("#ad #last_page").onclick = () => {
    currentPage2 = Math.ceil(adData.length / pageSize);
    renderAdPage(currentPage2);
    renderAdPaging();
};

// 초기 렌더링
renderAdPage(currentPage2);
renderAdPaging();


// 건강보조식품 페이징 처리
function renderSupplePage(page) {
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const slice = supplementData.slice(start, end);
    const tbody = document.getElementById("supplementData");

    tbody.innerHTML = slice.map(r => `
        <tr>
            <td>
                <img src = "../../images/supplements/nutritional6.JPG" style="width: 200px; height: 150px;">
                <input type = "file">
            </td>
                <td contenteditable="true">${r.detail}</td>
            <td>
                <select name="" id="">
                    <option value="O">O</option>
                    <option value="X">X</option>
                </select>
            </td>
            <td contenteditable="true">${r.addDate}</td>
            <td contenteditable="true">${r.dueDate}</td>
        </tr>
    `).join("");
}

function renderSupPaging() {
    const totalPages = Math.ceil(supplementData.length / pageSize);
    const pagesContainer = document.querySelector("#supplement .paging .pages");
    pagesContainer.innerHTML = "";

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === currentPage3) span.classList.add("active");
        span.onclick = () => {
            currentPage3 = i;
            renderSupplePage(currentPage3);
            renderSupPaging();
        };
        pagesContainer.appendChild(span);
    }
}

// 페이지 아이콘 연결
document.querySelector("#supplement #first_page").onclick = () => {
    currentPage = 1;
    renderSupplePage(currentPage3);
    renderSupPaging();
};

document.querySelector("#supplement #prev_page").onclick = () => {
    if (currentPage3 > 1) {
        currentPage3--;
        renderSupplePage(currentPage3);
        renderSupPaging();
    }
};

document.querySelector("#supplement #next_page").onclick = () => {
    const totalPages = Math.ceil(supplementData.length / pageSize);
    if (currentPage3 < totalPages) {
        currentPage3++;
        renderSupplePage(currentPage3);
        renderSupPaging();
    }
};

document.querySelector("#supplement #last_page").onclick = () => {
    currentPage3 = Math.ceil(supplementData.length / pageSize);
    renderSupplePage(currentPage3);
    renderSupPaging();
};

// 초기 렌더링
renderSupplePage(currentPage3);
renderSupPaging();

// 운동기구 페이징 처리
function renderEqPage(page) {
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const slice = eqData.slice(start, end);
    const tbody = document.getElementById("eqData");

    tbody.innerHTML = slice.map(r => `
        <tr>
            <td>
                <img src = "../../images/equipments/gymGloves.jpg" style="width: 200px; height: 150px;">
                <input type = "file">
            </td>
            <td contenteditable="true">${r.detail}</td>
            <td>
                <select name="" id="">
                    <option value="O">O</option>
                    <option value="X">X</option>
                </select>
            </td>
            <td contenteditable="true">${r.addDate}</td>
            <td contenteditable="true">${r.dueDate}</td>
        </tr>
    `).join("");
}

function renderEqPaging() {
    const totalPages = Math.ceil(eqData.length / pageSize);
    const pagesContainer = document.querySelector("#equipment .paging .pages");
    pagesContainer.innerHTML = "";

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === currentPage4) span.classList.add("active");
        span.onclick = () => {
            currentPage4 = i;
            renderEqPage(currentPage4);
            renderEqPaging();
        };
        pagesContainer.appendChild(span);
    }
}

// 페이지 아이콘 연결
document.querySelector("#equipment #first_page").onclick = () => {
    currentPage4 = 1;
    renderEqPage(currentPage4);
    renderEqPaging();
};

document.querySelector("#equipment #prev_page").onclick = () => {
    if (currentPage4 > 1) {
        currentPage4--;
        renderEqPage(currentPage4);
        renderEqPaging();
    }
};

document.querySelector("#equipment #next_page").onclick = () => {
    const totalPages = Math.ceil(supplementData.length / pageSize);
    if (currentPage4 < totalPages) {
        currentPage4++;
        renderEqPage(currentPage4);
        renderEqPaging();
    }
};

document.querySelector("#equipment #last_page").onclick = () => {
    currentPage4 = Math.ceil(supplementData.length / pageSize);
    renderEqPage(currentPage4);
    renderEqPaging();
};

// 초기 렌더링
renderEqPage(currentPage4);
renderEqPaging();
