<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Spring Boot JSP</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>${message}</h1>
    <button id="testBtn">Test jQuery</button>

    <script>
        $(document).ready(function() {
            $('#testBtn').click(function() {
                alert('jQuery is working!');
                window.location.href = '/test';
            });
        });
    </script>
</body>
</html>