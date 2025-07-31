<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
%> 

<!DOCTYPE html>
<html>
<head>
<meta  charset="UTF-8">
<title>include2.jsp</title>
</head>
<body>
  안녕하세요. 유월이 JSP 시작입니다!!! 
<br>
<jsp:include page="main_dish_image.jsp" flush="ture">
	<jsp:param name="name" value="후디"/>
	<jsp:param name="imgName" value="hoodi.png"/>
</jsp:include>
<br>
  안녕하세요. 유월이 JSP 끝 부분입니다.!!! 
</body>
</html>