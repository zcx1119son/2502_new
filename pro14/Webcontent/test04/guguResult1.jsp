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
<title>구구단 결과1</title>
<style>
	* {
        margin: 0; 
        padding: 0;
        box-sizing: border-box;
    }
    body {
        padding: 20px;
    }
	table{
		width:800px;
		text-align:center;
		margin: 0 auto;
	}
	tr:first-child{
		background-color:#a8f1e6;
	}
	table, td, tr, th{
		border:1px double black;
	}
	td{
		width:50%;
	}
</style>
</head>
<body>
	<c:set var="dan" value="${param.dan}"/>
		<table>
			<tr> 
				<th colspan='2'>
					<c:out value="${dan}"/>단 출력
				</th>
			</tr>
			<c:forEach var="i" begin="1" end="9" step="1">
				<tr>
					<td>
						<c:out value="${dan}"/> * <c:out value="${i}"/>
					</td>
					<td>
						<c:out value="${i*dan}"/>
					</td>
				</tr>	
			</c:forEach>
	</table>
</body>
</html>
			