//할 일 상태 변경 함수
function toggleState(id) {
    const el = document.getElementById('todo-' + id);
	if(!el) return;
	
    const checkbox=el.querySelector('.checkbox');
	const isCompleted=checkbox.checked;
    
	el.setAttribute('data-completed', isCompleted);
	if(isCompleted){
		el.classList.add('completed');
	}else {
		el.classList.remove('completed');
	}
	
	renderFilteredTodos();
}

//할 일 삭제 버튼 함수
function deleteTodo(event, id){
	const item=document.getElementById(`todo-${id}`);
	const checkbox = item.querySelector('.checkbox');
	
	if(checkbox.checked){
		item.remove();
	}else{
		alert('아직 완료가 안 됐습니다.');	
	}
}
//현재 필터 상태=all
let currentFilter = 'all';

// 필터 버튼 이벤트 함수
function initFilterButtons() {
  document.getElementById('filter-all').addEventListener('click', () => setFilter('all'));
  document.getElementById('filter-active').addEventListener('click', () => setFilter('active'));
  document.getElementById('filter-completed').addEventListener('click', () => setFilter('completed'));
}

// 필터 상태 변경 함수
function setFilter(filter) {
  currentFilter = filter;
  updateFilterButtons();
  renderFilteredTodos();
}

//선택된 필터 버튼에 'active' 클래스 추가
function updateFilterButtons() {
  ['all', 'active', 'completed'].forEach(filter => {
    const btn = document.getElementById(`filter-${filter}`);
    if (btn) {
      if (filter === currentFilter){
		btn.classList.add('active');
	  }else {
		btn.classList.remove('active');
		}   
    }
  });
}

// 필터에 맞게 할 일 보여주기
function renderFilteredTodos() {
  const todoList = document.getElementById('todo-list');
  const items = todoList.querySelectorAll('li.todo-item');

  items.forEach(item => {
    const isCompleted = item.getAttribute('data-completed') === 'true';

    switch(currentFilter) {
      case 'all':
        item.style.display = '';
        break;
      case 'active':
        item.style.display = isCompleted ? 'none' : '';
        break;
      case 'completed':
        item.style.display = isCompleted ? '' : 'none';
        break;
    }
  });
}

//필터링 초기화 함수
function init(){
	initFilterButtons();
	renderFilteredTodos();
}

window.onload = init;
