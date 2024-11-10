package com.controller;

import com.dao.BuyerDAO;
import com.model.Buyer;
import com.utility.DatabaseConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.*;


@WebServlet("/BuyerController")
public class BuyerController extends HttpServlet {
    private BuyerDAO buyerDAO;

    public void init() {
        Connection connection = DatabaseConnection.getConnection();
        buyerDAO = new BuyerDAO(connection);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("register")) {
            registerBuyer(request, response);
        } else if (action.equals("login")) {
            loginBuyer(request, response);
        }
    }

    private void registerBuyer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        Buyer buyer = new Buyer(name, email, password, address);
        if (buyerDAO.registerBuyer(buyer)) {
            response.sendRedirect(request.getContextPath() + "/views/buyer/login.jsp");
        } else {
        	System.out.println("error while registring the user : ");
            request.setAttribute("errorMessage", "Registration failed");
            RequestDispatcher rd = request.getRequestDispatcher("/views/buyer/register.jsp");
            rd.forward(request, response);
            
        }
    }

    private void loginBuyer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Buyer buyer = buyerDAO.loginBuyer(email, password);
        if (buyer != null) {
            HttpSession session = request.getSession();
            session.setAttribute("buyer", buyer);
            session.setAttribute("buyerId", buyer.getId());
         // Redirect the buyer to the home page where all products will be listed
            response.sendRedirect(request.getContextPath() + "/ProductController?action=viewProducts");
        } else {
            request.setAttribute("errorMessage", "Invalid credentials");
            RequestDispatcher rd = request.getRequestDispatcher("/views/buyer/login.jsp");
            rd.forward(request, response);
        }
    }
}
