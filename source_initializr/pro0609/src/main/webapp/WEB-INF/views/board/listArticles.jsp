<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
 <style>
   .cls1 {text-decoration:none;}
   .cls2{text-align:center; font-size:30px;}
  </style>
  <meta charset="UTF-8">
  <title>글목록창</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<table align="center" border="1"  width="80%"  >
  <tr height="10" align="center"  bgcolor="lightgreen">
     <td >글번호</td>
     <td >작성자</td>
     <td >제목</td>
     <td >작성일</td>
  </tr>
<c:choose>
    <c:when test="${articlesList ==null }" >
    <tr  height="10">
        <td colspan="4">
            <p align="center">
            <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
            </p>
        </td>
    </tr>
    </c:when>
    <c:when test="${articlesList !=null }" >
        <c:forEach  var="article" items="${articlesList }" varStatus="articleNum" >
            <tr align="center">
                <td width="5%">${articleNum.count}</td>
                <td width="10%">${article.id }</td>
                <td align='left'  width="35%">
                <span style="padding-right:30px"></span>
                <c:choose>
                    <c:when test='${article.level > 1 }'>
                        <c:forEach begin="1" end="${article.level }" step="1">
                            <span style="padding-left:20px"></span>
                        </c:forEach>
                        <span style="font-size:12px;">[답변]</span>
                        <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title}</a>
                    </c:when>
                    <c:otherwise>
                        <a class='cls1' href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}">${article.title }</a>
                    </c:otherwise>
  	            </c:choose>
  	            </td>
  	            <td  width="10%">${article.writeDate}</td>
  	        </tr>
        </c:forEach>
    </c:when>
</c:choose>
</table>

<br>
<!-- 조회 버튼 추가 -->
<div align="center">
    <button class="btn-search" onclick="fn_searchArticles()">조회</button>
</div>

<table id="searchResultsTable" align="center" border="1" width="80%" style="margin-top:20px">
    <tr height="10" align="center" bgcolor="pink">
        <td>2글번호</td>
        <td>2작성자</td>
        <td>2제목</td>
        <td>2작성일</td>
    </tr>
    <tbody id="searchResultsTbody">
        <!-- ajax 조회 결과 -->
    </tbody>
</table>

<script>
    function fn_searchArticles() {
        alert("콜 했슈");
        $.ajax({
            url: '${contextPath}/board/api/list',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                displaySearchResults(data);
            },
            error: function(xhr, status, error) {
                alert('조회 중 오류가 발생했습니다:'+error);
            }
        });
    }

    function displaySearchResults(articles) {
        var tbody = $('#searchResultsTbody');
        tbody.empty();

        if (articles.length === 0) {
            tbody.append(
                '<tr><td colspan="4" align="center">' +
                '<b><span style="font-size:9pt;">조회된 글이 없습니다</span></b>'+
                '</td></tr>'
            );
        } else {
            for(var i=0; i< articles.length; i++) {
                var article = articles[i];
                var row = '<tr align="center">';
                row += '<td width="5%">'+(i+1) +'</td>';
                row += '<td width="10%">'+ article.id +'</td>';
                row += '<td align="left"><span style="padding-left:20px"></span>'+article.title+'</td>';
                row += '<td width="10%">'+article.writeDate+'</td>';
                row += '</tr>';
                tbody.append(row);
            }
        }

    }

</script>

</body>
</html>