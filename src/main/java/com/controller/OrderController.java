package com.controller;

import com.model.CartItem;
import com.model.Order;
import com.utility.DatabaseConnection;
import com.dao.*;

import jakarta.servlet.http.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/OrderController") 
public class OrderController extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        // Initialize the DAO with a database connection
        Connection connection = DatabaseConnection.getConnection();
        orderDAO = new OrderDAO(connection);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the form
        String address = request.getParameter("address");
        String orderType = request.getParameter("orderType");
        String totalAmountParam = request.getParameter("totalAmount");  // Get the totalAmount as a String
        String discountedPriceParam = request.getParameter("discountedPrice");
        System.out.println("Inside doPost of OrderController: " + address + " : " + orderType + " " + totalAmountParam);

        // Check if totalAmount is null or empty to prevent NumberFormatException
        if (totalAmountParam == null || totalAmountParam.isEmpty()) {
            System.out.println("Amount parameter is null");
            request.setAttribute("message", "Total amount is required!");
            request.getRequestDispatcher("/ProductController?action=viewProducts").forward(request, response);
            return;
        }
        System.out.println("Amount found");

        // Parse the total amount
        double totalAmount;
        double discountedPrice;
        try {
            totalAmount = Double.parseDouble(totalAmountParam);
            discountedPrice = Double.parseDouble(discountedPriceParam);
            System.out.println("Amount parsed to double");
        } catch (NumberFormatException e) {
            // Handle invalid number format
            System.out.println("Invalid total amount format");
            request.setAttribute("message", "Invalid total amount format!");
            request.getRequestDispatcher("/ProductController?action=viewProducts").forward(request, response);
            return;
        }

        // Retrieve buyerId from session
        Integer buyerId = (Integer) request.getSession().getAttribute("buyerId");
        if (buyerId == null) {
            // If the buyer is not logged in, redirect to login page
            System.out.println("Buyer ID not found");
            response.sendRedirect(request.getContextPath() + "/views/buyer/login.jsp");
            return;
        }

        // Retrieve cart items from the session
        Object cartItemsObj = request.getSession().getAttribute("cartItems");
        List<CartItem> cartItems = null;
    

        if (cartItemsObj instanceof List) {
            cartItems = (List<CartItem>) cartItemsObj;
        } else {
            System.out.println("cartItems is not a List: " + cartItemsObj);
            request.setAttribute("message", "No items in the cart to order!");
            request.getRequestDispatcher("/ProductController?action=viewProducts").forward(request, response);
            return;
        }

        if (cartItems.isEmpty()) {
            System.out.println("No items in the cart");
            request.setAttribute("message", "No items in the cart to order!");
            request.getRequestDispatcher("/ProductController?action=viewProducts").forward(request, response);
            return;
        }

        System.out.println("Found buyer ID: " + buyerId);
        
        // Loop through each cart item and create an order for each
        for (CartItem cartItem : cartItems) {
            int productId = cartItem.getProduct().getId(); 
            int quantity = cartItem.getQuantity();
            
            // Create a new order object
            Order order = null;
            if(orderType.equals("Cash on Delivery")) {
            	order = new Order(buyerId, productId, quantity, cartItem.getTotalPrice(), address, orderType, "Completed", cartItem.getProduct().getImageUrl(), discountedPrice); 
            }else {
            	order = new Order(buyerId, productId, quantity, cartItem.getTotalPrice(), address, orderType, cartItem.getProduct().getImageUrl(), discountedPrice);             	
            }

            // Place order and handle success or failure
            if (!orderDAO.placeOrder(order)) {
                System.out.println("Order for product ID " + productId + " failed, redirecting back to products page with error message");
                request.setAttribute("message", "Order not placed for product ID " + productId + ". Try again!");
                request.getRequestDispatcher("/ProductController?action=viewProducts").forward(request, response);

                // Remove cartItems and cart from the session
                request.getSession().setAttribute("cartItems", null);
                request.getSession().setAttribute("cartId", null); 
                
                return; // Stop further processing if any order fails
            }else {
            	CartDAO cartDAO = new CartDAO(DatabaseConnection.getConnection());
            	Integer cartId = (Integer) request.getSession().getAttribute("cartId");
            	try {
					cartDAO.removeCartItemById(cartId);
				} catch (SQLException e) {
					e.printStackTrace();
				} 
            }
        }
        
        if(orderType.equals("Online Payment")) {
        	response.sendRedirect(request.getContextPath() + "/payment_gateway.jsp");    
        	return;
        }

        // If all orders are successfully placed, redirect to confirmation page
        System.out.println("All orders placed successfully, redirecting to confirmation page");
        response.sendRedirect(request.getContextPath() + "/views/buyer/orderConfirmation.jsp");
    }
    
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Integer buyerId = (Integer) request.getSession().getAttribute("buyerId");
    	if (buyerId == null) {
            // If the buyer is not logged in, redirect to login page
            response.sendRedirect(request.getContextPath() + "/views/buyer/login.jsp");
            return;
        }
    	
    	 // Fetch the orders of the buyer
        List<Order> orderHistory = orderDAO.getOrdersByBuyerId(buyerId);
        request.setAttribute("orderHistory", orderHistory);
        
        request.getRequestDispatcher("/views/buyer/orderHistory.jsp").forward(request, response);
    	
    }

}
