<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기업 요청 목록</title>
    <style>
        body {
            font-family: 'Apple SD Gothic Neo', sans-serif;
            margin: 0;
            padding: 20px;
            padding-top: 100px; /* 헤더 높이만큼 여백 */
            background-color: #f0f2f5;
            color: #333;
        }

        .main-content {
            width: 90%;
            max-width: 1200px;
            margin: 18px auto 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            box-sizing: border-box;
            position: relative;
            z-index: 5;
        }

        .search-and-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding: 10px 0;
        }

        #searchForm {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-grow: 1;
            padding: 0;
            margin: 0;
            border: none;
            background-color: transparent;
            box-shadow: none;
        }

        #searchForm input[type="text"],
        #searchForm select {
            padding: 9px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 0.95em;
            color: #333;
        }

        #searchForm input[type="text"] {
            width: 200px;
        }

        #searchForm select {
            width: 120px;
            appearance: none;
            /* Base64 SVG 이미지를 기존 경로 방식으로 변경 */
            background-image: url('${pageContext.request.contextPath}/resources/images/arrow_down.svg');
            background-repeat: no-repeat;
            background-position: right 8px top 50%;
            background-size: 12px auto;
            padding-right: 25px;
        }

        #searchForm button {
            padding: 9px 20px;
            border: none;
            border-radius: 4px;
            background-color: #4472C4;
            color: white;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        #searchForm button:hover {
            background-color: #365F91;
        }

        .action-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        .action-buttons button {
            padding: 8px 18px;
            border: none;
            border-radius: 5px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            white-space: nowrap;
        }

        /* 액션 버튼들의 개별 스타일 (action-buttons 내부에서 정의된 것을 분리) */
        #approveButton:not(:disabled) {
            background-color: #28a745;
        }

        #approveButton:not(:disabled):hover {
            background-color: #218838;
        }

        /* request_list.jsp에는 updateButton이 없으므로, 해당 스타일은 제거하거나 필요한 경우 다른 파일로 이동 */
        /*
        #updateButton:not(:disabled) {
            background-color: #ffc107;
            color: #333;
        }

        #updateButton:not(:disabled):hover {
            background-color: #e0a800;
        }
        */

        #deleteButton:not(:disabled) {
            background-color: #dc3545;
        }

        #deleteButton:not(:disabled):hover {
            background-color: #c82333;
        }

        .action-buttons button:disabled {
            background-color: #cccccc !important;
            color: #666 !important;
            cursor: not-allowed;
            box-shadow: none;
        }

        .status-buttons {
            display: flex;
            justify-content: flex-start;
            gap: 5px;
            margin-bottom: 20px;
            padding-left: 0px;
        }

        .status-buttons button {
            padding: 8px 30px;
            border: 1px solid #ddd;
            /* border-bottom: none; 이 부분을 제거하여 모든 탭이 하단 테두리를 가지도록 함 */
            border-radius: 5px 5px 0 0;
            background-color: #f8f8f8;
            color: #555;
            cursor: pointer;
            font-size: 0.95em;
            font-weight: normal;
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .status-buttons button:hover {
            background-color: #eee;
            color: #333;
        }

        .status-buttons button.active {
            background-color: #4472C4;
            color: white;
            border-color: #4472C4;
            border-bottom: 2px solid #4472C4;
            font-weight: bold;
            z-index: 2;
            position: relative;
            margin-bottom: -1px;
        }

        table {
            width: 100%;
            margin: 0 auto 20px auto;
            border-collapse: collapse;
            border: 1px solid #e0e0e0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        table th, table td {
            border: 1px solid #e0e0e0;
            padding: 12px 8px;
            text-align: center;
            vertical-align: middle;
            font-size: 0.9em;
        }

        table th {
            background-color: #eaf3f7;
            color: #333;
            font-weight: bold;
            white-space: nowrap;
        }

        table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        table tr:hover {
            background-color: #f0f8ff;
        }

        /* request_list.jsp에서는 입력 필드 수정 기능이 없으므로 이 스타일들은 불필요 */
        /*
        table td input[type="number"],
        table td input[type="text"] {
            width: calc(100% - 10px);
            padding: 6px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
            font-size: 0.9em;
            text-align: center;
            background-color: #e9ecef;
        }
        table td input:not([readonly]) {
            background-color: white;
            border-color: #4472C4;
        }
        table td input[readonly] {
            color: #666;
            background-color: #e9ecef;
        }
        */

        .pagination {
            text-align: center;
            margin-top: 25px;
            margin-bottom: 20px;
        }

        .pagination a, .pagination strong {
            display: inline-block;
            padding: 8px 16px;
            text-decoration: none;
            color: #4472C4;
            border: 1px solid #c0c0c0;
            border-radius: 4px;
            margin: 0 4px;
            transition: all 0.3s ease;
        }

        .pagination a:hover {
            background-color: #eaf3f7;
            border-color: #4472C4;
        }

        .pagination strong {
            background-color: #4472C4;
            color: white;
            border: 1px solid #4472C4;
            font-weight: bold;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/headermaster.jsp" %>

<div class="main-content">
    <div class="search-and-actions">
        <form method="get" action="${contextPath}/master/request_list.do" id="searchForm">
            <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">
            <select name="searchField">
                <option value="companyCode" ${param.searchField == 'companyCode' ? 'selected' : ''}>회사코드</option>
                <option value="companyName" ${param.searchField == 'companyName' ? 'selected' : ''}>회사이름</option>
                <option value="companyOwnername" ${param.searchField == 'companyOwnername' ? 'selected' : ''}>등록 담당자</option>
            </select>
            <button type="submit">검색</button>
        </form>

        <div class="action-buttons">
            <button type="button" id="approveButton" disabled>승인</button>
            <button type="button" id="deleteButton" disabled>삭제</button>
        </div>
    </div>

    <div class="status-buttons">
        <button class="active">요청</button>
        <button onclick="location.href='${contextPath}/master/approved_list.do'">기업 현황</button>
    </div>

    <form id="requestForm" method="post">
        <table>
            <tr>
                <th><input type="checkbox" id="selectAll" /></th>
                <th>등록날짜</th>
                <th>회사코드</th>
                <th>회사이름</th>
                <th>회사 이메일</th>
                <th>등록 담당자</th>
            </tr>
            <c:choose>
                <c:when test="${empty requestList}">
                    <tr>
                        <td colspan="6"><b><span style="font-size:9pt;">등록된 기업 요청 데이터가 없습니다.</span></b></td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="company" items="${requestList}">
                        <tr data-company-code="${company.companyCode}">
                            <td><input type="checkbox" name="selected" value="${company.companyCode}" /></td>
                            <td><fmt:formatDate value="${company.createdDate}" pattern="yyyy-MM-dd" /></td>
                            <td>${company.companyCode}</td>
                            <td>${company.companyName}</td>
                            <td>${company.companyEmail}</td>
                            <td>${company.companyOwnername}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </table>
    </form>

    <div class="pagination">
        <c:if test="${totalPage > 0}">
            <c:if test="${page > 1}">
                <a href="javascript:goToPage(${page -1})">이전</a>
            </c:if>
            <c:forEach begin="1" end="${totalPage}" var="p">
                <c:choose>
                    <c:when test="${p == page}">
                        <strong>[${p}]</strong>
                    </c:when>
                    <c:otherwise>
                        <a href="javascript:goToPage(${p})">[${p}]</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <c:if test="${page < totalPage}">
                <a href="javascript:goToPage(${page + 1})">다음</a>
            </c:if>
        </c:if>
    </div>
</div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script>
    const contextPath = "${pageContext.request.contextPath}";

    // originalValues는 이 페이지에서 사용되지 않으므로 제거합니다.
    // const originalValues = {};

    document.addEventListener('DOMContentLoaded', function () {
        const checkboxes = document.querySelectorAll('input[name="selected"]');
        const selectAllCheckbox = document.getElementById('selectAll');
        const approveButton = document.getElementById('approveButton');
        const deleteButton = document.getElementById('deleteButton');
        const requestForm = document.getElementById("requestForm"); // requestForm 요소를 DOMContentLoaded 내에서 가져옴

        // 개별 체크박스 변경 시 `updateButtonStates` 호출
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function(){
                updateButtonStates();
            });
        });

        // 전체 선택 체크박스 변경 시 `toggleAll` 호출
        if (selectAllCheckbox) {
            selectAllCheckbox.addEventListener('change', function () {
                toggleAll(this);
            });
        }

        // 각 버튼에 클릭 이벤트 리스너 추가
        if (approveButton) {
            approveButton.addEventListener('click', approveSelected);
        }

        if (deleteButton) {
            deleteButton.addEventListener('click', deleteSelected);
        }

        // 페이지 로드 시 버튼 초기 상태 설정
        updateButtonStates();

        // 전체 선택/해제 토글 함수
        function toggleAll(source) {
            checkboxes.forEach(checkbox => { // 상위 스코프의 checkboxes 변수 사용
                checkbox.checked = source.checked;
            });
            updateButtonStates(); // 전체 선택/해제 후 버튼 상태 업데이트
        }

        // 승인/삭제 버튼 활성화/비활성화
        function updateButtonStates() {
            const checkedCount = document.querySelectorAll('input[name="selected"]:checked').length;
            approveButton.disabled = checkedCount === 0; // DOMContentLoaded 스코프의 approveButton 사용
            deleteButton.disabled = checkedCount === 0;   // DOMContentLoaded 스코프의 deleteButton 사용

            if (selectAllCheckbox) {
                const totalCheckboxes = checkboxes.length; // DOMContentLoaded 스코프의 checkboxes 변수 사용
                selectAllCheckbox.checked = (totalCheckboxes > 0 && checkedCount === totalCheckboxes); // DOMContentLoaded 스코프의 selectAllCheckbox 사용
            }
        }

        // 승인 기능(폼 제출)
        function approveSelected() {
            if (!confirm("선택된 기업 요청 항목들을 '승인' 상태로 변경하시겠습니까?")) return;
            requestForm.action = `${contextPath}/master/approve_requests.do`; // DOMContentLoaded 스코프의 requestForm 사용
            requestForm.submit();
        }

        // 삭제 기능(폼 제출)
        function deleteSelected() {
            if (!confirm("선택된 기업 요청 항목들을 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) return;
            requestForm.action = `${contextPath}/master/delete_requests.do`; // DOMContentLoaded 스코프의 requestForm 사용
            requestForm.submit();
        }

        // 페이지 이동
        // goToPage 함수는 전역에서 호출되므로 DOMContentLoaded 스코프 밖에 두는 것이 일반적입니다.
        // 따라서 이 함수는 아래에 별도로 정의하고, 필요한 변수는 파라미터로 받거나 전역 변수를 사용하도록 합니다.
    }); // DOMContentLoaded 닫는 괄호

    // 페이지 이동 (검색 조건 유지) - 전역 함수
    function goToPage(page) {
        const searchForm = document.getElementById('searchForm');
        const keyword = searchForm.querySelector('input[name="keyword"]').value;
        const searchField = searchForm.querySelector('select[name="searchField"]').value;

        let url = `${contextPath}/master/request_list.do?page=` + page;
        if (searchField && keyword) {
            url += '&searchField=' + encodeURIComponent(searchField);
            url += '&keyword=' + encodeURIComponent(keyword);
        }
        window.location.href = url;
    }
    window.goToPage = goToPage; // 전역에서 접근 가능하도록 설정 (기존과 동일)
</script>
</body>
</html>
