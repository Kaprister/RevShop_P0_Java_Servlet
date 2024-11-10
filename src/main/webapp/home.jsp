<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home - Products</title>
    <link rel="stylesheet" href="static/css/productsCardHome.css"> <!-- Link to your CSS file -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
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
		    border-radius: 20px;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    color: gray;
		}
		

        
    </style>
    
</head>
<body>
	<%-- Include header.jsp for the Navbar --%>
    <%@ include file="header.jsp" %>
    
     <div class="image-container relative">
	    <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223258/RevShop/b2_qnmjba.jpg" alt="Summer Collection" class="w-full h-44 md:h-48 object-cover">
	    <div class="heading-overlay absolute inset-0 flex flex-col justify-center items-center text-white">
	        <h2 class="text-white text-3xl md:text-4xl font-bold">Featured Products</h2>
	        <p class="text-white text-lg md:text-xl">Summer collection New Modern Design</p>
	    </div>
	</div>


    
    <%-- products --%>
    <section id="product1" class="section-p1">
        
        <div class="pro-container">
            <!-- Loop through the products and create product cards -->
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
                    <!-- Add to Cart and Buy Now buttons 
                    <form action="CartController" method="post">
                        <input type="hidden" name="productId" value="${product.id}" />
                        <input type="hidden" name="quantity" value="1" />
                        <%-- <a href="#"><i class="fal fa-shopping-cart cart"></i></a> --%>
                        <button type="submit" name="action" value="addToCart">Add to Cart</button>
                        <button type="submit" name="action" value="buyNow">Buy Now</button>
                    </form>
                    -->
                    
                    <div class="flex justify-between pb-2">
					    <!-- Add to Cart form -->
					    <form action="${pageContext.request.contextPath}/CartController" method="post" class="inline">
					        <input type="hidden" name="productId" value="${product.id}" />
					        <input type="hidden" name="quantity" value="1" /> <!-- Set default quantity -->
					        <button type="submit" name="action" value="addToCart" class="px-4 py-1 bg-blue-600 text-white rounded-md hover:bg-blue-700 transition duration-300">Add to Cart</button>
					    </form>
					
					    <!-- Buy Now form -->
					    <form action="${pageContext.request.contextPath}/CartController" method="post" class="inline">
					        <input type="hidden" name="productId" value="${product.id}" />
					        <input type="hidden" name="quantity" value="1" /> <!-- Set default quantity -->
					        <button type="submit" name="action" value="buyNow" class="px-4 py-1 bg-red-600 text-white rounded-md hover:bg-red-700 transition duration-300">Buy Now</button>
					    </form>
                     </div>
                    
                    
                </div>
            </c:forEach>
        </div>
    </section>
    
    
    <%-- Include footer.jsp for the Footer --%>
    <%@ include file="footer.jsp" %>
</body>
</html>
