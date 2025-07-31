<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원 수정창</title>
</head>
<body>
<form method="post" action="${contextPath}/mem4.do?acion=updateMember">
	<h1 class="test_center">회원 정보 수정창</h1>
	<table align="center">
		<tr>
			<td width="200"><p align="right">사용자 아이디</p></td>
			<td width="400"><input type="text" name="id"></td>
		</tr>
		<tr>
			<td width="200"><p align="right">사용자 비밀번호</p></td>
			<td width="400"><input type="password" name="pwd"></td>
		</tr>
		<tr>
			<td width="200"><p align="right">사용자 이름</p></td>
			<td width="400"><input type="text" name="name"></td>
		</tr>
		<tr>
			<td width="200"><p align="right">사용자 이메일</p></td>
			<td width="400"><input type="text" name="email"></td>
		</tr>
	</table>
	<input type="submit" value="수정하기">
</form> 
</body>
</html>