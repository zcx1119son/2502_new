<%-- /WEB-INF/views/master/approved_list.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>기업 현황 목록</title>
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
                margin: 18px auto 20px auto; /* 상단 마진을 추가하여 간격 생성 */
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
                background-color: #4472C4; /* 파란색 */
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
            #updateButton:not(:disabled) {
                background-color: #ffc107; /* 주황색 (경고/주의 느낌) */
                color: #333; /* 텍스트 색상 검은색으로 */
            }
            #updateButton:not(:disabled):hover {
                background-color: #e0a800;
            }

            #deleteButton:not(:disabled) {
                background-color: #dc3545; /* 빨간색 */
            }
            #deleteButton:not(:disabled):hover {
                background-color: #c82333;
            }

            /* 모든 버튼에 대한 비활성화 상태 스타일 (가장 높은 우선순위를 위해 !important 사용) */
            .action-buttons button:disabled {
                background-color: #cccccc !important;
                color: #666 !important; /* 비활성화 시 텍스트 색상도 회색으로 */
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
                padding: 8px 30px; /* ★★★ 좌우 패딩을 늘려서 너비 조절 (15px -> 30px) ★★★ */
                border: 1px solid #ddd;
                /* border-bottom: none; 이 부분을 제거하여 모든 탭이 하단 테두리를 가지도록 함 */
                border-radius: 5px 5px 0 0;
                background-color: #f8f8f8;
                color: #555;
                cursor: pointer;
                font-size: 0.95em;
                font-weight: normal;
                transition: all 0.2s ease;
                white-space: nowrap; /* 텍스트가 길 경우 줄바꿈 방지 */
            }
            .status-buttons button:hover {
                background-color: #eee;
                color: #333;
            }
            .status-buttons button.active {
                background-color: #4472C4;
                color: white;
                border-color: #4472C4;
                border-bottom: 2px solid #4472C4; /* 활성 탭 하단 테두리를 두껍고 활성색으로 */
                font-weight: bold;
                z-index: 2;
                position: relative;
                margin-bottom: -1px; /* 아래 테이블 테두리와 겹치도록 음수 마진 */
            }

            /* 테이블 스타일 */
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
            table td input[type="number"],
            table td input[type="text"] {
                width: calc(100% - 10px);
                padding: 6px;
                border: 1px solid #ddd;
                border-radius: 3px;
                box-sizing: border-box;
                font-size: 0.9em;
                text-align: center; /* 입력 필드 텍스트도 중앙 정렬 */
                /* 기본적으로 비활성화된 상태의 배경색 */
                background-color: #e9ecef;
            }
            /* 활성화된 입력 필드에 대한 배경색 */
            table td input:not([readonly]) {
                background-color: white;
                border-color: #4472C4; /* 편집 가능 상태 시 테두리 색상 변경 */
            }

            table td input[readonly] {
                color: #666;
                background-color: #e9ecef;
            }

            /* 페이지네이션 */
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
                      <form method="get" action="${contextPath}/master/approved_list.do" id="searchForm">
                          <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어 입력">
                          <select name="searchField">
                              <option value="companyCode" ${param.searchField == 'companyCode' ? 'selected' : ''}>
                                  회사코드
                              </option>
                              <option value="companyName" ${param.searchField == 'companyName' ? 'selected' : ''}>
                                  회사이름
                              </option>
                              <option value="companyOwnername" ${param.searchField == 'companyOwnername' ? 'selected' : ''}>
                                  등록 담당자
                              </option>
                          </select>
                          <button type="submit">검색</button>
                      </form>

            <div class="action-buttons">
                <button type="button" id="updateButton" disabled> 수정 </button>
                <button type="button" id="deleteButton" disabled> 삭제 </button>
            </div>
        </div>

           <div class="status-buttons">
               <button onclick="location.href='${pageContext.request.contextPath}/master/request_list.do'">요청</button>
               <button class="active">기업 현황</button>
           </div>

        <form id="approvedForm" method="post">
            <table align="center" border="1" width="80%" cellspacing="0" cellpadding="5">
                <tr align="center">
                                       <th>
                                           <input type="checkbox" id="selectAll" />
                                       </th>
                                    <th>등록날짜</th>
                                    <th>회사코드</th>
                                    <th>회사이름</th>
                                    <th>회사 이메일</th>
                                    <th>등록 담당자</th>
                                </tr>
               <c:choose>
                                                   <c:when test="${empty approvedList}">
                                                       <tr>
                                                           <td colspan="6" align="center">
                                                               <b><span style="font-size:9pt;">등록된 기업 현황 데이터가 없습니다.</span></b>
                                                           </td>
                                                       </tr>
                                                   </c:when>
                                                   <c:otherwise>
                                                       <c:forEach var="company" items="${approvedList}">
                                                           <tr align="center" data-company-code="${company.companyCode}">
                                                               <td>
                                                                   <input type="checkbox" name="selected"  value="${company.companyCode}" />
                                                               </td>
                                                               <td>
                                                                   <fmt:formatDate value='${company.createdDate}' pattern='yyyy-MM-dd' />
                                                               </td>
                                                               <td>
                                                                   ${company.companyCode}
                                                               </td>
                                                                <td>
                                                              <input type="text" name="companyName_${company.companyCode}" value="${company.companyName}" readonly/>
                                                          </td>
                                                          <td>
                                                              <input type="text" name="companyEmail_${company.companyCode}" value="${company.companyEmail}" readonly/>
                                                          </td>
                                                          <td>
                                                              <input type="text" name="companyOwnername_${company.companyCode}" value="${company.companyOwnername}" readonly/>
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
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
     <script>
            const contextPath = "${pageContext.request.contextPath}";

            const originalValues={}; // originalValues는 필요하므로 유지

            document.addEventListener('DOMContentLoaded', function() {
                const checkboxes = document.querySelectorAll('input[name="selected"]');
                const selectAllCheckbox = document.getElementById('selectAll');
                const updateButton = document.getElementById('updateButton');
                const deleteButton = document.getElementById('deleteButton');
                const approvedForm = document.getElementById("approvedForm"); // form 요소 가져오기

                // 초기 로드시 입력 필드 readonly 설정 및 원본 값 저장
                document.querySelectorAll("tr[data-company-code]").forEach(row => {
                    const companyId = row.getAttribute('data-company-code');
                    // 템플릿 리터럴 사용으로 변경: `input[name="companyName_${companyId}"]`
                    const companyNameInput = row.querySelector(`input[name="companyName_${companyId}"]`);
                    const companyEmailInput = row.querySelector(`input[name="companyEmail_${companyId}"]`);
                    const companyOwnernameInput = row.querySelector(`input[name="companyOwnername_${companyId}"]`);

                    // originalValues 객체에 원본 값 저장
                    originalValues[companyId] = {
                        companyName: companyNameInput ? companyNameInput.value : '',
                        companyEmail: companyEmailInput ? companyEmailInput.value : '',
                        companyOwnername: companyOwnernameInput ? companyOwnernameInput.value : ''
                    };

                    // 초기에는 모든 해당 입력 필드를 비활성화(readonly 속성 추가)
                    if (companyNameInput) {companyNameInput.setAttribute('readonly', 'readonly');}
                    if (companyEmailInput) {companyEmailInput.setAttribute('readonly', 'readonly');}
                    if (companyOwnernameInput) {companyOwnernameInput.setAttribute('readonly', 'readonly');}
                });

                // 개별 체크박스에 이벤트 리스너 추가
               checkboxes.forEach(checkbox => {
                   checkbox.addEventListener('change', function() {
                       toggleEdit(this);
                       updateButtonStates();
                   });
               });

                if (selectAllCheckbox) {
                    selectAllCheckbox.addEventListener('change', function() {
                       toggleAll(this);
                    });
                }

                // 수정/삭제 버튼에 클릭 이벤트 리스너 추가
                if (updateButton) {
                    updateButton.addEventListener('click', updateSelected);
                }
                if (deleteButton) {
                    deleteButton.addEventListener('click', deleteSelected);
                }

                // 페이지 로드 시 버튼 초기 상태 설정
                updateButtonStates();


                // --- DOMContentLoaded 내부에서 정의된 함수들 ---

                function toggleEdit(checkbox){
                    const row = checkbox.closest("tr");
                    const companyId = row.getAttribute("data-company-code");

                    ["companyName", "companyEmail", "companyOwnername"].forEach(field =>{

                        const input = row.querySelector('input[name="'+field+'_'+companyId +'"]');
                        if(input){
                             if (checkbox.checked) {
                                                input.removeAttribute('readonly');
                                            } else {
                                                if (originalValues[companyId] && originalValues[companyId][field] !== undefined) {
                                                    input.value = originalValues[companyId][field];
                                                }
                                                input.setAttribute('readonly', 'readonly');
                                            }
                        }
                    });
                }

                // 전체 선택/해제 토글
                function toggleAll(source) {
                   const checkboxes = document.querySelectorAll('input[name="selected"]'); // DOMContentLoaded 내부에서 다시 쿼리
                   checkboxes.forEach(checkbox => {
                       checkbox.checked = source.checked;
                       toggleEdit(checkbox); // 각 체크박스에 따라 입력 필드 상태 변경
                   });
                   updateButtonStates(); // 전체 선택/해제 후 버튼 상태 업데이트
               }

                function updateButtonStates() {
                    // 개별 데이터 행의 체크박스 중 체크된 개수
                    const checkedCount = document.querySelectorAll('input[name="selected"]:checked').length;
                    const updateButton = document.ElementById('updateButton');
                    const deleteButton = document.ElementById('deleteButton');

                    if (updateButton) {
                        updateButton.disabled = (checkedCount === 0);
                    }
                    if (deleteButton) {
                        deleteButton.disabled = (checkedCount === 0);
                    }

                    // 전체 선택 체크박스 상태 업데이트
                    const selectAllCheckbox = document.getElementById('selectAll'); // DOMContentLoaded 내부에서 다시 쿼리
                    const totalCheckboxes = document.querySelectorAll('input[name="selected"]').length;

                    if (selectAllCheckbox) {
                        selectAllCheckbox.checked = (totalCheckboxes > 0 && checkedCount === totalCheckboxes);
                    }
                }

                 function updateSelected() {
                        const checkedBoxes = document.querySelectorAll('input[name="selected"]:checked');
                        if (checkedBoxes.length === 0) {
                            alert("수정할 항목을 선택하세요.");
                            return;
                        }
                        // 단일 선택만 허용하는 경우
                        if (checkedBoxes.length > 1) {
                             alert("수정할 항목은 하나만 선택해주세요.");
                             return;
                        }

                        if (!confirm("선택된 기업 항목들을 수정하시겠습니까?")) { // 메시지 수정
                            return;
                        }

                        // DOMContentLoaded 스코프의 approvedForm 사용
                        approvedForm.action = `${contextPath}/master/update_companies.do`;
                        approvedForm.submit();
                }

                function deleteSelected() {
                   const checkedBoxes = document.querySelectorAll("input[name='selected']:checked");
                   if (checkedBoxes.length === 0) {
                       alert("삭제할 항목을 선택하세요.");
                       return;
                   }
                   if (!confirm("선택된 기업 항목들을 정말 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.")) { // 메시지 수정
                       return;
                   }
                   // DOMContentLoaded 스코프의 approvedForm 사용
                   approvedForm.action = `${contextPath}/master/delete_requests.do`;
                   approvedForm.submit();
                }

            }); // DOMContentLoaded 닫는 괄호

            // 페이지 이동 (검색 조건 유지) - 전역 함수로 유지
            function goToPage(page) {
                const searchForm = document.getElementById('searchForm');
                const keyword = searchForm.querySelector('input[name="keyword"]').value;
                const searchField = searchForm.querySelector('select[name="searchField"]').value;

                let url = `${contextPath}/master/approved_list.do?page=` + page;
                if (searchField && keyword) {
                    url += '&searchField=' + encodeURIComponent(searchField);
                    url += '&keyword=' + encodeURIComponent(keyword);
                }
                window.location.href = url;
            }
            window.goToPage = goToPage; // 전역에서 접근 가능하도록 설정
        </script>
</body>
</html>
