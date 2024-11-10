<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <%-- <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet"> --%>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        .custom-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 1.5rem;
        }
        @media (min-width: 768px) {
            .custom-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>
<body class="bg-gray-100">
    <%-- Include header.jsp for the Navbar --%>
    <%@ include file="../../header.jsp" %>
    
    <div class="image-container relative">
        <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223257/RevShop/b1_elce1n.jpg" alt="Summer Collection" class="w-full h-44 md:h-48 object-cover">
        <div class="heading-overlay absolute inset-0 flex flex-col justify-center items-center text-white">
            <h1 class="text-white text-3xl md:text-4xl font-bold">Your Shopping Cart</h1>
        </div>
    </div>
    
    <c:if test="${not empty sessionScope.errorMessage}">
	    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
	        <strong class="font-bold">Error:</strong>
	        <span class="block sm:inline">${sessionScope.errorMessage}</span>
	    </div>
	    <%-- Remove the error message from session after displaying --%>
	    <c:remove var="errorMessage" scope="session" />
	</c:if>
    
    
    <div class="container mx-auto py-8 px-4">

        <!-- If cart is empty, show message -->
        <c:if test="${empty cartItems}">
            <p class="text-center text-gray-500">Your cart is empty.</p>
        </c:if>

        <!-- If cart is not empty, show the items -->
        <c:if test="${not empty cartItems}">
            <div class="custom-grid">
                <c:forEach var="item" items="${cartItems}">
                    <div class="flex bg-white shadow-md rounded-lg overflow-hidden p-4 md:p-6">
                        <!-- Product Image -->
                        <div class="w-1/3 rounded-lg overflow-hidden">
                            <img src="${item.product.imageUrl}" alt="${item.product.name}" class="w-full h-48 object-cover">
                        </div>

                        <!-- Product Details -->
                        <div class="ml-4 w-2/3 flex flex-col justify-between">
                            <span class="block text-gray-600 font-semibold">${item.product.brand}</span>
                            <h5 class="text-lg font-bold">${item.product.name}</h5>
                            
                            <!-- Rating Stars -->
                            <div class="flex items-center mb-2">
                                <c:forEach var="star" begin="1" end="${item.product.rating}">
                                    <i class="fas fa-star text-yellow-500"></i>
                                </c:forEach>
                                <c:forEach var="emptyStar" begin="${item.product.rating + 1}" end="5">
                                    <i class="far fa-star text-gray-300"></i>
                                </c:forEach>
                            </div>

                            <!-- Quantity and Price -->
                            <%-- <p class="text-sm">Quantity: ${item.quantity + sessionScope.sessionQuantity}</p> --%>
                            <p class="text-sm font-bold">
							    Quantity: $
							    <c:choose>
							        <c:when test="${sessionScope.sessionQuantity != null}">
							            ${sessionScope.sessionQuantity}
							        </c:when>
							        <c:otherwise>
							            ${item.quantity}
							        </c:otherwise>
							    </c:choose>
							</p>
                            <p class="text-sm">Price: $${item.product.price}</p>
                            <%-- <p class="text-lg font-bold">Total: $${(item.product.price * item.quantity)* sessionScope.sessionQuantity }</p>
                            --%>
                            <p class="text-lg font-bold">
							    Total: $
							    <c:choose>
							        <c:when test="${sessionScope.sessionQuantity != null}">
							            ${item.product.price * item.quantity * sessionScope.sessionQuantity}
							        </c:when>
							        <c:otherwise>
							            ${item.product.price * item.quantity}
							        </c:otherwise>
							    </c:choose>
							</p>
                            
                            

                            <!-- Add/Remove Buttons -->
                            <div class="flex mt-4 space-x-2">
                            	<!-- Quantity Controls -->
                            <div class="flex items-center mb-3">
                                <form action="QuantityController" method="post" class="flex items-center">
                                    <input type="hidden" name="productId" value="${item.product.id}" />
                                    <input type="hidden" name="quantity" value="${item.quantity}" />
                                    <button type="submit" name="action" value="decrease" class="px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700">
                                        -
                                    </button>
                                    <c:choose>
							            <c:when test="${not empty sessionQuantity}">
							                <input type="hidden" name="quantity" value="${sessionQuantity}" />
							                <span class="mx-2 text-lg font-semibold">${sessionQuantity}</span>
							            </c:when>
							            <c:otherwise>
							                <input type="hidden" name="quantity" value="${item.quantity}" />
							                <span class="mx-2 text-lg font-semibold">${item.quantity}</span>
							            </c:otherwise>
							        </c:choose>
                                   <%--  <span class="mx-2 text-lg font-semibold">${item.quantity}</span> --%>
                                    <button type="submit" name="action" value="increase" class="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700">
                                        +
                                    </button>
                                </form>
                            </div>
                            	<%-- 
                                <form action="CartController" method="post" class="flex-grow">
                                    <input type="hidden" name="productId" value="${item.product.id}" />
                                    <input type="hidden" name="quantity" value="1" />
                                    <button type="submit" name="action" value="addToCart" class="w-full px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700">Add</button>
                                </form> --%>
                                <form action="CartController" method="post" class="flex-grow">
                                    <input type="hidden" name="productId" value="${item.product.id}" />
        							<input type="hidden" name="quantity" value="${item.quantity}" />
                                    <button type="submit" name="action" value="removeFromCart" class="w-full px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 flex justify-center items-center">
                                        <i class="fas fa-trash-alt mr-2"></i> Remove
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Total Amount Calculation -->
            <div class="mt-6 text-right">
                <%-- <p class="text-xl font-bold">Total Amount: $${totalAmount}</p> --%>
                <p class="text-xl font-bold">
				    Total Amount: $
				    <c:choose>
				        <c:when test="${sessionScope.sessionQuantity != null}">
				            ${totalAmount * sessionScope.sessionQuantity}
				        </c:when>
				        <c:otherwise>
				            ${totalAmount}
				        </c:otherwise>
				    </c:choose>
				</p>
				
                <%--<h3 class="text-md font-bold">Discounted Price (10% off): $${discountedPrice}</h3> --%>
                <h3 class="text-md font-bold">
				    Discounted Price (10% off):: $
				    <c:choose>
				        <c:when test="${sessionScope.sessionQuantity != null}">
				            ${(totalAmount * sessionScope.sessionQuantity) * 0.9}
				        </c:when>
				        <c:otherwise>
				            ${discountedPrice}
				        </c:otherwise>
				    </c:choose>
				</h3>
                
                <!-- Checkout Button -->
                <form action="${pageContext.request.contextPath}/views/buyer/placeOrderPage.jsp" method="post" class="mt-4">
                    <input type="hidden" name="totalAmount" value="${totalAmount}" />
                    <input type="hidden" name="discountedPrice" value="${discountedPrice}" />
                    <button type="submit" class="px-6 py-3 bg-blue-600 text-white rounded-md hover:bg-blue-700">Proceed to Checkout</button>
                </form>
            </div>
        </c:if>
    </div>
    
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</body>
</html>