<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sold Products</title>
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
            <h1 class="text-white text-3xl md:text-4xl font-bold">Sold Products</h1>
        </div>
    </div>

    <div class="container mx-auto px-4 py-8">

        <c:if test="${not empty message}">
            <p class="text-center text-gray-500 mb-4">${message}</p>
        </c:if>

        <c:if test="${not empty soldProducts}">
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <c:forEach var="product" items="${soldProducts}">
                    <div class="bg-white shadow-lg rounded-lg p-6 fade-in transition-transform transform hover:scale-105 hover:shadow-xl">
                        <!-- Left Side: Product Image -->
                        <div class="flex-shrink-0 mb-4">
                            <img src="${product.imageUrl}" alt="${product.name}" class="object-cover w-full h-48 rounded-lg">
                        </div>

                        <!-- Right Side: Product Details -->
                        <div>
                            <h3 class="text-2xl font-semibold mb-2 text-gray-800 hover:text-blue-600 transition duration-200">${product.name}</h3>
                            <p class="text-gray-600 mb-2">Description: <span class="font-medium">${product.description}</span></p>
                            <p class="text-gray-600 mb-1">Price: <span class="font-medium text-green-600">$${product.price}</span></p>
                            <p class="text-gray-600 mb-1">Quantity Sold: <span class="font-medium">${product.quantity}</span></p>
                            <p class="text-gray-600 mb-1">Brand: <span class="font-medium">${product.brand}</span></p>
                            <p class="text-gray-600 mb-1">Seller ID: <span class="font-medium">${product.sellerId}</span></p>
                            <p class="text-gray-600 mb-1">Rating: <span class="font-medium">${product.rating} / 5</span></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
    
    <%-- Include footer.jsp for the Footer --%>
    <%@ include file="../../footer.jsp" %>

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</body>
</html>
