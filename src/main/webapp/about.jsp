<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%-- Include header.jsp for the Navbar --%>
    <%@ include file="header.jsp" %>
    
    <div class="image-container relative">
	    <img src="https://res.cloudinary.com/dbleggv6z/image/upload/v1728223258/RevShop/b2_qnmjba.jpg" alt="Summer Collection" class="w-full h-44 md:h-48 object-cover">
	    <div class="heading-overlay absolute inset-0 flex flex-col justify-center items-center text-white">
	        <h1 class="text-white text-3xl md:text-4xl font-bold">About Us</h1>
	    </div>
	</div>
	
	<%-- Include footer.jsp for the Footer --%>
    <%@ include file="footer.jsp" %>
</body>
</html>