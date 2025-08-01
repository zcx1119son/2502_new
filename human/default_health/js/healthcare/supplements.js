let currentPage = 1;
const totalPages = 5; // 예시로 5페이지라고 가정

// 페이지 내용 업데이트 함수
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
      displayProducts(i); // 상품 목록 표시 함수
    });
    pagination.appendChild(pageElement);
  }
}

// 페이지를 클릭했을 때 콘텐츠를 변경하는 함수
function displayProducts(page) {
  // 여기에 페이지 번호에 맞는 제품 목록을 로드하는 코드 작성
  console.log(`Displaying products for page ${page}`);
  updatePagination(page);
}

// 이전 페이지와 다음 페이지를 클릭했을 때 동작
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

// 첫 번째 페이지와 마지막 페이지 클릭
document.getElementById('first_page').addEventListener('click', () => {
  currentPage = 1;
  displayProducts(currentPage);
});

document.getElementById('last_page').addEventListener('click', () => {
  currentPage = totalPages;
  displayProducts(currentPage);
});

// 처음 페이지를 로드할 때
displayProducts(currentPage);