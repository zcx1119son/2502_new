<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nextrozi - 메인</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style>
        body {
            font-family: 'Apple SD Gothic Neo', sans-serif;
            background-color: #f7f7fb;
            margin: 0;
            padding: 40px;
        }
        .header {
            background-color: #000;
            color: #fff;
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .header .menu a {
            color: #fff;
            text-decoration: none;
            margin-left: 20px;
        }
        .container {
            margin-top: 60px;
            padding: 40px;
        }
        .search-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
        }
        .search-area div {
            display: flex;
            align-items: center;
        }
        .search-area input[type="text"],
        .search-area select {
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            margin-right: 5px;
        }

        .search-area button {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 5px;
            font-weight: bold;
            background-color: #007bff;
            color: white;
        }

        .search-area button:hover {
            opacity: 0.9;
        }

        .table-container {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #dee2e6;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #e9ecef;
            font-weight: bold;
            white-space: nowrap;
        }
        table tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        table input[type="checkbox"] {
            margin: 0;
        }

        .pagination {
            text-align: center;
            margin-top: 20px;
        }
        .pagination a {
            display: inline-block;
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #dee2e6;
            text-decoration: none;
            color: #007bff;
            border-radius: 4px;
        }
        .pagination a.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        .pagination a:hover:not(.active) {
            background-color: #e9ecef;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 70%;
            max-width: 800px;
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
            animation-name: animatetop;
            animation-duration: 0.4s;
            position: relative;
            border-radius: 8px;
        }
        .close-button {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            position: absolute;
            top: 10px;
            right: 20px;
        }
        .close-button:hover,
        .close-button:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
        .modal-content h2 {
            margin-top: 0;
            font-size: 20px;
            color: #495057;
            margin-bottom: 20px;
        }
        .modal-content label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #495057;
        }
        .modal-content input[type="text"],
        .modal-content input[type="number"],
        .modal-content select {
            width: calc(100% - 20px);
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        .modal-content button {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-left: 5px;
            font-weight: bold;
        }
        .modal-content button.submit-button {
            background-color: #007bff;
            color: white;
        }
        .modal-content button.update-button {
            background-color: #007bff;
            color: white;
        }
        .modal-content button.cancel-button {
            background-color: #6c757d;
            color: white;
        }
        .modal-content button:hover {
            opacity: 0.9;
        }
        .action-button {
            padding: 5px 10px;
            background-color: #6c757d;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            font-weight: bold;
            white-space: nowrap;
        }
        .action-button:hover {
            background-color: #5a6268;
        }

        .status-buttons button {
            padding: 8px 15px;
            border: 1px solid #007bff;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 5px;
            font-weight: bold;
            background-color: white;
            color: #007bff;
        }

        .status-buttons button.active {
            background-color: #007bff;
            background-color: #007bff;
            color: white;
        }

        .status-buttons button:hover:not(.active) {
            background-color: #e9ecef;
        }

        @-webkit-keyframes animatetop {
            from {top: -300px; opacity: 0}
            to {top: 0; opacity: 1}
        }
        @keyframes animatetop {
            from {top: -300px; opacity: 0}
            to {top: 0; opacity: 1}
        }
    </style>
</head>
<body>

    <%@ include file="/WEB-INF/views/include/header.jsp" %>

    <div class="container">
        <div class="search-area">
            <div>
                <select id="searchType">
                    <option value="product_name">품목명</option>
                    <option value="client_name">거래처명</option>
                    <option value="member_name">담당자</option>
                </select>
                <input type="text" id="searchKeyword" placeholder="검색어 입력">
                <button onclick="searchPurchases()">조회</button>
            </div>
            <div>
                <button onclick="openModal('insert')" class="submit-button">추가</button>
                <div>
                <button class="btn-danger" id="deleteSelectedBtn">삭제</button>
                </div>
            </div>
        </div>

        <div class="status-buttons" style="margin-bottom: 20px;">
            <button class="active" onclick="filterByStatus(null)">전체</button>
            <button onclick="filterByStatus(0)">출고전</button>
            <button onclick="filterByStatus(1)">출고 완료</button>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th><input type="checkbox"></th>
                        <th>등록일</th>
                        <th>회사코드</th>
                        <th>거래처명</th>
                        <th>품목코드</th>
                        <th>품목명</th>
                        <th>수량</th>
                        <th>상태</th>
                        <th>담당자</th>
                        <th>수정</th>
                    </tr>
                </thead>
                <tbody id="purchaseTableBody">
                </tbody>
            </table>
        </div>

        <div class="pagination" id="pagination"></div>
    </div>

    <div id="purchaseModal" class="modal">
        <div class="modal-content">
            <span class="close-button" onclick="closeModal()">&times;</span>
            <h2 id="modalTitle">출고 정보 입력</h2>
            <form id="purchaseForm">
                <input type="hidden" id="modal_purchase_id" name="purchase_id">

                <label for="modal_product_name">품목 이름:</label>
                <input type="text" id="modal_product_name" name="product_name" required>

                <label for="modal_client_name">거래처 이름:</label>
                <input type="text" id="modal_client_name" name="client_name" required>

                <label for="modal_member_name">담당자 이름:</label>
                <input type="text" id="modal_member_name" name="member_name" required>

                <label for="modal_shpping_count">수량:</label>
                <input type="number" id="modal_shpping_count" name="shpping_count" required>

                <label for="modal_purchase_status">상태:</label>
                <select id="modal_purchase_status" name="purchase_status">
                    <option value="0">출고전</option>
                    <option value="1">출고 완료</option>
                </select>

                <button type="button" id="submitModalButton" onclick="submitPurchase()" class="submit-button">저장</button>
            </form>
        </div>
    </div>

    <script>
        var getListUrl = '/purchase/list.do';
        var insertUrl = '/purchase/insert.do';
        var updateUrl = '/purchase/update.do';

        var currentModalMode = 'insert';
        var currentPage = 1;
        var pageSize = 10; // Number of items per page
        var currentpurchaseStatus = null; // null for '전체', 0 for '출고전', 1 for '출고 완료'
        var currentSearchType = '';
        var currentSearchKeyword = '';

        $(document).ready(function() {
            loadPurchaseList();
        });

        function loadPurchaseList() {
            var params = {
                page: currentPage,
                pageSize: pageSize,
                purchaseStatus: currentpurchaseStatus,
                searchType: currentSearchType,
                searchKeyword: currentSearchKeyword
            };

            $.ajax({
                url: getListUrl,
                type: 'GET',
                dataType: 'json',
                data: params,
                success: function(response) {
                    var data = response.list;
                    var totalCount = response.totalCount;
                    var currentPage = response.currentPage;
                    var pageSize = response.pageSize;

                    $('#purchaseTableBody').empty();
                    if (data && data.length > 0) {
                        $.each(data, function(index, item) {
                            var statusText = item.purchase_status === 0 ? '출고전' : '출고완료';
                            var createdDate = item.created_date ? new Date(item.created_date).toISOString().slice(0, 10) : '';

                            var itemData = JSON.stringify(item);

                            var row = '<tr>' +
                                '<td><input type="checkbox"></td>' +
                                '<td>' + createdDate + '</td>' +
                                '<td>' + (item.client_id || '') + '</td>' +
                                '<td>' + (item.client_name || '') + '</td>' +
                                '<td>' + (item.product_id || '') + '</td>' +
                                '<td>' + (item.product_name || '') + '</td>' +
                                '<td>' + (item.shpping_count || '') + '</td>' +
                                '<td>' + statusText + '</td>' +
                                '<td>' + (item.member_name || '') + '</td>' +
                                '<td><button class="action-button" onclick="openModal(\'update\', ' + item.purchase_id + ', \'' + encodeURIComponent(itemData) + '\')">수정</button></td>' +
                                '</tr>';
                            $('#purchaseTableBody').append(row);
                        });
                    } else {
                        $('#purchaseTableBody').append('<tr><td colspan="10" style="text-align: center;">데이터가 없습니다.</td></tr>');
                    }
                    renderPagination(totalCount, currentPage, pageSize);
                },
                error: function(xhr, status, error) {
                    console.error("Error loading purchase list: ", status, error);
                    alert("데이터 로드 중 오류가 발생했습니다.");
                }
            });
        }

        function renderPagination(totalCount, currentPage, pageSize) {
            var totalPages = Math.ceil(totalCount / pageSize);
            var paginationHtml = '';
            var pageGroupSize = 5; // Number of page links to show at once
            var startPage = Math.floor((currentPage - 1) / pageGroupSize) * pageGroupSize + 1;
            var endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

            if (totalPages > 1 && currentPage > 1) {
                paginationHtml += '<a href="#" onclick="changePage(' + (currentPage - 1) + ')">&laquo;</a>';
            }

            for (var i = startPage; i <= endPage; i++) {
                paginationHtml += '<a href="#" onclick="changePage(' + i + ')"' + (i === currentPage ? ' class="active"' : '') + '>' + i + '</a>';
            }

            if (totalPages > 1 && currentPage < totalPages) {
                paginationHtml += '<a href="#" onclick="changePage(' + (currentPage + 1) + ')">&raquo;</a>';
            }

            $('#pagination').html(paginationHtml);
        }

        function changePage(page) {
            currentPage = page;
            loadPurchaseList();
        }

        function filterByStatus(status) {
            currentpurchaseStatus = status;
            currentPage = 1; // Reset to first page when filtering
            $('.status-buttons button').removeClass('active');
            if (status === null) {
                $('button:contains("전체")').addClass('active');
            } else if (status === 0) {
                $('button:contains("출고전")').addClass('active');
            } else if (status === 1) {
                $('button:contains("출고 완료")').addClass('active');
            }
            loadPurchaseList();
        }

        function searchPurchases() {
            currentSearchType = $('#searchType').val();
            currentSearchKeyword = $('#searchKeyword').val();
            currentPage = 1; // Reset to first page when searching
            loadPurchaseList();
        }

        function openModal(mode, purchaseId = null, itemDataEncoded = null) {
            currentModalMode = mode;
            $('#purchaseModal').css('display', 'flex'); // Use flex to center
            $('#purchaseForm')[0].reset(); // Clear form fields

            if (mode === 'insert') {
                $('#modalTitle').text('출고 정보 입력');
                $('#submitModalButton').text('저장').removeClass('update-button');
                $('#modal_purchase_id').val(''); // Clear hidden ID for insert
            } else if (mode === 'update' && purchaseId !== null && itemDataEncoded !== null) {
                $('#modalTitle').text('출고 정보 수정');
                $('#submitModalButton').text('수정').addClass('update-button');
                var item = JSON.parse(decodeURIComponent(itemDataEncoded));
                $('#modal_purchase_id').val(item.purchase_id);
                $('#modal_product_name').val(item.product_name).attr("readonly", "readonly");
                $('#modal_client_name').val(item.client_name).attr("readonly", "readonly");
                $('#modal_member_name').val(item.member_name).attr("readonly", "readonly");
                $('#modal_shpping_count').val(item.shpping_count);
                $('#modal_purchase_status').val(item.purchase_status);
            }
        }

        function closeModal() {
            $('#purchaseModal').css('display', 'none');
        }

        function insertPurchaseData(purchaseData) {
            $.ajax({
                url: insertUrl,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(purchaseData),
                success: function(response) {
                    if (response === "SUCCESS") {
                        alert("정보가 성공적으로 저장되었습니다.");
                        closeModal();
                        loadPurchaseList(); // Reload with current filters and page
                    } else {
                        alert("정보 저장에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error inserting purchase: ", status, error);
                    alert("정보 저장 중 오류가 발생했습니다.");
                }
            });
        }

        function updatePurchaseData(purchaseData) {
            if (!purchaseData.purchase_id) {
                alert("오류: 수정할 출고 ID가 누락되었습니다.");
                return;
            }

            $.ajax({
                url: updateUrl,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(purchaseData),
                success: function(response) {
                    if (response === "SUCCESS") {
                        alert("정보가 성공적으로 수정되었습니다.");
                        closeModal();
                        loadPurchaseList(); // Reload with current filters and page
                    } else {
                        alert("정보 수정에 실패했습니다.");
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error updating purchase: ", status, error);
                    alert("정보 수정 중 오류가 발생했습니다.");
                }
            });
        }

        function submitPurchase() {
            var purchaseData = {
                product_name: $('#modal_product_name').val(),
                client_name: $('#modal_client_name').val(),
                member_name: $('#modal_member_name').val(),
                shpping_count: $('#modal_shpping_count').val(),
                purchase_status: $('#modal_purchase_status').val()
            };

            if (!purchaseData.product_name || !purchaseData.client_name || !purchaseData.member_name || !purchaseData.shpping_count) {
                alert("모든 필수 필드를 입력해주세요.");
                return;
            }

            if (currentModalMode === 'insert') {
                insertPurchaseData(purchaseData);
            } else if (currentModalMode === 'update') {
                purchaseData.purchase_id = $('#modal_purchase_id').val();
                updatePurchaseData(purchaseData);
            }
        }
    </script>
</body>
</html>