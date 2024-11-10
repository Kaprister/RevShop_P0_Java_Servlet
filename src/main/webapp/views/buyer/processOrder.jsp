<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Process Order</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <%-- Include header.jsp for the Navbar --%>
    <%@ include file="../../header.jsp" %>

    <div class="container mx-auto py-8">
        <h1 class="text-3xl font-bold mb-6 text-center">Process Your Order</h1>
        
        <form action="" method="post">
            <div class="mb-4">
                <label for="address" class="block text-gray-700">Delivery Address:</label>
                <input type="text" id="address" name="address" required class="mt-1 block w-full p-2 border border-gray-300 rounded">
            </div>
            <div class="mb-4">
                <label class="block text-gray-700">Payment Method:</label>
                <div class="flex items-center">
                    <input type="radio" id="cashOnDelivery" name="orderType" value="Cash on Delivery" checked>
                    <label for="cashOnDelivery" class="ml-2">Cash on Delivery</label>
                </div>
                <div class="flex items-center">
                    <input type="radio" id="onlinePayment" name="orderType" value="Online Payment">
                    <label for="onlinePayment" class="ml-2">Online Payment</label>
                </div>
            </div>
            <input type="hidden" name="totalAmount" value="${totalAmount}">
            <button type="submit" class="px-6 py-3 bg-blue-600 text-white rounded-md hover:bg-blue-700">Place Order</button>
        </form>
    </div>
</body>
</html>
