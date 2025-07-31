<%@ page language="java" contentType="text/html; charset=UTF-8" 
    import="java.util.*" 
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	 <ul id="todo-list" class="todo-list" data-filter="all">  
        <c:forEach var="item" items="${todoList}">
        	<%@ include file="todoItem.jspf" %>
        </c:forEach> 
    </ul>
</body>
</html>