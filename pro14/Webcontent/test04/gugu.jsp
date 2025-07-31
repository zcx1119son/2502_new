<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구구단 입력</title>
<style>
	.submit{
		background-color: white;
		border: 1px solid #ccc;
	}
</style>
</head>
<body>
	<h1>출력할 구구단의 수를 지정해 주세요.</h1>
	<form method="post" action="guguResult2.jsp">
		출력할 구구단 : <input type="text" name="dan"><br/>
		<input type="submit" class="submit" value="구구단 출력" > 
	</form>
</body>
</html>