<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>직원 추가</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { width: 500px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #f2f2f2; }
        input[type="text"], input[type="email"], input[type="date"], select {
            width: calc(100% - 22px);
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .button-group { text-align: center; margin-top: 20px; }
        .button-group button {
            padding: 10px 20px;
            margin: 0 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .button-group button.submit { background-color: #4CAF50; color: white; }
        .button-group button.cancel { background-color: #f44336; color: white; }
        .error-message { color: red; font-size: 0.9em; margin-top: 5px; }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#insertForm').submit(function(event) {
                // 기존 폼 제출 동작 방지
                event.preventDefault();

                // 폼 데이터 직렬화
                var formData = $(this).serialize();

                $.ajax({
                    url: '${pageContext.request.contextPath}/management/insert.do',
                    type: 'POST',
                    data: formData,
                    dataType: 'json', // 서버가 JSON을 반환할 것임을 명시
                    success: function(response) {
                        // 서버에서 반환한 JSON 응답 처리
                        alert(response.message); // 서버 메시지 출력

                        if (response.status === "success") {
                            // 성공 시: 부모 창 새로고침 및 팝업 닫기
                            if (window.opener) {
                                window.opener.location.reload(); // 부모 창 새로고침
                            }
                            window.close(); // 팝업 닫기
                        } else {
                            // 'error' 상태인 경우:
                            // 오류 메시지 출력 후, 팝업을 닫고 부모 창을 새로고침하여 로그인 등의 문제에 대응
                            if (window.opener) {
                                window.opener.location.reload(); // 부모 창 새로고침 (선택 사항: 오류 시에도 새로고침)
                            }
                            window.close(); // 팝업 닫기 (선택 사항: 오류 시에도 닫기)
                        }
                    },
                    error: function(xhr, status, error) {
                        // AJAX 에러 발생 시 처리 (네트워크 오류, 서버 500 에러 등)
                        var errorMessage = xhr.responseText || '직원 추가 중 알 수 없는 오류가 발생했습니다.';
                        alert(errorMessage);
                        // 에러 시에도 팝업을 닫고 부모 창을 새로고침할 수 있습니다.
                        if (window.opener) {
                            window.opener.location.reload();
                        }
                        window.close();
                    }
                });
            });

            // 취소 버튼 클릭 시: 부모 창 새로고침 후 팝업 닫기
            $('#cancelBtn').click(function() {
                if (window.opener) {
                    window.opener.location.reload(); // 부모 창 새로고침
                }
                window.close(); // 팝업 닫기
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <h2>새 직원 추가</h2>
        <form id="insertForm" action="${pageContext.request.contextPath}/management/insert.do" method="post">
            <table>
                <tr>
                    <th>사원 코드</th>
                    <td><input type="text" name="employee_Id" required></td>
                </tr>
                <tr>
                    <th>사원명</th>
                    <td><input type="text" name="employee_Name" required></td>
                </tr>
                <tr>
                    <th>사원 전화번호</th>
                    <td><input type="text" name="employee_Phon_Number" required></td>
                </tr>
                <tr>
                    <th>사원 이메일</th>
                    <td><input type="email" name="employee_Email" required></td>
                </tr>
                <tr>
                    <th>부서명</th>
                    <td><input type="text" name="department_Name" required></td>
                </tr>
                <tr>
                    <th>직급</th>
                    <td><input type="text" name="position" required></td>
                </tr>
                <%-- CREATE_DATE, CREATE_ID, UPDATE_DATE, UPDATE_ID, REMARKS는 서버에서 자동으로 처리 --%>
            </table>
            <div class="button-group">
                <button type="submit" class="submit">추가</button>
                <button type="button" class="cancel" id="cancelBtn">취소</button>
            </div>
        </form>
    </div>
</body>
</html>