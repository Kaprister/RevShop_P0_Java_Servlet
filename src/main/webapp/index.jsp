<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home Page</title>
    <%-- Link the home.css file --%>
    <link rel="stylesheet" type="text/css" href="static/css/home.css">
    <link rel="stylesheet" 
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
    
</head>
<body>

    <%-- Include header.jsp for the Navbar --%>
    <%@ include file="header.jsp" %>

    <%-- Include main.jsp for the Main Content --%>
    <%@ include file="main.jsp" %>
    
    
	 <%@ include file="banner.jsp" %> 

    <%-- Include footer.jsp for the Footer --%>
    <%@ include file="footer.jsp" %>
    

</body>
</html>
