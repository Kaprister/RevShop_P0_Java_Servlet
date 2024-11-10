package com.controller;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import java.sql.Connection;
import com.dao.ProductDAO;
import com.model.Product;
import com.utility.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/QuantityController")
public class QuantityController extends HttpServlet {

    private ProductDAO productDAO;

    public void init() {
        Connection connection = DatabaseConnection.getConnection();
        productDAO = new ProductDAO(connection);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = 0;

//        System.out.println("action : " + action);
        
        // Retrieve sessionQuantity as an Integer
        Integer sessionQuantity = (Integer) session.getAttribute("sessionQuantity");
        
        if (sessionQuantity == null) {
            // If sessionQuantity is null, get quantity from request
            quantity = Integer.parseInt(request.getParameter("quantity"));
//            System.out.println("quantity : " + quantity);
        } else {
            // Use sessionQuantity directly
            quantity = sessionQuantity;
//            System.out.println("quant : " + quantity + " quantity : " + quantity);
        }

        Product product = productDAO.checkProductQuantity(productId); // Find the product by its ID
//        System.out.println("prod quan : " + product.getQuantity());
        
        int inQuan = quantity + 1;
        if (action.equals("increase")) {
            if (inQuan > product.getQuantity()) {
                session.setAttribute("errorMessage", "Not enough stock available for " + product.getName());
            } else {
                session.setAttribute("sessionQuantity", inQuan);
            }
        }
        
        int deQuan = quantity - 1;
        if (action.equals("decrease")) {
            if (quantity - 1 < 1) {
                session.setAttribute("errorMessage", "Quantity cannot be less than 1 for " + product.getName());
            } else {
                session.setAttribute("sessionQuantity", deQuan);
            }
        }

        response.sendRedirect(request.getContextPath() + "/CartController"); // Redirect back to the cart
    }
}
