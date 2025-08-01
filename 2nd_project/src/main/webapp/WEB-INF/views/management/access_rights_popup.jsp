<%-- access_rights_popup.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>직원 접근 권한 팝업창</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }
        .popup-content { padding: 20px; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); max-width: 600px; margin: 20px auto; }
        h2 { text-align: center; color: #333; margin-bottom: 20px; }
        .employee-selector-area { text-align: center; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .employee-selector-area .employee-tag { display: inline-block; padding: 8px 15px; margin: 5px; border: 1px solid #ddd; border-radius: 20px; background-color: #f0f8ff; cursor: pointer; font-size: 0.9em; color: #555; transition: all 0.2s ease; white-space: nowrap; }
        .employee-selector-area .employee-tag.selected { background-color: #007bff; color: white; border-color: #007bff; box-shadow: 0 2px 5px rgba(0, 123, 255, 0.3); font-weight: bold; }
        .current-employee-display { text-align: center; font-size: 1.1em; font-weight: bold; color: #444; margin-bottom: 20px; padding: 10px; background-color: #e9ecef; border-radius: 5px; }
        #accessButtons { text-align: center; margin-bottom: 30px; }
        .access-button { padding: 10px 20px; margin: 5px; border: 1px solid #ccc; border-radius: 5px; cursor: pointer; display: inline-block; min-width: 80px; transition: background-color 0.2s, color 0.2s, border-color 0.2s; }
        .access-button.active { background-color: #007bff; color: white; border-color: #007bff; }
        .access-button.inactive { background-color: #f0f0f0; color: #333; border-color: #ccc; }
        .button-group { text-align: center; margin-top: 30px; }
        .button-group button { padding: 10px 20px; margin: 0 10px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; transition: background-color 0.2s; }
        .button-group .complete-button { background-color: #28a745; color: white; }
        .button-group .complete-button:hover { background-color: #218838; }
        .button-group .cancel-button { background-color: #dc3545; color: white; }
        .button-group .cancel-button:hover { background-color: #c82333; }
    </style>
</head>
<body>
<div class="popup-content">
    <h2>직원 접근 권한 팝업창</h2>

    <div class="employee-selector-area">
        <p>권한을 설정할 직원을 선택하세요:</p>
        <c:choose>
            <c:when test="${not empty selectedEmployeesInfo}">
                <c:forEach var="employee" items="${selectedEmployeesInfo}">
                    <span class="employee-tag" data-id="${employee.id}">${employee.name}</span>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>선택된 직원이 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="current-employee-display">
        현재 선택된 직원: <span id="currentEmployeeName">선택 안 됨</span>
    </div>

    <div id="accessButtons">
        <c:choose>
            <c:when test="${not empty menuList}">
                <c:forEach var="menu" items="${menuList}">
                    <button class="access-button inactive"
                            data-menu-id="${menu.menu_id}">
                        <c:out value="${menu.menu_name}" />
                    </button>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>등록된 메뉴가 없습니다.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="button-group">
        <button class="complete-button">저장 및 닫기</button>
        <button class="cancel-button">취소</button>
    </div>
</div>

<script>
$(document).ready(function() {
    let currentSelectedManagementId = null;
    const employeeAccessRightsMap = new Map();

    function updateButtonStates(menuIdSet) {
        $('.access-button').each(function() {
            const menuId = String($(this).data('menu-id'));
            if (menuIdSet.has(menuId)) {
                $(this).removeClass('inactive').addClass('active');
            } else {
                $(this).removeClass('active').addClass('inactive');
            }
        });
    }

    function loadAccessRightsForEmployee(managementId) {
        $.ajax({
            url: '/management/getAccessRightsStatus.do',
            type: 'GET',
            data: { managementId: managementId },
            dataType: 'json',
            success: function(response) {
                const loadedMenuIds = new Set();
                if (response) {
                    response.forEach(menuId => loadedMenuIds.add(String(menuId)));
                }
                employeeAccessRightsMap.set(managementId, loadedMenuIds);
                updateButtonStates(loadedMenuIds);
            },
            error: function() {
                alert("권한 정보를 불러오는 데 실패했습니다.");
                updateButtonStates(new Set());
            }
        });
    }

    $('.employee-tag').on('click', function() {
        $('.employee-tag').removeClass('selected');
        $(this).addClass('selected');

        currentSelectedManagementId = String($(this).data('id'));
        $('#currentEmployeeName').text($(this).text());

        if (employeeAccessRightsMap.has(currentSelectedManagementId)) {
            updateButtonStates(employeeAccessRightsMap.get(currentSelectedManagementId));
        } else {
            loadAccessRightsForEmployee(currentSelectedManagementId);
        }
    });

    $('#accessButtons').on('click', '.access-button', function() {
        if (!currentSelectedManagementId) {
            alert("먼저 직원을 선택하세요.");
            return;
        }
        const menuId = String($(this).data('menu-id'));
        const menuSet = employeeAccessRightsMap.get(currentSelectedManagementId) || new Set();

        if ($(this).hasClass('active')) {
            $(this).removeClass('active').addClass('inactive');
            menuSet.delete(menuId);
        } else {
            $(this).removeClass('inactive').addClass('active');
            menuSet.add(menuId);
        }
        employeeAccessRightsMap.set(currentSelectedManagementId, menuSet);
    });

    $('.complete-button').on('click', function() {
        if (employeeAccessRightsMap.size === 0) {
            alert("권한 설정을 먼저 해주세요.");
            return;
        }
        const payload = {};
        employeeAccessRightsMap.forEach((menuSet, id) => {
            payload[id] = Array.from(menuSet);
        });
        $.ajax({
            url: '/management/saveAllAccessRights.do',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(payload),
            success: function(response) {
                if (response.success) {
                    alert("저장 완료");
                    window.close();
                    if (window.opener && !window.opener.closed) {
                        window.opener.location.reload();
                    }
                } else {
                    alert("저장 실패: " + (response.message || ""));
                }
            },
            error: function(xhr) {
                alert("저장 실패: " + xhr.responseText);
            }
        });
    });

    $('.cancel-button').on('click', function() {
        window.close();
    });

    // 첫 직원 자동 선택
    const firstTag = $('.employee-tag').first();
    if (firstTag.length > 0) {
        firstTag.trigger('click');
    } else {
        $('#currentEmployeeName').text("선택할 직원이 없습니다.");
        $('#accessButtons').html('<p style="text-align:center; color:#888;">접근 권한을 설정할 직원이 없습니다.</p>');
    }
});
</script>
</body>
</html>
