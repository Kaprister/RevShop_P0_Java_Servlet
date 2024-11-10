<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Products</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
    <link rel="stylesheet" href="static/css/productsCardHome.css"> <!-- Link to your CSS file -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        @keyframes fadeIn {
            0% { opacity: 0; transform: scale(0.95); }
            100% { opacity: 1; transform: scale(1); }
        }
        .fade-in {
            animation: fadeIn 0.5s ease-in-out;
        }
        .placeholder {
		    background-color: #f3f4f6; /* Light grey color for placeholder */
		    width: 100%;
		    height: 200px; /* Set a fixed height for placeholder */
		    border-radius : 20px;
		    display: flex;
		    justify-content : center;
		    align-items: center;
		    color : gray;
		}
    </style>
</head>

<body>
    <%-- Include header.jsp for the Navbar --%>
     <%@ include file="../../header.jsp" %> 
     
     <div class="image-container relative">
	    <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223258/RevShop/b2_qnmjba.jpg" alt="Summer Collection" class="w-full h-44 md:h-48 object-cover">
	    <div class="heading-overlay absolute inset-0 flex flex-col justify-center items-center text-white">
	        <h2 class="text-white text-3xl md:text-4xl font-bold">Your Products</h2>
	        <p class="text-white text-lg md:text-xl">Manage your products here.</p>
	    </div>
	</div>
    
    <%-- products --%>
    <section id="product1" class="section-p1">
     
        <div class="pro-container">
            <!-- Loop through the products and create product cards -->
            <c:if test="${not empty products}">
                <c:forEach var="product" items="${products}">
                    <div class="pro fade-in">
                        <%-- Conditional rendering of the product image --%>
                        <c:choose>
                            <c:when test="${not empty product.imageUrl}">
                                <img src="${product.imageUrl}" alt="${product.name}">
                            </c:when>
                            <c:otherwise>
                                <div class="placeholder">Image not available</div> <!-- Placeholder for missing image -->
                            </c:otherwise>
                        </c:choose>
                        <div class="des">
                            <span>${product.brand}</span>
                            <h5>${product.name}</h5>
                            
                            <div class="star">
                                <!-- Display stars based on product rating -->
                                <c:forEach var="star" begin="1" end="${product.rating}">
                                    <i class="fas fa-star"></i>
                                </c:forEach>
                                <!-- Display empty stars to fill up to 5 if rating is less than 5 -->
                                <c:forEach var="emptyStar" begin="${product.rating + 1}" end="5">
                                    <i class="far fa-star"></i>
                                </c:forEach>
                            </div>
                            
                            <h4>$${product.price}</h4>
                        </div>
                        <!-- Remove and Edit buttons -->
                        <div class="flex justify-between pb-2">
                            <form class="flex justify-center items-center">
                            	<a href="${pageContext.request.contextPath}/ProductController?action=editProduct&productId=${product.id}" 
   								class="px-8 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-300 inline-block text-center">
   								Edit
								</a>
                            </form>
                            
                            <form action="${pageContext.request.contextPath}/ProductController?action=removeProduct" method="post" class="inline">
                                <input type="hidden" name="productId" value="${product.id}" />
                                <%-- <button type="submit" name="action" value="remove" class="px-4 py-1 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Remove</button>--%>
                                 <button type="submit" name="action" value="remove" 
                                 class="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 flex items-center"
                                  style="background-color: red; border: none; transition: background-color 0.3s;"
								    onmouseover="this.style.backgroundColor='darkred';" 
								    onmouseout="this.style.backgroundColor='red';"
                                 >
                                        <i class="fas fa-trash-alt mr-2"></i> Remove
                                 </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty products}">
                <div class="col-span-full text-center text-gray-500">
                    <p>No products available.</p>
                </div>
            </c:if>
        </div>
    </section>
    
    <%-- Include footer.jsp for the Footer --%>
    <%@ include file="../../footer.jsp" %>
</body>
</html>
