<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  	request.setCharacterEncoding("utf-8");
	request.setAttribute("id","request dooly");
	request.setAttribute("pwd", "1212");
	request.setAttribute("name", "session 둘리");
	request.setAttribute("email","application dooly@test.com");
%>    

<html>
<head>
<meta  charset=”UTF-8">
<title>forward1</title>
</head>
<body>
   <jsp:forward page="member1.jsp"></jsp:forward>
</html>