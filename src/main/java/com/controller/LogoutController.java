package com.controller;


import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.*;

@WebServlet("/Logout")
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Invalidate the session to log the user out
		HttpSession session = request.getSession(); // Get the session if it exists, don't create a new one
		if(session != null) {
			// Invalidate the session
			session.invalidate(); 
		}
		
		// Redirect to the homepage or login page after logout
		response.sendRedirect(request.getContextPath() + "/index.jsp");
	}
}
