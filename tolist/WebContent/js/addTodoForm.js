function addTodo() {
    const input = document.getElementById('addTodoText');
	const prioritySelect = document.getElementById("selectPriority");
    const text = input.value.trim();
	const priority=prioritySelect.value;

    if (text === '') {
        alert('할 일을 입력하세요.');
        return;
    }

    const todoList = document.getElementById('todo-list');
    const addId = Date.now(); // 현재 시간 기반 고유 ID 생성

    const li = document.createElement('li');
    li.id = 'todo-' + addId;
    li.setAttribute('data-id', addId);
    li.setAttribute('data-completed', 'false');
    li.className = `todo-item ${priority}`;
	
	const checkbox=document.createElement('input');
	checkbox.type='checkbox';
	checkbox.className='checkbox';
	checkbox.onchange = function(e){
		toggleState(addId);
		e.stopPropagation();
	}
	
	const textSpan= document.createElement('span');
	textSpan.textContent=text;
	
	const badge=document.createElement('span');
	badge.className='priority-badge '+ priority;
	badge.textContent=priority==='high' ? '높음' : priority ==='medium' ? '중간' : '낮음';
	
	const deleteBtn =document.createElement('button');
	deleteBtn.textContent='삭제';
	deleteBtn.className='delete-btn';
	deleteBtn.onclick=function(e){
		e.stopPropagation();
		li.remove(e, addId);
	}
	
	li.appendChild(checkbox);
	li.appendChild(textSpan);
	li.appendChild(badge);
	li.appendChild(deleteBtn);
	todoList.appendChild(li);

    input.value = '';
	prioritySelect.value='medium';
    input.focus();
	
	renderFilteredTodos();
}