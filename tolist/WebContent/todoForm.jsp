<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="add-form">
		<input type="text" id="addTodoText" placeholder="새 할 일 입력"/>
		<select id="selectPriority" class="select">
			<option value="high">높음</option>
	        <option value="medium">중간</option>
	        <option value="low">낮음</option>
	    </select>
	    <button onclick="addTodo()">추가</button>
    </div>
</body>
</html>