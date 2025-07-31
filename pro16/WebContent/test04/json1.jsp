<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSON의 자료형 사용 실습1</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(function(){
		$("#checkJson").click(function(){
			// JSON 문법 수정 (속성명 뒤 콜론, 배열 표기 제대로)
			var jsonStr = '{"name": ["홍길동", "이순신", "임꺽정"]}';
			var jsonInfo = JSON.parse(jsonStr);
			var output = "회원 이름<br/>"
			output += "=======<br/>";
			
			for(var i in jsonInfo.name){
				output += jsonInfo.name[i] + "<br/>";
			}
			$("#output").html(output);
		});
	});
</script>
</head>
<body>
	<button id="checkJson">출력</button>
	<div id="output"></div>
</body>
</html>