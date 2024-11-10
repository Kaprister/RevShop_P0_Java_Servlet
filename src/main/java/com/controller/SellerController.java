package com.controller;

import com.dao.SellerDAO;
import com.model.Product;
import com.model.Seller;
import com.utility.DatabaseConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SellerController")
public class SellerController extends HttpServlet {
	private SellerDAO sellerDAO;
	
	public void init() {
		Connection connection = DatabaseConnection.getConnection();
		sellerDAO = new SellerDAO(connection);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action.equals("register")) {
			registerSeller(request, response);
		}else if(action.equals("login")) {
			loginSeller(request, response);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if(action.equals("sold_products")) {
			getSoldProductsBySellerId(request, response);
		}
	}
	


	private void registerSeller(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String bussinessName = request.getParameter("business_name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		
		Seller seller = new Seller(bussinessName, email, password, name);
		
		if(sellerDAO.registerSeller(seller)) {
			response.sendRedirect(request.getContextPath() + "/views/seller/login.jsp");
		}else {
			System.out.println("error while registring the seller : ");
			request.setAttribute("errorMessage", "Registration failed");
			RequestDispatcher rd = request.getRequestDispatcher(request.getContextPath() + "/views/seller/register.jsp");
			rd.forward(request, response);
		}
		
	}
	
    private void loginSeller(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Seller seller = sellerDAO.loginSeller(email, password);
        if (seller != null) {
            HttpSession session = request.getSession();
            session.setAttribute("seller", seller);
            response.sendRedirect(request.getContextPath() + "/views/products/add_product.jsp");
        } else {
        	System.out.println("error while login the user : ");
            request.setAttribute("errorMessage", "Invalid credentials");
            RequestDispatcher rd = request.getRequestDispatcher(request.getContextPath() + "/views/seller/login.jsp");
            rd.forward(request, response);
        }
    }
    

    private void getSoldProductsBySellerId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> soldProducts = new ArrayList<>();
        
        try {
            HttpSession session = request.getSession();
            Seller seller = (Seller) session.getAttribute("seller");
            if (seller == null) {
                response.sendRedirect(request.getContextPath() + "/views/seller/login.jsp");
                return;
            }
            int sellerId = seller.getId();

            soldProducts = sellerDAO.getSoldProductsBySellerId(sellerId);
            if (soldProducts.isEmpty()) {
                request.setAttribute("message", "No sold products found for this seller.");
            } else {
                request.setAttribute("soldProducts", soldProducts);
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/products/sold_products.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while retrieving sold products.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/error.jsp");
            dispatcher.forward(request, response);
        }
    }
    
}
