<%@ page language="java" contentType="text/html; charset=UTF-8"
     import="java.util.*"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    request.setCharacterEncoding("UTF-8");
%>  

<html>
<head>
<meta charset=”UTF-8">
<title>리다이렉트 페이지</title>
</head>
<body>
<c:redirect url="/test01/member1.jsp">
    <c:param 	name="id" 		value="${'dooly'}"/>
    <c:param  	name="pwd"      value="${'1212'}" />
    <c:param  	name="name"      value="${'둘리'}" />
    <c:param  name="email"     value="${'dooly@test.com'}" />
</c:redirect>
</body>
</html>