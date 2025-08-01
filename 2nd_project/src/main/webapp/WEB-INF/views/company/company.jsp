<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
  request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Company Information (AJAX)</title>
    <style>
    body {
        font-family: 'Apple SD Gothic Neo', sans-serif;
        background-color: #f7f7fb;
        margin: 0;
        padding: 120px;
    }

    #searchBox {
        margin-bottom: 30px;
        text-align: right;
    }

    #searchInput {
        padding: 10px;
        width: 250px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 14px;
    }

    .accordion-header {
        margin-top: 40px;
        margin-bottom: 0;
        padding: 15px 20px;
        background-color: #A3B0EC;
        color: white;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        border-radius: 6px 6px 0 0;
    }
    .accordion-content {
        display: none;
        border: 1px solid #d0d7e2;
        border-top: none;
        border-radius: 0 0 8px 8px;
        overflow: hidden;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #ffffff;
    }

    th, td {
        padding: 12px 15px;
        text-align: left;
        font-size: 14px;
    }

    thead {
        background-color: #f0f4ff;
        border-bottom: 2px solid #d0d7e2;
    }

    th {
        font-weight: bold;
        color: #34495e;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #eef3ff;
    }

    p {
        font-size: 16px;
        color: #555;
        margin: 20px 0;
    }

    .hidden {
        display: none;
    }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<body>
    <div id="searchBox">
        <input type="text" id="searchInput" placeholder="직원이름으로 검색..." />
    </div>

    <div id="companyDataTable">
        <p>Loading company data...</p>
    </div>

    <script>
        $(document).ready(function() {
            loadCompanyData();

            // 아코디언 기능
            $(document).on("click", ".accordion-header", function() {
                $(this).next(".accordion-content").slideToggle();
            });

            // 검색 필터링 기능
            $('#searchInput').on('keyup', function() {
                let keyword = $(this).val().toLowerCase();

                $('.accordion-content').each(function() {
                    let matchCount = 0;
                    $(this).find('tbody tr').each(function() {
                        let name = $(this).find('td:first').text().toLowerCase();
                        if (name.includes(keyword)) {
                            $(this).show();
                            matchCount++;
                        } else {
                            $(this).hide();
                        }
                    });

                    // 부서 안에 하나라도 있으면 보여줌
                    if (matchCount > 0) {
                        $(this).prev('.accordion-header').show();
                        $(this).show();
                    } else {
                        $(this).prev('.accordion-header').hide();
                        $(this).hide();
                    }
                });
            });
        });

        function loadCompanyData() {
            $.ajax({
                url: '${contextPath}/company/data',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    let htmlContent = '';
                    if (data && data.length > 0) {
                        let currentDepartment = '';
                        $.each(data, function(index, company) {
                            if (company.department_name !== currentDepartment) {
                                if (index !== 0) {
                                    htmlContent += '</tbody></table></div>';
                                }

                                htmlContent += '<div class="accordion-header">부서: ' + company.department_name + '</div>';
                                htmlContent += '<div class="accordion-content">';
                                htmlContent += '<table>';
                                htmlContent += '<thead><tr><th>Member Name</th><th>Member Email</th><th>Job Title</th></tr></thead>';
                                htmlContent += '<tbody>';
                                currentDepartment = company.department_name;
                            }

                            htmlContent += '<tr>';
                            htmlContent += '<td>' + company.member_name + '</td>';
                            htmlContent += '<td>' + company.member_email + '</td>';
                            htmlContent += '<td>' + company.job_title + '</td>';
                            htmlContent += '</tr>';

                            if (index === data.length - 1) {
                                htmlContent += '</tbody></table></div>';
                            }
                        });
                    } else {
                        htmlContent = '<p>No company information available.</p>';
                    }
                    $('#companyDataTable').html(htmlContent);
                },
                error: function(xhr, status, error) {
                    console.error("AJAX Error: ", status, error);
                    $('#companyDataTable').html('<p>Error loading data: ' + error + '</p>');
                }
            });
        }
    </script>
</body>
</html>