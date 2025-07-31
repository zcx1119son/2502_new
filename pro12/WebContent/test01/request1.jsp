<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="jakarta.servlet.RequestDispatcher"
    pageEncoding="UTF-8"
%>
<%
	request.setAttribute("name","둘리");
	request.setAttribute("address", "부천시 원마구");
%>       

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>첫 번째 JSP</title>
</head>
<body>

<%
    RequestDispatcher dispatch=request.getRequestDispatcher("request2.jsp");
	dispatch.forward(request, response);
%>
</body>
</html>