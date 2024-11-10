<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Order</title>
    <!-- Tailwind CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Add subtle box-shadow and hover effects */
        .card {
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease-in-out;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .form-input:focus {
            outline: none;
            border-color: #2563EB;
            box-shadow: 0 0 5px rgba(37, 99, 235, 0.5);
        }
    </style>
</head>
<body class="bg-gray-100">

    <!-- Include header.jsp for the Navbar -->
    <%@ include file="../../header.jsp" %>

    <div class="container mx-auto py-12 px-6 lg:px-20">
        <!-- Page Title -->
        <h1 class="text-4xl font-extrabold text-center mb-10 text-gray-900">Place Your Order</h1>

        <!-- Order Form Card -->
        <div class="card bg-white p-8 rounded-lg max-w-lg mx-auto">
            <h2 class="text-2xl font-semibold text-gray-800 mb-6">Order Details</h2>

            <!-- Order Form -->
            <form action="${pageContext.request.contextPath}/OrderController" method="post">
                <!-- Order Type -->
                <div class="mb-6">
                    <label for="orderType" class="block text-lg font-medium text-gray-700 mb-2">Order Type:</label>
                    <select name="orderType" id="orderType" class="form-input block w-full p-3 border border-gray-300 rounded-lg text-gray-700 focus:ring focus:ring-blue-200" required>
                        <option value="Cash on Delivery">Cash on Delivery</option>
                        <option value="Online Payment">Online Payment</option>
                    </select>
                </div>

                <!-- Delivery Address -->
                <div class="mb-6">
                    <label for="address" class="block text-lg font-medium text-gray-700 mb-2">Delivery Address:</label>
                    <textarea name="address" id="address" rows="4" class="form-input block w-full p-3 border border-gray-300 rounded-lg text-gray-700 focus:ring focus:ring-blue-200" required></textarea>
                </div>

                <!-- Hidden Inputs for Cart Details -->
                <input type="hidden" name="totalAmount" value="${totalAmount != null ? totalAmount : '0'}" />
                <input type="hidden" name="discountedPrice" value="${discountedPrice != null ? discountedPrice : '0'}" />

                <!-- Confirm Order Button -->
                <div class="mt-8">
                    <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg transition-all duration-300 focus:ring-4 focus:ring-blue-300 focus:outline-none">
                        Confirm Order
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
