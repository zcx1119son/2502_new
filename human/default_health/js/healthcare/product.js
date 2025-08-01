// 페이지당 표시할 상품 개수
const itemsPerPage = 6;

// 총 상품 목록 (이 예시에서는 간단하게 배열로 대체)
const products = [
    { name: "무릎 보호대", price: "₩33,210", image: "KneePads.jpg" },
    { name: "팔꿈치 보호대", price: "₩41,000", image: "elbowProtector.jpg" },
    { name: "허리 벨트", price: "₩25,700", image: "waistBelt.jpeg" },
    { name: "스트랩", price: "₩19,370", image: "strap.jpg" },
    { name: "손목보호대", price: "₩17,700", image: "wristGuard.jpg" },
    { name: "헬스 장갑", price: "₩28,900", image: "gymGloves.jpg" },
    { name: "기타 제품 1", price: "₩20,000", image: "item1.jpg" },
    { name: "기타 제품 2", price: "₩15,000", image: "item2.jpg" },
    { name: "기타 제품 3", price: "₩45,000", image: "item3.jpg" },
    { name: "기타 제품 4", price: "₩10,000", image: "item4.jpg" },
    { name: "기타 제품 5", price: "₩50,000", image: "item5.jpg" },
    { name: "기타 제품 6", price: "₩30,000", image: "item6.jpg" },
    { name: "기타 제품 7", price: "₩22,000", image: "item7.jpg" },
    { name: "기타 제품 8", price: "₩18,000", image: "item8.jpg" }
];

// 페이지 번호와 관련된 변수
let currentPage = 1;
const totalPages = Math.ceil(products.length / itemsPerPage);

// 상품을 페이지에 맞게 동적으로 표시하는 함수
function displayProducts(page) {
    const startIndex = (page - 1) * itemsPerPage;
    const endIndex = Math.min(startIndex + itemsPerPage, products.length);

    // 기존의 상품을 클리어
    const productContainer = document.querySelector('.product-container');
    productContainer.innerHTML = '';

    // 상품을 새로운 페이지에 맞게 추가
    for (let i = startIndex; i < endIndex; i++) {
        const product = products[i];
        const productCard = document.createElement('div');
        productCard.classList.add('product-grid');
        productCard.innerHTML = `
            <div class="product-card">
                <a href="#">
                    <img src="../../images/equipments/${product.image}" alt="${product.name}" onclick="goDetailProduct();">                </a>
                <div class="info">
                    <div>
                        <h3>${product.name}</h3>
                        <p>${product.name}</p>
                        <p class="price">${product.price}</p>
                        <button class="button" onclick="goDetailProduct();">구매하기</button>
                    </div>
                </div>
            </div>
        `;
        productContainer.appendChild(productCard);
    }

    // 페이지 번호 업데이트
    updatePagination(page);
}

// 페이지 번호 업데이트 함수
function updatePagination(page) {
    const pagination = document.querySelector('.pages');
    pagination.innerHTML = '';

    for (let i = 1; i <= totalPages; i++) {
        const pageElement = document.createElement('span');
        pageElement.textContent = i;
        if (i === page) {
            pageElement.classList.add('active');
        }
        pageElement.addEventListener('click', () => {
            currentPage = i;
            displayProducts(i);
        });
        pagination.appendChild(pageElement);
    }
}

// 초기 페이지 로드
displayProducts(currentPage);

// 이전/다음/처음/끝 버튼 이벤트
document.getElementById('prev_page').addEventListener('click', () => {
    if (currentPage > 1) {
        currentPage--;
        displayProducts(currentPage);
    }
});
document.getElementById('next_page').addEventListener('click', () => {
    if (currentPage < totalPages) {
        currentPage++;
        displayProducts(currentPage);
    }
});
document.getElementById('first_page').addEventListener('click', () => {
    currentPage = 1;
    displayProducts(currentPage);
});
document.getElementById('last_page').addEventListener('click', () => {
    currentPage = totalPages;
    displayProducts(currentPage);
});