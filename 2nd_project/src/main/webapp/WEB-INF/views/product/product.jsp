<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>재고 관리</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <style>
            body {
                font-family: 'Apple SD Gothic Neo', sans-serif;
                background-color: #f7f7fb;
                margin: 0;
                padding: 40px;
            }

            .nav-menu {
                display: flex;
                background-color: #e9ecef;
                padding: 10px 20px;
                border-bottom: 1px solid #dee2e6;
            }
            .nav-menu a {
                text-decoration: none;
                color: #495057;
                padding: 8px 15px;
                margin-right: 5px;
                border-radius: 4px;
                font-weight: bold;
            }
            .nav-menu a.active, .nav-menu a:hover {
                background-color: #007bff;
                color: white;
            }
            .container {
                margin-top: 60px;
                padding: 40px;
            }
            .top-section {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .top-section .search-bar {
                display: flex;
                align-items: center;
            }
            .top-section .search-bar select,
            .top-section .search-bar input[type="text"],
            .top-section .search-bar button {
                padding: 8px 12px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                margin-right: 5px;
            }
            .top-section .buttons button {
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-left: 5px;
                font-weight: bold;
            }
            .top-section .buttons .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .top-section .buttons .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .top-section .buttons .btn-danger {
                background-color: #dc3545;
                color: white;
            }

            .content-area {
                background-color: white;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                padding: 15px;
            }
            .content-area h2 {
                margin-top: 0;
                font-size: 20px;
                color: #495057;
            }
            /* Style for the table action area, removed global edit button */
            .table-actions-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }
            .table-actions-row h2 {
                margin: 0;
            }

            .product-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            .product-table th, .product-table td {
                border: 1px solid #dee2e6;
                padding: 10px;
                text-align: left;
            }
            .product-table th {
                background-color: #e9ecef;
                font-weight: bold;
                white-space: nowrap; /* Prevent wrapping for headers */
            }
            .product-table tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .product-table input[type="checkbox"] {
                margin: 0;
            }
            /* Style for the inline edit button */
            .product-table .btn-edit-row {
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                background-color: #6c757d; /* secondary color */
                color: white;
                font-weight: bold;
                white-space: nowrap;
            }
            .product-table .btn-edit-row:hover {
                background-color: #5a6268;
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

            /* Modal Styles */
            .modal {
                display: none; /* Hidden by default */
                position: fixed; /* Stay in place */
                z-index: 1000; /* Sit on top */
                left: 0;
                top: 0;
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                overflow: auto; /* Enable scroll if needed */
                background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
                justify-content: center;
                align-items: center;
            }
            .modal-content {
                background-color: #fefefe;
                margin: auto; /* Center vertically and horizontally */
                padding: 20px;
                border: 1px solid #888;
                width: 70%; /* Adjust as needed */
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
            .modal-body .modal-buttons {
                text-align: right;
                margin-top: 25px;
            }
            .modal-body .modal-buttons button {
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-left: 5px;
                font-weight: bold;
            }
            .modal-body .modal-buttons .btn-submit {
                 background-color: #007bff;
                color: white;
            }
            .modal-body .modal-buttons .btn-cancel {
                background-color: #6c757d;
                color: white;
            }
            .modal-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            .modal-table th, .modal-table td {
                border: 1px solid #dee2e6;
                padding: 10px;
                text-align: left;
            }
            .modal-table th {
                background-color: #e9ecef;
                font-weight: bold;
                white-space: nowrap;
            }
            .modal-table input[type="text"],
            .modal-table input[type="number"] {
                width: calc(100% - 20px); /* Adjust for padding */
                padding: 8px;
                border: 1px solid #ced4da;
                border-radius: 4px;
            }
            .modal-action-buttons {
                text-align: center;
                margin-top: 20px;
            }
            .modal-action-buttons button {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                background-color: #007bff;
                color: white;
            }

            /* Animation */
            @-webkit-keyframes animatetop {
                from {top: -300px; opacity: 0}
                to {top: 0; opacity: 1}
            }
            @keyframes animatetop {
                from {top: -300px; opacity: 0}
                to {top: 0; opacity: 1}
            }
        </style>
        <%@ include file="/WEB-INF/views/include/header.jsp" %>
    </head>

    <body>
        <div class="container">
            <div class="content-area">
                <div class="top-section">
                    <div class="search-bar">
                        <select id="searchTypeSelect">
                            <option value="client_id">회사코드</option>
                            <option value="product_id">제품코드</option>
                            <option value="product_name">제품명</option>
                            <option value="client_name">회사명</option>
                        </select>
                        <input type="text" id="searchKeyword" placeholder="검색어를 입력하세요">
                        <button class="btn-primary" id="searchButton">검색</button>
                    </div>
                    <div class="buttons">
                        <button class="btn-primary" id="openRegisterModalBtn">추가</button>
                        <button class="btn-danger" id="deleteSelectedBtn">삭제</button>
                    </div>
                </div>

                <h2>재고</h2>
                <table class="product-table">
                    <thead>
                        <tr>
                            <th><input type="checkbox" id="selectAllCheckbox"></th>
                            <th>등록 날짜</th>
                            <th>회사 코드</th>
                            <th>회사 이름</th>
                            <th>제품 코드</th>
                            <th>제품 명</th>
                            <th>현재 재고</th>
                            <th>수정</th>
                        </tr>
                    </thead>
                    <tbody id="productList">
                    </tbody>
                </table>

                <div class="pagination" id="paginationControls">
                </div>
            </div>
        </div>

        <div id="registerModal" class="modal">
            <div class="modal-content">
                <span class="close-button register-close-button">&times;</span>
                <div class="modal-body">
                    <form id="addProductForm">
                        <table class="modal-table">
                            <thead>
                                <tr>
                                    <th>회사 이름</th>
                                    <th>제품 명</th>
                                    <th>수량</th>
                                    <th>담당자</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="client_name" placeholder="회사 이름" required></td>
                                    <td><input type="text" name="product_name" placeholder="제품 이름" required></td>
                                    <td><input type="number" name="product_count" placeholder="수량" required></td>
                                    <td><input type="text" name="created_id" id="created_id_display" placeholder="담당자" required></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="modal-buttons">
                             <button type="submit" class="btn-submit" id="submitRegisterBtn">등록</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="editModal" class="modal">
            <div class="modal-content">
                <span class="close-button edit-close-button">&times;</span>
                <div class="modal-body">
                    <form id="editProductForm">
                        <input type="hidden" name="product_id" id="edit_product_id">
                        <table class="modal-table">
                            <thead>
                                <tr>
                                    <th>제품 코드</th>
                                    <th>제품 이름</th>
                                    <th>회사 이름</th>
                                    <th>수량</th>
                                    <th>수정자</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" id="edit_product_code_display" disabled></td>
                                    <td><input type="text" name="product_name" id="edit_product_name" required></td>
                                    <td><input type="text" name="client_name" id="edit_client_name" required></td>
                                    <td><input type="number" name="product_count" id="edit_product_count" required></td>
                                    <td><input type="text" name="updated_id" id="updated_id_display" placeholder="수정자" required></td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="modal-buttons">
                            <button type="submit" class="btn-submit" id="submitEditBtn">저장</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            const PRODUCT_PAGE_SIZE = 10; // Renamed for clarity
            let currentProductPage = 0; // Renamed for clarity
            let productSearchType = ''; // Renamed for clarity
            let productSearchKeyword = ''; // Renamed for clarity

            // Function to open a modal
            function openModal(modalId) {
                $(modalId).css('display', 'flex');
            }

            // Function to close a modal
            function closeModal(modalId, formId) {
                $(modalId).hide();
                if (formId) {
                    $(formId)[0].reset();
                }
            }

            // Common AJAX function
            function callAjax(url, type, data, successCallback, errorCallback, contentType = 'application/x-www-form-urlencoded; charset=UTF-8') {
                $.ajax({
                    type: type,
                    url: url,
                    contentType: contentType,
                    data: data,
                    success: successCallback,
                    error: errorCallback
                });
            }

            // Load products based on pagination and search
            function loadProducts(page, type = '', keyword = '') {
                currentProductPage = page; // Update current page globally
                productSearchType = type;
                productSearchKeyword = keyword;

                callAjax(
                    '/product/list',
                    'GET',
                    {
                        page: page,
                        size: PRODUCT_PAGE_SIZE,
                        sortBy: 'product_id',
                        sortDirection: 'desc',
                        searchType: type,
                        searchKeyword: keyword
                    },
                    function(response) { // successCallback
                        const products = response.products;
                        const totalPages = response.totalPages;

                        $('#productList').empty();
                        $('#selectAllCheckbox').prop('checked', false);

                        if (products.length === 0) {
                            $('#productList').append('<tr><td colspan="8">등록된 재고가 없습니다.</td></tr>'); // Corrected colspan
                        } else {
                            $.each(products, function(index, product) {
                                $('#productList').append(
                                    '<tr>' +
                                    '<td><input type="checkbox" class="product-checkbox" data-product-id="' + product.product_id + '"></td>' +
                                    '<td>' + (product.created_date ? new Date(product.created_date).toLocaleDateString() : '') + '</td>' +
                                    '<td>' + product.client_id + '</td>' +
                                    '<td>' + (product.client_name || '회사를 찾을수 없습니다 다시 입력해주세요') + '</td>' +
                                    '<td>' + product.product_id + '</td>' +
                                    '<td>' + product.product_name + '</td>' +
                                    '<td>' + product.product_count + '</td>' +
                                    '<td><button class="btn-edit-row" data-product-id="' + product.product_id + '">수정</button></td>' +
                                    '</tr>'
                                );
                            });
                        }
                        updatePaginationControls(totalPages, currentProductPage);
                    },
                    function(xhr, status, error) { // errorCallback
                        $('#productList').append('<tr><td colspan="8">재고를 불러오는 중 오류 발생: ' + error + '</td></tr>'); // Corrected colspan
                        $('#paginationControls').empty();
                    },
                    'json' // Specify dataType if response is JSON, though jQuery often infers this from response
                );
            }

            // Add new product
            function addProduct() {
                const formData = $('#addProductForm').serialize();
                callAjax(
                    '/product/add',
                    'POST',
                    formData,
                    function(response) { // successCallback
                        alert(response);
                        closeModal('#registerModal', '#addProductForm');
                        loadProducts(currentProductPage, productSearchType, productSearchKeyword);
                    },
                    function(xhr, status, error) { // errorCallback
                        alert('제품 추가 중 오류 발생: ' + xhr.responseText);
                    }
                );
            }

            // Load product for editing
            function loadProductForEdit(productId) {
                callAjax(
                    '/product/' + productId,
                    'GET',
                    null, // No data needed for GET by ID
                    function(product) { // successCallback
                        $('#edit_product_id').val(product.product_id);
                        $('#edit_product_code_display').val(product.product_id);
                        $('#edit_product_name').val(product.product_name);
                        $('#edit_client_name').val(product.client_name);
                        $('#edit_product_count').val(product.product_count);
                        $('#updated_id_display').val(''); // Clear for user input
                        openModal('#editModal');
                    },
                    function(xhr, status, error) { // errorCallback
                        alert('제품 정보를 불러오는 중 오류 발생: ' + error);
                    },
                    'json'
                );
            }

            // Update existing product
            function updateProduct() {
                const productId = $('#edit_product_id').val();
                const productName = $('#edit_product_name').val();
                const clientName = $('#edit_client_name').val();
                const productCount = $('#edit_product_count').val();
                const updatedId = $('#updated_id_display').val();

                if (!productName || !clientName || !productCount || !updatedId) { // Check clientName not clientId
                    alert('모든 필드를 입력해주세요.');
                    return;
                }

                const productData = {
                    product_id: productId,
                    product_name: productName,
                    client_name: clientName,
                    product_count: productCount,
                    updated_id: updatedId
                };

                callAjax(
                    '/product/update',
                    'POST',
                    JSON.stringify(productData),
                    function(response) { // successCallback
                        alert(response);
                        closeModal('#editModal', '#editProductForm');
                        loadProducts(currentProductPage, productSearchType, productSearchKeyword);
                    },
                    function(xhr, status, error) { // errorCallback
                        alert('제품 수정 중 오류 발생: ' + xhr.responseText);
                    },
                    'application/json; charset=UTF-8' // Content type for JSON data
                );
            }

            // Delete selected products
            function deleteProducts() {
                const selectedProductIds = [];
                $('.product-checkbox:checked').each(function() {
                    selectedProductIds.push($(this).data('product-id'));
                });

                if (selectedProductIds.length === 0) {
                    alert('삭제할 제품을 선택해주세요.');
                    return;
                }

                if (confirm('선택된 ' + selectedProductIds.length + '개의 제품을 정말 삭제하시겠습니까?')) {
                    callAjax(
                        '/product/delete',
                        'POST',
                        JSON.stringify(selectedProductIds),
                        function(response) { // successCallback
                            alert(response);
                            loadProducts(currentProductPage, productSearchType, productSearchKeyword);
                            $('#selectAllCheckbox').prop('checked', false);
                        },
                        function(xhr, status, error) { // errorCallback
                            alert('제품 삭제 중 오류 발생: ' + xhr.responseText);
                        },
                        'application/json; charset=UTF-8' // Content type for JSON data
                    );
                }
            }

            // Update pagination controls
            function updatePaginationControls(totalPages, currentPage) {
                const paginationDiv = $('#paginationControls');
                paginationDiv.empty();

                const maxPageLinks = 10;
                let startPage = Math.max(0, currentPage - Math.floor(maxPageLinks / 2));
                let endPage = Math.min(totalPages - 1, startPage + maxPageLinks - 1);

                if (endPage - startPage + 1 < maxPageLinks) {
                    startPage = Math.max(0, endPage - maxPageLinks + 1);
                }

                if (currentPage > 0) {
                    paginationDiv.append('<a href="#" data-page="' + (currentPage - 1) + '">이전</a>');
                }

                for (let i = startPage; i <= endPage; i++) {
                    const activeClass = (i === currentPage) ? 'active' : '';
                    paginationDiv.append('<a href="#" data-page="' + i + '" class="' + activeClass + '">' + (i + 1) + '</a>');
                }

                if (currentPage < totalPages - 1) {
                    paginationDiv.append('<a href="#" data-page="' + (currentPage + 1) + '">다음</a>');
                }
            }

            // Initialize on document ready
            $(document).ready(function() {
                // Initial load
                productSearchType = $('#searchTypeSelect').val();
                loadProducts(currentProductPage, productSearchType, productSearchKeyword);

                // Event Listeners
                $('#selectAllCheckbox').on('change', function() {
                    $('.product-checkbox').prop('checked', $(this).prop('checked'));
                });

                $('#searchTypeSelect').on('change', function() {
                    productSearchType = $(this).val();
                });

                $('#searchButton').on('click', function() {
                    productSearchKeyword = $('#searchKeyword').val().trim();
                    loadProducts(0, productSearchType, productSearchKeyword); // Always reset to page 0 for new search
                });

                $('#searchKeyword').on('keypress', function(e) {
                    if (e.which === 13) {
                        $('#searchButton').click();
                    }
                });

                $('#openRegisterModalBtn').on('click', function() {
                    openModal('#registerModal');
                });

                $('.register-close-button').on('click', function() {
                    closeModal('#registerModal', '#addProductForm');
                });

                $(window).on('click', function(event) {
                    if ($(event.target).is('#registerModal')) {
                        closeModal('#registerModal', '#addProductForm');
                    } else if ($(event.target).is('#editModal')) {
                        closeModal('#editModal', '#editProductForm');
                    }
                });

                $('#submitRegisterBtn').on('click', function(event) {
                    event.preventDefault(); // Prevent default form submission
                    addProduct();
                });

                $(document).on('click', '.btn-edit-row', function() {
                    const productIdToEdit = $(this).data('product-id');
                    loadProductForEdit(productIdToEdit);
                });

                $('.edit-close-button').on('click', function() {
                    closeModal('#editModal', '#editProductForm');
                });

                $('#submitEditBtn').on('click', function(event) {
                    event.preventDefault(); // Prevent default form submission
                    updateProduct();
                });

                $('#deleteSelectedBtn').on('click', function() {
                    deleteProducts();
                });

                $(document).on('click', '.pagination a', function(e) {
                    e.preventDefault();
                    const pageNum = parseInt($(this).data('page'));
                    loadProducts(pageNum, productSearchType, productSearchKeyword);
                });
            });
        </script>
    </body>
</html>