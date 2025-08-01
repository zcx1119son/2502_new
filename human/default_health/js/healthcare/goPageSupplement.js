let currentPageProtein = 1;
let currentPageSupplement = 1;
const itemsPerPage = 4;

const proteinProducts = [
  { name: '칼로바이 밸런스 파워쉐이크', image: '../../images/supplements/Protein1.jpg' },
  { name: '웨이테크 더블유테크 프로틴', image: '../../images/supplements/Protein2.jpg' },
  { name: '독일분리유청 단백질', image: '../../images/supplements/Protein3.jpg' },
  { name: '킹콩 팩토리 벌크업 게이너', image: '../../images/supplements/Protein4.jpg' },
  { name: '닥터린 유기농 산양유 프로틴', image: '../../images/supplements/Protein5.jpg' },
  { name: '마이프로틴 임팩트웨이 프로틴', image: '../../images/supplements/Protein6.jpg' },
  { name: '뉴욕웨이 몬스터 2Kg 게이너', image: '../../images/supplements/Protein7.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplementsProtein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
  { name: 'NS 매스웨이 프로틴', image: '../../images/supplements/Protein8.jpg' },
];

const supplementProducts = [
  { name: '닥터린 올인원 멀티비타민', image: '../../images/supplements/nutritional1.JPG' },
  { name: '고려은단 메가도스C 비타민C', image: '../../images/supplements/nutritional2.JPG' },
  { name: '익스트림 아르기닌 젤리스틱', image: '../../images/supplements/nutritional3.JPG' },
  { name: '아미노리젠 오리지널 회복용', image: '../../images/supplements/nutritional4.JPG' },
  { name: '삼대오백 EAA 아미노산', image: '../../images/supplements/nutritional5.JPG' },
  { name: '주연엔에스 관절엔 콘드로이친', image: '../../images/supplements/nutritional6.JPG' },
  { name: '뉴트리모어 오메가3 DHA1000', image: '../../images/supplements/nutritional7.JPG' },
  { name: '익스트림 크레아틴 플러스', image: '../../images/supplements/nutritional8.JPG' }
];

// 페이지 번호 업데이트 함수
function updatePagination(type, page) {
  const pagination = document.getElementById(type + 'Pages');
  pagination.innerHTML = '';  // 초기화

  const products = type === 'protein' ? proteinProducts : supplementProducts;
  const totalPages = Math.ceil(products.length / itemsPerPage);

  for (let i = 1; i <= totalPages; i++) {
    const startIndex = (i - 1) * itemsPerPage;
    const endIndex = Math.min(startIndex + itemsPerPage, products.length);

    // 해당 페이지에 데이터가 있을 때만 페이지 번호 표시
    if (startIndex < products.length) {
      const pageElement = document.createElement('span');
      pageElement.textContent = i;
      if (i === page) {
        pageElement.classList.add('active');
      }
      pageElement.addEventListener('click', () => {
        if (type === 'protein') {
          currentPageProtein = i;
        } else {
          currentPageSupplement = i;
        }
        updateTableContent(type, i);
        updatePagination(type, i);
      });
      pagination.appendChild(pageElement);
    }
  }
}

// 페이지 내용 업데이트 함수
function updateTableContent(type, page) {
  let products;
  let table;

  if (type === 'protein') {
    products = proteinProducts;
    table = document.getElementById('proteinTable');
  } else {
    products = supplementProducts;
    table = document.getElementById('supplementTable');
  }

  table.innerHTML = ''; // 기존 테이블 내용 비우기
  const startIndex = (page - 1) * itemsPerPage;
  const endIndex = Math.min(startIndex + itemsPerPage, products.length);

  for (let i = startIndex; i < endIndex; i++) {
    const row = document.createElement('tr');
    const th = document.createElement('th');
    const a = document.createElement('a');
    a.href = './product.html';

    const img = document.createElement('img');
    img.src = products[i].image;
    a.appendChild(img);

    const p = document.createElement('p');
    p.textContent = products[i].name;
    a.appendChild(p);

    th.appendChild(a);
    row.appendChild(th);
    table.appendChild(row);
  }
}

// 페이지 로드 시 초기화
updateTableContent('protein', currentPageProtein);
updatePagination('protein', currentPageProtein);
updateTableContent('supplement', currentPageSupplement);
updatePagination('supplement', currentPageSupplement);

// 이전, 다음 버튼 이벤트
document.getElementById('prev_page_protein').addEventListener('click', () => {
  if (currentPageProtein > 1) {
    currentPageProtein--;
    updateTableContent('protein', currentPageProtein);
    updatePagination('protein', currentPageProtein);
  }
});

document.getElementById('next_page_protein').addEventListener('click', () => {
  const totalPages = Math.ceil(proteinProducts.length / itemsPerPage);
  if (currentPageProtein < totalPages) {
    currentPageProtein++;
    updateTableContent('protein', currentPageProtein);
    updatePagination('protein', currentPageProtein);
  }
});

document.getElementById('prev_page_supplement').addEventListener('click', () => {
  if (currentPageSupplement > 1) {
    currentPageSupplement--;
    updateTableContent('supplement', currentPageSupplement);
    updatePagination('supplement', currentPageSupplement);
  }
});

document.getElementById('next_page_supplement').addEventListener('click', () => {
  const totalPages = Math.ceil(supplementProducts.length / itemsPerPage);
  if (currentPageSupplement < totalPages) {
    currentPageSupplement++;
    updateTableContent('supplement', currentPageSupplement);
    updatePagination('supplement', currentPageSupplement);
  }
});

// 처음과 마지막 페이지로 가는 버튼
document.getElementById('first_page_protein').addEventListener('click', () => {
  currentPageProtein = 1;
  updateTableContent('protein', currentPageProtein);
  updatePagination('protein', currentPageProtein);
});

document.getElementById('last_page_protein').addEventListener('click', () => {
  currentPageProtein = Math.ceil(proteinProducts.length / itemsPerPage);
  updateTableContent('protein', currentPageProtein);
  updatePagination('protein', currentPageProtein);
});

document.getElementById('first_page_supplement').addEventListener('click', () => {
  currentPageSupplement = 1;
  updateTableContent('supplement', currentPageSupplement);
  updatePagination('supplement', currentPageSupplement);
});

document.getElementById('last_page_supplement').addEventListener('click', () => {
  currentPageSupplement = Math.ceil(supplementProducts.length / itemsPerPage);
  updateTableContent('supplement', currentPageSupplement);
  updatePagination('supplement', currentPageSupplement);
});

// 메인화면으로
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