<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSON의 자료형 사용 실습2</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function (){
		$("#checkJson").click(function(){
			var jsonStr=
				'{"member":[{"name":"박지성","age":"25", "gender":"남자", "nickname":"날생돌이"}'
				+', {"name":"손흥민", "age":"30", "gender":"남자", "nickname":"탱크"}]}'
		})
	})
</script>
</head>
<body>

</body>
</html>