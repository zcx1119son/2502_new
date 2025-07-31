<%@ page language="java" contentType="text/html; charset=UTF-8" 
    import="java.util.*" 
    pageEncoding="UTF-8"
    isELIgnored="false" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
    request.setCharacterEncoding("UTF-8");

    List<Map<String, Object>> todoList = new ArrayList<>();
    
    Object[][] items = {
        {1,"리액트 공부하기", false, "medium"},
        {2,"useState 이해하기", true, "medium"},
        {3,"투두리스트 만들기", false, "medium"}
    };
    
    for (Object[] row : items) {
        Map<String, Object> item = new HashMap<>();
        item.put("id", row[0]);
        item.put("text", row[1]);
        item.put("state", row[2]);
        item.put("priority", row[3]);
        todoList.add(item);
    }
    
    request.setAttribute("todoList", todoList);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>To Do List</title>
    <link rel="stylesheet" href="./css/todoList.css" />
</head>
<body>
	<div class="todo-app">
		<h1>To Do List</h1>
		<%@ include file="todoForm.jsp" %>
		<%@ include file="todoFilters.jsp" %>
		<%@ include file="todoList.jsp" %>
	</div>
<script src="./js/todoList.js"></script>
<script src="./js/addTodoForm.js"></script>
</body>
</html>
