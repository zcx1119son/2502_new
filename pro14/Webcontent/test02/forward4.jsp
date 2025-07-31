<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	request.setAttribute("id", "doner");
	request.setAttribute("pwd", "1234");
	session.setAttribute("name", "도우너");
	application.setAttribute("email", "doner@test.com");
	request.setAttribute("address", "천안시 동남구");
%>    

<html>
<head>
    <meta charset="UTF-8">
    <title>forward4</title>
</head>
<body>
    <jsp:forward page="member4.jsp" />
</body>
</html>
