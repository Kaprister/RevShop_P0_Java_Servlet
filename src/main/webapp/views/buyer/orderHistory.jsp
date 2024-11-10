<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .fade-in {
            animation: fadeIn 0.5s ease-in-out forwards;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="bg-gray-100">
    <%-- Include header.jsp for the Navbar --%>
    <%@ include file="../../header.jsp" %>
    
    <div class="image-container relative">
	    <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223257/RevShop/b1_elce1n.jpg" alt="Summer Collection" class="w-full h-44 md:h-48 object-cover">
	    <div class="heading-overlay absolute inset-0 flex flex-col justify-center items-center text-white">
	        <h1 class="text-white text-3xl md:text-4xl font-bold">Your Order History</h1>
	    </div>
	</div>

    <div class="container mx-auto px-4 py-8">
       

        <c:if test="${empty orderHistory}">
            <p class="text-center text-gray-500">You have no orders yet.</p>
        </c:if>

        <c:if test="${not empty orderHistory}">
            <div class="grid grid-cols-1 gap-6">
                <c:forEach var="order" items="${orderHistory}">
                    <div class="bg-white shadow-md rounded-lg p-6 fade-in flex flex-col md:flex-row">
                        <!-- Left Side: Product Image -->
                        <div class="md:w-1/4 flex-shrink-0 mb-4 md:mb-0">
                            <img src="${order.imageUrl}" alt="Product Image" class="object-cover w-full h-full rounded-lg transition-transform transform hover:scale-105">
                        </div>

                        <!-- Right Side: Order Details -->
                        <div class="md:w-3/4 md:pl-6">
                            <div class="flex justify-between items-center mb-4">
                                <h3 class="text-xl font-semibold">Order #${order.id}</h3>

                                <!-- Conditional coloring based on order status -->
                                <c:choose>
                                    <c:when test="${order.orderStatus == 'Pending'}">
                                        <span class="bg-yellow-100 text-yellow-800 text-sm font-medium px-2.5 py-0.5 rounded">Pending</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 'Completed'}">
                                        <span class="bg-green-100 text-green-800 text-sm font-medium px-2.5 py-0.5 rounded">Completed</span>
                                    </c:when>
                                    <c:when test="${order.orderStatus == 'Canceled'}">
                                        <span class="bg-red-100 text-red-800 text-sm font-medium px-2.5 py-0.5 rounded">Canceled</span>
                                    </c:when>
                                </c:choose>
                            </div>

                            <div class="grid grid-cols-2 gap-4">
                                <!-- Order Info -->
                                <div>
                                    <p class="text-sm text-gray-600">Product ID: <span class="font-medium">${order.productId}</span></p>
                                    <p class="text-sm text-gray-600">Quantity: <span class="font-medium">${order.quantity}</span></p>
                                    <p class="text-sm text-gray-600">Order Type: <span class="font-medium">${order.orderType}</span></p>
                                </div>

                                <!-- Pricing and Address -->
                                <div>
                                    <p class="text-sm text-gray-600">Total Amount: <span class="font-medium line-through">$${order.totalAmount}</span></p>
                                    <p class="text-sm text-red-600">Discounted Price: <span class="font-medium">$${order.discountedPrice}</span></p>
                                    <p class="text-sm text-gray-600">Order Date: <span class="font-medium">${order.orderDate}</span></p>
                                    <p class="text-sm text-gray-600">Address: <span class="font-medium">${order.address}</span></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <div class="mt-8 text-center">
            <a href="ProductController?action=viewProducts" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full transition-all duration-300 ease-in-out">Continue Shopping</a>
        </div>
    </div>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</body>
</html>
