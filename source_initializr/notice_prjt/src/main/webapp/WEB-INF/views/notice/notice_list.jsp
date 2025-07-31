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
        </style>
        <meta charset="UTF-8">
        <title>공지사항 게시판</title>
    </head>
    <body>
        <table align="center" border="1"  width="80%"  >
            <tr height="10" align="center"  bgcolor="lightgreen">
                <td>번호</td>
                <td>구분</td>
                <td>제목</td>
                <td>등록일</td>
            </tr>
            <c:choose>
                <c:when test="${noticeList ==null }" >
                    <tr  height="10">
                        <td colspan="4">
                            <p align="center">
                                <b><span style="font-size:9pt;">등록된 글이 없습니다.</span></b>
                            </p>
                        </td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="notice" items="${noticeList}">
                        <tr align="center">
                            <td width="10%">${notice.idx}</td>
                            <td width="10%">${notice.category}</td>
                            <td align="left" width="35%" style="padding-left: 20px;">${notice.title}</td>
                            <td width="10%">
                                <fmt:formatDate value="${notice.regdate}" pattern="yyyy-MM-dd"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
    </body>
</html>