<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  
    isELIgnored="false"
%>

<%@ 
	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  
%>

<% 
	request.setCharacterEncoding("utf-8");
%>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 결과2</title>
<style>
	.submit{
		background-color: white;
		border: 1px solid #ccc;
	}
</style>
</head>
<body>
	<c:if test="${empty param.id}">
    	<p>아이디를 입력하세요.</p>
    	<a href="login.jsp">로그인창</a>
	</c:if>
	<c:if test="${not empty param.id}">
		<c:if test="${param.id == 'djawjdals'}">
			<h1>관리자가 로그인 했습니다.</h1>
			<form>
				<input type="button" value="회원정보 삭제하기" class="submit"/>
				<input type="button" value="회원정보 수정하기" class="submit"/>
			</form>
		</c:if>
		<c:if test="${param.id != 'djawjdals'}">
    		<h1>환영합니다. <c:out value="${param.id}" />님!!!</h1>
    	</c:if>
	</c:if>
</body>
</html>