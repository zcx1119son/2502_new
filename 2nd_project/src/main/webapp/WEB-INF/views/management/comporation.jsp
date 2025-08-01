<%-- comporation.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>직원 관리 목록</title>
    <style>
        /* 기본 스타일은 여기에 추가하거나, 외부 CSS 파일로 분리하세요. */
        /* 예시: */
        body {
            font-family: 'Malgun Gothic', '맑은 고딕', Dotum, '돋움', sans-serif;
            margin: 0;
            padding: 0;
            padding-top: 80px; /* 헤더 높이만큼 여백 */
            background-color: #f0f2f5;
            color: #333;
        }

        .main-content {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto 20px auto;
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
            background-image: url('${pageContext.request.contextPath}/resources/images/arrow_down.svg'); /* 화살표 아이콘 경로 */
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
        .action-buttons button:nth-of-type(1) { /* 접근 권한 변경 */
            background-color: #007bff;
        }
        .action-buttons button:nth-of-type(1):hover {
            background-color: #0056b3;
        }
        .action-buttons button:nth-of-type(2) { /* 추가 */
            background-color: #28a745;
        }
        .action-buttons button:nth-of-type(2):hover {
            background-color: #218838;
        }
        .action-buttons button:nth-of-type(3) { /* 수정 */
            background-color: #ffc107;
            color: #333;
        }
        .action-buttons button:nth-of-type(3):hover {
            background-color: #e0a800;
        }
        .action-buttons button:nth-of-type(4) { /* 삭제 */
            background-color: #dc3545;
        }
        .action-buttons button:nth-of-type(4):hover {
            background-color: #c82333;
        }
        .action-buttons button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
            box-shadow: none;
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
        table td input[type="text"] {
             width: calc(100% - 10px);
             padding: 6px;
             border: 1px solid #ddd;
             border-radius: 3px;
             box-sizing: border-box;
             font-size: 0.9em;
             text-align: center; /* 입력 필드 텍스트도 중앙 정렬 */
        }
        table td input[readonly] {
            background-color: #e9ecef;
            color: #666;
        }

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
    <%-- 헤더 포함 (경로 확인) --%>
    <%@ include file="/WEB-INF/views/include/headerconporation.jsp" %>

    <div class="main-content">
        <div class="search-and-actions">
            <form method="get" action="${contextPath}/management/management_list.do" id="searchForm">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">
                <select name="searchField">
                    <option value="management_Id" ${param.searchField == 'management_Id' ? 'selected' : ''}>
                        사원코드
                    </option>
                    <option value="employee_Name" ${param.searchField == 'employee_Name' ? 'selected' : ''}>
                        사원명
                    </option>
                    <option value="department_Name" ${param.searchField == 'department_Name' ? 'selected' : ''}>
                        부서명
                    </option>
                    <option value="position" ${param.searchField == 'position' ? 'selected' : ''}>
                        직급
                    </option>
                </select>
                <button type="submit">검색</button>
            </form>

            <div class="action-buttons">
                <button type="button" id="setAccessButton" disabled>접근 권한 변경</button>
                <button type="button" onClick="openAddEmployee()">추가</button>
                <button type="button" id="updateButton" disabled>수정</button>
                <button type="button" id="deleteButton" disabled>삭제</button>
            </div>
        </div>

        <form id="comporationForm" method="post">
            <table align="center" border="1" width="80%" cellspacing="0" cellpadding="5">
                <tr align="center">
                    <th>
                        <input type="checkbox" id="selectAll" />
                    </th>
                    <th>사원코드</th>
                    <th>사원명</th>
                    <th>사원 전화번호</th>
                    <th>사원 이메일</th>
                    <th>부서명</th>
                    <th>직급</th>
                    <th>접근권한</th>
                </tr>
                <c:choose>
                    <c:when test="${empty managementList}">
                        <tr>
                            <td colspan="9" align="center"> <b><span style="font-size:9pt;">등록된 직원 데이터가 없습니다.</span></b>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="comporation" items="${managementList}">
                            <tr align="center" data-staff-id="${comporation.management_Id}">
                                <td>
                                    <input type="checkbox" name="selected" value="${comporation.management_Id}" />
                                </td>
                                <td>
                                    ${comporation.management_Id}
                                </td>
                                <td>
                                    <input type="text" name="employee_Name_${comporation.management_Id}" value="${comporation.employee_Name}" readonly/>
                                </td>
                                <td>
                                    <input type="text" name="employee_Phon_Number_${comporation.management_Id}" value="${comporation.employee_Phon_Number}" readonly/>
                                </td>
                                <td>
                                    <input type="text" name="employee_Email_${comporation.management_Id}" value="${comporation.employee_Email}" readonly/>
                                </td>
                                <td>
                                    <input type="text" name="department_Name_${comporation.management_Id}" value="${comporation.department_Name}" readonly/>
                                </td>
                                <td>
                                    <input type="text" name="position_${comporation.management_Id}" value="${comporation.position}" readonly/>
                                </td>
                                <td>
                                    ${comporation.accessRightsNames}
                                </td>
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
    <%-- 푸터 포함 (경로 확인) --%>
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    <script>
        const contextPath = "${pageContext.request.contextPath}"; // <-- contextPath 설정 방식 변경

        const originalValues = {}; // 초기 로드 시의 원본 값 저장

        // 페이지 로드 시 실행될 초기화 함수
        document.addEventListener('DOMContentLoaded', function(){
            const checkboxes = document.querySelectorAll('input[name="selected"]');
            const selectAllCheckbox = document.getElementById('selectAll');
            const setAccessButton = document.getElementById('setAccessButton'); // 추가된 접근 권한 변경 버튼
            const updateButton = document.getElementById('updateButton');
            const deleteButton = document.getElementById('deleteButton');

            // 초기 로드시 입력 필드 readonly 설정 및 원본 값 저장
            document.querySelectorAll("tr[data-staff-id]").forEach(row => {
                const staffId = row.getAttribute('data-staff-id');
                const employeeNameInput = row.querySelector('input[name="employee_Name_' + staffId +'"]');
                const employeePhonNumberInput = row.querySelector('input[name="employee_Phon_Number_' + staffId +'"]');
                const employeeEmailInput = row.querySelector('input[name="employee_Email_' + staffId +'"]');
                const departmentNameInput = row.querySelector('input[name="department_Name_' + staffId +'"]');
                const positionInput = row.querySelector('input[name="position_' + staffId +'"]');

                // 원본 값 저장
                originalValues[staffId] = {
                    employee_Name : employeeNameInput ? employeeNameInput.value : '',
                    employee_Phon_Number : employeePhonNumberInput ? employeePhonNumberInput.value : '',
                    employee_Email : employeeEmailInput ? employeeEmailInput.value : '',
                    department_Name : departmentNameInput ? departmentNameInput.value : '',
                    position : positionInput ? positionInput.value : ''
                };

                // 초기에는 모든 입력 필드를 비활성화(readonly 속성 추가)
                if (employeeNameInput){employeeNameInput.setAttribute('readonly', 'readonly');}
                if (employeePhonNumberInput){employeePhonNumberInput.setAttribute('readonly', 'readonly');}
                if (employeeEmailInput){employeeEmailInput.setAttribute('readonly', 'readonly');}
                if (departmentNameInput){departmentNameInput.setAttribute('readonly', 'readonly');}
                if (positionInput){positionInput.setAttribute('readonly', 'readonly');}
            });

            // 개별 체크박스 변경 시 `toggleEdit` 호출 및 버튼 상태 업데이트
            checkboxes.forEach(checkbox =>{
                checkbox.addEventListener('change', function(){
                    toggleEdit(this);
                    updateButtonStates();
                });
            });

            // 전체 선택 체크박스 변경 시 `toggleAll` 호출
            if (selectAllCheckbox) {
                selectAllCheckbox.addEventListener('change', function() {
                    toggleAll(this);
                });
            }

            // 각 버튼에 클릭 이벤트 리스너 추가
            if(setAccessButton){
                setAccessButton.addEventListener('click', openAccessRightsPopup);
            }
            if(updateButton){
                updateButton.addEventListener('click', updateSelected);
            }
            if(deleteButton){
                deleteButton.addEventListener('click', deleteSelected);
            }

            // 페이지 로드 시 버튼 초기 상태 설정
            updateButtonStates();

            // 개별 체크박스에 따른 입력 필드 활성화/비활성화 및 값 복원
            function toggleEdit(checkbox){
                const row = checkbox.closest("tr");
                const staffId = row.getAttribute("data-staff-id");

                ["employee_Name", "employee_Phon_Number", "employee_Email", "department_Name", "position"].forEach(field =>{
                    const input = row.querySelector('input[name="' + field + '_' + staffId + '"]');
                    if(input){
                        if(checkbox.checked){
                            // 체크 시: 편집 가능 상태로 변경 (readonly 속성만 제거)
                            input.removeAttribute('readonly');
                        }else{
                            // 체크 해제 시: 원래 값으로 복원하고 다시 읽기 전용 상태로 변경
                            if(originalValues[staffId] && originalValues[staffId][field] !== undefined){
                                input.value = originalValues[staffId][field];
                            }
                            input.setAttribute('readonly', 'readonly');
                        }
                    }
                });
            }

            // 전체 선택/해제 토글 함수
            function toggleAll(source){
                const checkboxes = document.querySelectorAll('input[name="selected"]');
                checkboxes.forEach(checkbox =>{
                    checkbox.checked = source.checked;
                    toggleEdit(checkbox); // 각 체크박스 상태에 따라 입력 필드 상태 업데이트
                });
                updateButtonStates();
            }

            // 수정/삭제 버튼 활성화/비활성화 로직
            function updateButtonStates(){
                const checkedCount = document.querySelectorAll('input[name="selected"]:checked').length;
                const setAccessButton = document.getElementById('setAccessButton');
                const updateButton = document.getElementById('updateButton');
                const deleteButton = document.getElementById('deleteButton');

                // 체크된 항목이 있으면 버튼 활성화, 없으면 비활성화
                if(setAccessButton) setAccessButton.disabled = checkedCount === 0;
                if(updateButton) updateButton.disabled = checkedCount === 0;
                if(deleteButton) deleteButton.disabled = checkedCount === 0;

                // 전체 선택 체크박스 상태도 업데이트
                const selectAllCheckbox = document.getElementById('selectAll');
                const totalCheckboxes = document.querySelectorAll('input[name="selected"]').length;
                if(selectAllCheckbox){
                    // 테이블에 항목이 하나도 없을 경우 (totalCheckboxes가 0일 때) selectAllCheckbox는 체크되지 않도록 방지
                    selectAllCheckbox.checked = (totalCheckboxes > 0 && checkedCount === totalCheckboxes);
                }
            }

            // 선택된 항목 수정 기능(폼 제출)
            function updateSelected(){
                const checkboxes = document.querySelectorAll("input[name='selected']:checked");
                if(checkboxes.length === 0){
                    alert("수정할 항목을 선택하세요.");
                    return;
                }
                if(!confirm("선택된 직원 항목들을 수정하시겠습니까?")) {
                    return;
                }

                const form = document.getElementById("comporationForm");
                form.action = `${contextPath}/management/update_selected.do`;
                form.submit();
            }

            // 선택된 항목 삭제 기능(폼 제출)
            function deleteSelected(){
                const checkboxes = document.querySelectorAll("input[name='selected']:checked");
                if(checkboxes.length === 0){
                    alert("삭제할 항목을 선택하세요.");
                    return;
                }
                if (!confirm("선택된 직원 항목들을 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) {
                    return;
                }

                const form = document.getElementById("comporationForm");
                form.action = `${contextPath}/management/delete_selected.do`;
                form.submit();
            }
        }); // DOMContentLoaded end

        // 새 직원 추가 팝업 열기 (DOMContentLoaded 밖으로 이동)
        function openAddEmployee() {
            const width = 700;
            const height = 650;
            const left = (screen.width - width) / 2;
            const top = (screen.height - height) / 2;
            window.open(
                `${contextPath}/management/add_employee.do`,
                    'addEmployeePopup',
                    `width=${width},height=${height},top=${top},left=${left},resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no,status=no`
                );
        }

        // 페이지 이동 (검색 조건 유지) (DOMContentLoaded 밖으로 이동)
        function goToPage(page){
            const searchForm = document.getElementById('searchForm');
            const keyword = searchForm.querySelector('input[name="keyword"]').value;
            const searchField = searchForm.querySelector('select[name="searchField"]').value;

            let url = `${contextPath}/management/management_list.do?page=` + page;
            if(searchField && keyword){
                url += '&searchField=' + encodeURIComponent(searchField);
                url += '&keyword=' + encodeURIComponent(keyword);
            }
            window.location.href = url;
        }

        // 접근 권한 팝업 열기 함수 (수정됨)
        function openAccessRightsPopup() {
            const selectedCheckboxes = document.querySelectorAll('input[name="selected"]:checked'); // <-- name="selected"
            const selectedManagementIds = Array.from(selectedCheckboxes).map(cb => cb.value);

            if (selectedManagementIds.length === 0) {
                alert("접근 권한을 변경할 직원을 한 명 이상 선택해주세요.");
                return;
            }

            // 팝업창 열기
            const popupUrl = `${contextPath}/management/accessRightsPopup.do?managementIds=` + selectedManagementIds.join(',');
            const popupName = 'accessRightsPopup';
            const popupOptions = 'width=650,height=600,scrollbars=yes,resizable=yes'; // 팝업 크기 조정

            window.open(popupUrl, popupName, popupOptions);
        }
    </script>
</body>
</html>