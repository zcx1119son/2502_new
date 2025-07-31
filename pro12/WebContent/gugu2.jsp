<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int dan=Integer.parseInt(request.getParameter("dan"));
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구구단</title>
<style>
	table{
		width:800px;
		text-align:center;
	}
	tr:first-child{
		background-color:yellow;
	}
	table, td, tr, th{
		border:1px double black;
	}
	td{
		width:50%;
	}
	.odd-row{
		background-color:#8cf3f5;
	}
	.even-row{
		background-color:#b2c2c2;
	}
</style>
</head>
<body>
	<table>
		<tr> 
			<th colspan='2'><%= dan %>단 출력</th>
		</tr>
<% 
	for(int i=1; i<=9; i++){
		String rowClass=(i%2==1)?"odd-row":"even-row";
%>
	<tr class="<%=rowClass%>">
		<td><%=dan %>*<%=i %></td>
		<td><%=dan*i %></td>
	</tr>		
<%
	}
%>
	</table>
</body>
</html>