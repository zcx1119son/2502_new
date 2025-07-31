<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${title}</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h1>${title}</h1>
    <p>This is a test page rendered with @RestController</p>
    <button id="backBtn">Go Back</button>

    <script>
        $(document).ready(function() {
            $('#backBtn').click(function() {
                window.location.href = '/';
            });
        });
    </script>
</body>
</html>