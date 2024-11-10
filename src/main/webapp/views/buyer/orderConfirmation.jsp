<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <%-- Include header.jsp for the Navbar --%>
    <%@ include file="../../header.jsp" %>

    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Order Confirmation</h1>
        <p class="text-lg text-center">Thank you for your order! Your order has been placed successfully.</p>
        <p class="text-center">We will process your order shortly.</p>
        <div class="text-center mt-4">
            <a href="${pageContext.request.contextPath}/CartController" class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700">Go to Cart</a>
            <a href="${pageContext.request.contextPath}/ProductController?action=viewProducts" class="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700">Continue Shopping</a>
        </div>
    </div>
</body>
</html>
