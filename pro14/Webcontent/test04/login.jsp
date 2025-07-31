<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인창</title>
<style>
	.submit{
		background-color: white;
		border: 1px solid #ccc;
	}
</style>
</head>
<body>
	<form method="post" action="result2.jsp">
		아이디: <input type="text" name="id"><br/>
		비밀번호: <input type="password" name="pwd"><br/>
		<input type="submit" value="로그인" class="submit">
		<input type="reset" value="다시입력" class="submit">		
	</form>
</body>
</html>