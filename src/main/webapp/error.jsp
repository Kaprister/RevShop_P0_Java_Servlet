<%@ page isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

    <!-- Error Section -->
    <section id="error-page" class="bg-white shadow-md rounded-lg p-8">
        <div class="error-container text-center">
            <h1 class="text-4xl font-bold text-red-600 mb-4">Oops! Something went wrong.</h1>
            <h2 class="text-2xl text-gray-800 mb-6">Error Code: <span class="font-semibold"><%= request.getAttribute("jakarta.servlet.error.status_code") %></span></h2>

            <c:choose>
                <c:when test="${pageContext.errorData.throwable != null}">
                    <h3 class="text-xl font-semibold text-gray-700 mb-4">An unexpected error occurred:</h3>
                    <p class="text-gray-600"><%= pageContext.getErrorData().getThrowable().getMessage() %></p>
                </c:when>
                <c:otherwise>
                    <h3 class="text-xl font-semibold text-gray-700 mb-4">It seems that the page you're looking for doesn't exist.</h3>
                </c:otherwise>
            </c:choose>

            <a href="${pageContext.request.contextPath}/index.jsp" class="mt-8 inline-block px-6 py-3 text-white bg-blue-500 hover:bg-blue-600 rounded-md text-lg">Return to Home</a>
        </div>
    </section>

</body>
</html>
