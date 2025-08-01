function sortTable(n) {
  const table = document.getElementById('board');
  const tbody = table.querySelector('tbody');
  const rows = Array.from(tbody.querySelectorAll('tr'));

  rows.sort((rowA, rowB) => {
    const cellA = rowA.querySelectorAll('td')[n].textContent;
    const cellB = rowB.querySelectorAll('td')[n].textContent;
    return cellA.localeCompare(cellB, undefined, {
      numeric: true,
      sensitivity: 'base',
    });
  });

  if (table.getAttribute('data-sort-dir') === 'asc') {
    rows.reverse();
    table.setAttribute('data-sort-dir', 'desc');
  } else {
    table.setAttribute('data-sort-dir', 'asc');
  }

  table.removeChild(tbody);
  rows.forEach((row) => tbody.appendChild(row));
  table.appendChild(tbody);
}
//게시판 정렬-------------------------------------------------

function goList() {
  location.href = '../../html/board/board_list.html';
}

function goWrite() {
  location.href = '../../html/board/board_write.html';
}

function goBoard() {
  location.href = '../../html/board/board.html';
}

//페이징 처리 =================================================

document.addEventListener('DOMContentLoaded', () => {
  const rowsPerPage = 10;
  const table = document.querySelector('#board tbody');
  const rows = table.querySelectorAll('tr');
  const totalRows = rows.length;
  const totalPages = Math.ceil(totalRows / rowsPerPage);
  const pagesContainer = document.querySelector('.pages');

  let currentPage = 1;

  function showPage(page) {
    currentPage = page;
    const start = (page - 1) * rowsPerPage;
    const end = start + rowsPerPage;

    rows.forEach((row, index) => {
      row.style.display = index >= start && index < end ? '' : 'none';
    });

    updatePagination();
  }

  function updatePagination() {
    pagesContainer.innerHTML = '';

    for (let i = 1; i <= totalPages; i++) {
      const pageSpan = document.createElement('span');
      pageSpan.textContent = i;
      if (i === currentPage) {
        pageSpan.classList.add('active');
      }
      pageSpan.addEventListener('click', () => showPage(i));
      pagesContainer.appendChild(pageSpan);
    }
  }

  document
    .getElementById('first_page')
    .addEventListener('click', () => showPage(1));
  document
    .getElementById('last_page')
    .addEventListener('click', () => showPage(totalPages));
  document.getElementById('prev_page').addEventListener('click', () => {
    if (currentPage > 1) showPage(currentPage - 1);
  });
  document.getElementById('next_page').addEventListener('click', () => {
    if (currentPage < totalPages) showPage(currentPage + 1);
  });

  // 첫 페이지 표시
  showPage(1);
});

//공지글 항상 상단에 고정===========================================

function sortTable(columnIndex) {
  const table = document.querySelector('#board tbody');
  const allRows = Array.from(table.querySelectorAll('tr'));
  const noticeRows = allRows.filter((row) => row.classList.contains('notice'));
  const dataRows = allRows.filter((row) => !row.classList.contains('notice'));

  // 정렬 방향 토글 저장용
  const sortDirection =
    table.getAttribute('data-sort-direction') === 'asc' ? 'desc' : 'asc';
  table.setAttribute('data-sort-direction', sortDirection);

  dataRows.sort((a, b) => {
    const aText = a.children[columnIndex].textContent.trim();
    const bText = b.children[columnIndex].textContent.trim();

    // 숫자 정렬 or 문자열 정렬 판단
    const aVal = isNaN(aText) ? aText : parseFloat(aText);
    const bVal = isNaN(bText) ? bText : parseFloat(bText);

    if (aVal < bVal) return sortDirection === 'asc' ? -1 : 1;
    if (aVal > bVal) return sortDirection === 'asc' ? 1 : -1;
    return 0;
  });

  // 테이블 초기화
  table.innerHTML = '';

  // 공지사항 먼저 추가
  noticeRows.forEach((row) => table.appendChild(row));
  // 정렬된 일반 글 추가
  dataRows.forEach((row) => table.appendChild(row));
}

//버튼 ========================================================

// 신고처리용
function clickDeclaration(button) {
  if (confirm('신고하겠습니까?')) {
    alert('신고가 완료됬습니다.');

    const img = button.querySelector('img');

    img.src = '../../images/common/disableSirenLogo.png';
    button.disabled = true;
  }
}

// 운동법 페이지로
function goEx() {
  location.href = '../exercise/exMet.html';
}

// 운동장비 페이지로
function goEq() {
  location.href = '../healthcare/equipments.html';
}

// 보조식품 페이지로
function goSup() {
  location.href = '../healthcare/supplements.html';
}

// 게시판 페이지로
function goBoard() {
  location.href = './board.html';
}

//공통상품 페이지로
function goProduct() {
  location.href = '../healthcare/product.html';
}

// 광고페이지 이동용
function goAdPage() {
  window.open('https://blog.naver.com/kmgzxcv', '_blank');
}

// 로그인 페이지로
function goLogin() {
  location.href = '../user/login.html?login';
}

// 헤더 로고 클릭 시 메인 이동용
function goMain() {
  location.href = '../index.html';
}

// 취소용
function cancel() {
  history.back();
}

// 경고창 설정
function Warning() {
  alert(
    '저희 헬스커뮤니티는 지적 재산권 침해, 스팸, 불법 콘텐츠, 혐오 발언, 따돌림 및 학대, 장해, 폭력 및 음란물을 금지하고 있습니다.'
  );
}
