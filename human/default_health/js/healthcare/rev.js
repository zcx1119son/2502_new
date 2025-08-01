// 메인화면으로
function goMain() {
    location.href = "../index.html";
}

// 작성확인용
function reg() {
    if (confirm("작성하시겠습니까?")) {
        alert("작성이 완료되었습니다.");
        history.back();
    } else {
        alert("취소하였습니다.");
    }
}

// 신고 처리
function clickDeclaration(button) {
    if (confirm("신고하겠습니까?")) {
        alert("신고가 완료됬습니다.");

        const img = button.querySelector("img");

        img.src = "../../images/common/disableSirenLogo.png";
        button.disabled = true;

    }
}

// 상품 리뷰 페이징 처리용
const reviewsEquipment = [
    { writer: "김종국", content: "사이즈가 딱 이에요!", star: 5 },
    { writer: "유영근", content: "무릎 아파서 샀어요", star: 4 },
    { writer: "조현우", content: "비싸요.", star: 1 },
    { writer: "김지훈", content: "좋네요", star: 5 },
    { writer: "엄정민", content: "튼튼해서 좋아요", star: 4 },
    { writer: "홍길동", content: "생각보다 작네요", star: 4 },
    { writer: "고길동", content: "디자인이 별로에요.", star: 1 }
    // 더 추가 가능
];

const pageSizeEquip = 3;
let currentPageEquip = 1;

function renderReviewPageEquip(page) {
    const start = (page - 1) * pageSizeEquip;
    const end = start + pageSizeEquip;
    const slice = reviewsEquipment.slice(start, end);
    const tbody = document.getElementById("reviewBodyEquipment");

    tbody.innerHTML = slice.map(r => `
        <tr>
            <td>${r.writer}</td>
            <td>${r.content}</td>
            <td class="star">${"&#xf005;".repeat(r.star)}</td>
            <td>
                <button class="sirenLogo" onclick="clickDeclaration(this);">
                    <img src="../../images/common/sirenLogo.png" width="50">
                </button>
            </td>
        </tr>
    `).join("");
}

function renderPagingEquip() {
    const totalPages = Math.ceil(reviewsEquipment.length / pageSizeEquip);
    const pagesContainer = document.querySelector("#product-section-equipment .paging .pages");
    pagesContainer.innerHTML = "";

    if (totalPages <= 1) return; // 한 페이지만 있으면 페이징 숨김

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === currentPageEquip) span.classList.add("active");
        span.onclick = () => {
            currentPageEquip = i;
            renderReviewPageEquip(currentPageEquip);
            renderPagingEquip();
        };
        pagesContainer.appendChild(span);
    }

    // 조건부 더보기
    if (totalPages > 5) {
        const moreSpan = document.createElement("span");
        moreSpan.textContent = "...(더보기)";
        pagesContainer.appendChild(moreSpan);
    }
}

// 페이지 아이콘 연결
document.querySelector("#product-section-equipment #first_page").onclick = () => {
    currentPageEquip = 1;
    renderReviewPageEquip(currentPageEquip);
    renderPagingEquip();
};

document.querySelector("#product-section-equipment #prev_page").onclick = () => {
    if (currentPageEquip > 1) {
        currentPageEquip--;
        renderReviewPageEquip(currentPageEquip);
        renderPagingEquip();
    }
};

document.querySelector("#product-section-equipment #next_page").onclick = () => {
    const totalPages = Math.ceil(reviewsEquipment.length / pageSizeEquip);
    if (currentPageEquip < totalPages) {
        currentPageEquip++;
        renderReviewPageEquip(currentPageEquip);
        renderPagingEquip();
    }
};

document.querySelector("#product-section-equipment #last_page").onclick = () => {
    currentPageEquip = Math.ceil(reviewsEquipment.length / pageSizeEquip);
    renderReviewPageEquip(currentPageEquip);
    renderPagingEquip();
};

// 초기 렌더링
renderReviewPageEquip(currentPageEquip);
renderPagingEquip();

const reviewsSupplement = [
    { writer: "김종국", content: "잘먹고 오늘도 득근하러 갑니다.", star: 5 },
    { writer: "엄정민", content: "초코우유 먹는거 같아요.", star: 5 },
    { writer: "조현우", content: "무난해요.", star: 4 },
    { writer: "김지훈", content: "초코맛 진짜 좋아요!", star: 5 },
    { writer: "유영근", content: "효과는 잘 모르겠어요.", star: 3 },
    { writer: "홍길동", content: "먹고 살쪘어요", star: 3 },
    { writer: "고길동", content: "맛없어요.", star: 5 }
];

const pageSize = 3;
let currentPage = 1;

function renderReviewPage(page) {
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const slice = reviewsSupplement.slice(start, end);
    const tbody = document.getElementById("reviewBodySupplement");

    tbody.innerHTML = slice.map(r => `
    <tr>
        <td>${r.writer}</td>
        <td>${r.content}</td>
        <td class="star">${"&#xf005;".repeat(r.star)}</td>
        <td>
            <button class="sirenLogo" onclick="clickDeclaration(this);">
                <img src="../../images/common/sirenLogo.png" width="50">
            </button>
        </td>
    </tr>
`).join("");
}

function renderPaging() {
    const totalPages = Math.ceil(reviewsSupplement.length / pageSize);
    const pagesContainer = document.querySelector("#product-section-supplement .paging .pages");
    pagesContainer.innerHTML = "";

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === currentPage) span.classList.add("active");
        span.onclick = () => {
            currentPage = i;
            renderReviewPage(currentPage);
            renderPaging();
        };
        pagesContainer.appendChild(span);
    }
}

// 페이지 아이콘 연결
document.querySelector("#product-section-supplement #first_page").onclick = () => {
    currentPage = 1;
    renderReviewPage(currentPage);
    renderPaging();
};

document.querySelector("#product-section-supplement #prev_page").onclick = () => {
    if (currentPage > 1) {
        currentPage--;
        renderReviewPage(currentPage);
        renderPaging();
    }
};

document.querySelector("#product-section-supplement #next_page").onclick = () => {
    const totalPages = Math.ceil(reviewsSupplement.length / pageSize);
    if (currentPage < totalPages) {
        currentPage++;
        renderReviewPage(currentPage);
        renderPaging();
    }
};

document.querySelector("#product-section-supplement #last_page").onclick = () => {
    currentPage = Math.ceil(reviewsSupplement.length / pageSize);
    renderReviewPage(currentPage);
    renderPaging();
};

// 초기 렌더링
renderReviewPage(currentPage);
renderPaging();