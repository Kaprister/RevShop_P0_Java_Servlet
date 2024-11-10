<%@ page language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/home.css"> 
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/header.css">
    <style>
        .active {
            @apply text-blue-500 font-bold; /* Apply Tailwind styles for active link */
        }
    </style>
</head>
<body>

    <section id="header" class="flex justify-between items-center p-1 bg-gray-800 text-white h-24">
        <a href="${pageContext.request.contextPath}/index.jsp"><img src="${pageContext.request.contextPath}/static/assets/img/rev-logo.png" class="logo" alt="" style="width: 100px; height:70px; border-radius:10px"></a>
        <div>
            <ul id="navbar" class="flex space-x-4">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="hover:underline">Home</a></li>
                <c:choose>
                    <c:when test="${sessionScope.buyer != null}">
                        <li><a href="${pageContext.request.contextPath}/ProductController?action=viewProducts" class="hover:underline">Shop</a></li>
                        <li><a href="${pageContext.request.contextPath}/about.jsp" class="hover:underline">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact.jsp" class="hover:underline">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/OrderController?action=viewHistory" class="hover:underline">Orders</a></li>
                        <form action="${pageContext.request.contextPath}/CartController" method="get" class="inline">
                            <button type="submit" class="flex items-center px-3 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-300">
                                <i class="fa-solid fa-bag-shopping mr-2"></i> <!-- Icon before the text -->
                                Cart
                            </button>
                        </form>
                    </c:when>
                    <c:when test="${sessionScope.seller != null}">
                        <li><a href="${pageContext.request.contextPath}/ProductController" class="hover:underline">View Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/views/products/add_product.jsp" class="hover:underline">Add Products</a></li>
                        <li><a href="${pageContext.request.contextPath}/blog.jsp" class="hover:underline">Blog</a></li>
                        <li><a href="${pageContext.request.contextPath}/SellerController?action=sold_products" class="hover:underline">Sold</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/about.jsp" class="hover:underline">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact.jsp" class="hover:underline">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/blog.jsp" class="hover:underline">Blog</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

        <!-- Check if buyer or seller is logged in -->
        <div class="flex items-center space-x-4">
            <c:choose>
                <c:when test="${sessionScope.buyer != null}">
                    <!-- Buyer is logged in -->
                    <div class="flex items-center space-x-4">
                        <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223276/RevShop/2_detmq8.png" alt="Profile Image" class="w-10 h-10 rounded-full">
                        <span class="text-gray-600">${sessionScope.buyer.name}</span>
                        
                        <!-- Logout button -->
                        <form action="${pageContext.request.contextPath}/Logout" method="post">
                            <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">Logout</button>
                        </form>
                    </div>
                </c:when>

                <c:when test="${sessionScope.seller != null}">
                    <!-- Seller is logged in -->
                    <div class="flex items-center space-x-4">
                        <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223276/RevShop/2_detmq8.png" alt="Profile Image" class="w-10 h-10 rounded-full">
                        <span class="text-gray-600">${sessionScope.seller.name}</span>
                        
                        <!-- Logout button -->
                        <form action="${pageContext.request.contextPath}/Logout" method="post">
                            <button type="submit" class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700">Logout</button>
                        </form>
                    </div>
                </c:when>

                <c:otherwise>
                    <!-- No user is logged in -->
                    <div class="relative inline-block text-left dropdown">
                        <button class="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-gray-700 text-sm font-medium text-white hover:bg-gray-600" id="login-button">
                            Login
                        </button>
                        <div class="dropdown-content">
                            <div class="py-1">
                                <a href="${pageContext.request.contextPath}/views/buyer/login.jsp" class="hover:bg-gray-100">Buyer</a>
                                <a href="${pageContext.request.contextPath}/views/seller/login.jsp" class="hover:bg-gray-100">Seller</a>
                            </div>
                        </div>
                    </div>

                    <div class="relative inline-block text-left dropdown">
                        <button class="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-gray-700 text-sm font-medium text-white hover:bg-gray-600" id="signup-button">
                            SignUp
                        </button>
                        <div class="dropdown-content">
                            <div class="py-1">
                                <a href="${pageContext.request.contextPath}/views/buyer/register.jsp" class="hover:bg-gray-100">Buyer</a>
                                <a href="${pageContext.request.contextPath}/views/seller/register.jsp" class="hover:bg-gray-100">Seller</a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <!-- Link to external JavaScript file -->
    <script src="${pageContext.request.contextPath}/static/js/header.js"></script>
</html>
