

package com.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.dao.CartDAO;
import com.dao.CartItemDAO;
import com.dao.ProductDAO;
import com.model.*;
import com.utility.DatabaseConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CartController")
public class CartController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Get parameters safely
        String productIdParam = request.getParameter("productId");
        String quantityParam = request.getParameter("quantity");

        if (productIdParam == null || quantityParam == null) {
            System.out.println("productId or quantity is null");
            response.sendRedirect("/errorPage.jsp");
            return;
        }

        int productId;
        int quantity;

        try {
            productId = Integer.parseInt(productIdParam);
            quantity = Integer.parseInt(quantityParam);
        } catch (NumberFormatException e) {
            System.out.println("Invalid number format for productId or quantity: " + e.getMessage());
            response.sendRedirect("/errorPage.jsp");
            return;
        }

        HttpSession session = request.getSession();
        Buyer buyer = (Buyer) session.getAttribute("buyer");

        if (buyer == null) {
            response.sendRedirect(request.getContextPath() + "/views/buyer/login.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO(DatabaseConnection.getConnection());
        CartItemDAO cartItemDAO = new CartItemDAO(DatabaseConnection.getConnection());

        Cart cart = null;

        try {
            cart = cartDAO.getCartByBuyerId(buyer.getId());
            if (cart == null) {
                cart = new Cart();
                cart.setBuyer(buyer);
                cart.setStatus("active");
                cartDAO.createCart(cart);
            }
            // Ensure the cart items list is initialized
            if (cart.getItems() == null) {
                cart.setItems(new ArrayList<>()); // Initialize items list if null
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving or creating cart: " + e.getMessage());
            response.sendRedirect("/errorPage.jsp");
            return;
        }

        if ("addToCart".equals(action)) {
        	try {
				addToCartMathod(request, response, cart, cartItemDAO, cartDAO, productId, quantity);
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
        if ("removeFromCart".equals(action)) {
        	try {
				removeFromCartMethod(request, response, cart, cartDAO, productId, quantity);
			} catch (Exception e) {
				e.printStackTrace();
			}
        }


        
    }

	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    Buyer buyer = (Buyer) session.getAttribute("buyer");

	    if (buyer == null) {
	        response.sendRedirect(request.getContextPath() + "/views/buyer/login.jsp");
	        return;
	    }

	    CartDAO cartDAO = new CartDAO(DatabaseConnection.getConnection());
	    Cart cart = null;

	    try {
	        cart = cartDAO.getCartByBuyerId(buyer.getId());
	        if (cart != null) {
	            cartDAO.loadCartItems(cart); // Load items into the cart
	            cart.calculateTotalPrice(); // Calculate total price after loading items
	            cart.calculateDiscountedPrice(0.10);
	            request.setAttribute("cartItems", cart.getItems()); // Pass items to the JSP
	            request.setAttribute("totalAmount", cart.getTotalPrice()); // Pass total price to the JSP
	            request.setAttribute("discountedPrice", cart.getDiscountedPrice());
	            
	            request.getSession().setAttribute("cartId", cart.getId());
	            request.getSession().setAttribute("cartItems", cart.getItems());
	            request.getSession().setAttribute("totalAmount", cart.getTotalPrice());
	            request.getSession().setAttribute("discountedPrice", cart.getDiscountedPrice());
	        } else {
	            request.setAttribute("message", "Your cart is empty.");
	        }
	    } catch (SQLException e) {
	        System.out.println("Error retrieving cart: " + e.getMessage());
	        response.sendRedirect("/errorPage.jsp");
	        return;
	    }

	    RequestDispatcher rd = request.getRequestDispatcher("views/buyer/cart.jsp");
	    rd.forward(request, response);
	}
	
	
////	add the data from the cart
	private void addToCartMathod(HttpServletRequest request, HttpServletResponse response, Cart cart,CartItemDAO cartItemDAO, CartDAO cartDAO, int productId, int quantity) throws ServletException, IOException {
		Product product = new ProductDAO(DatabaseConnection.getConnection()).getProductById(productId);
        boolean itemExists = false;

        // Check if the item exists in the cart
        for (CartItem item : cart.getItems()) {
            if (item.getProduct().getId() == productId) {
                item.setQuantity(item.getQuantity() + quantity);
                try {
                    cartItemDAO.updateCartItem(item);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                itemExists = true;
                break;
            }
        }

        if (!itemExists) {
            // Add new item to the cart and save to DB
            CartItem newItem = new CartItem(cart, product, quantity);
            cart.getItems().add(newItem);
            try {
                cartItemDAO.addCartItem(newItem);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Recalculate cart totals and discounted prices
        cart.calculateTotalPrice();
        cart.calculateDiscountedPrice(0.10);  // Example 10% discount

        // Update cart in DB
        try {
            cartDAO.updateCart(cart);  // Save updated cart totals in DB
        } catch (SQLException e) {
            System.out.println("Error updating cart: " + e.getMessage());
            response.sendRedirect("/errorPage.jsp");
            return;
        }

        request.setAttribute("message", "Product added to cart successfully.");
        response.sendRedirect(request.getContextPath() + "/ProductController?action=viewProducts");
	}
	
	
	
//	protected void addToCartMathod(HttpServletRequest request, HttpServletResponse response, Cart cart, CartItemDAO cartItemDAO, CartDAO cartDAO, int productId, int quantity) throws IOException, SQLException {
//	    ProductDAO productDAO = new ProductDAO(DatabaseConnection.getConnection());
//	    Product product = productDAO.getProductById(productId); // Get the product details
//
//	    // Check if the quantity in cart exceeds the stock
//	    CartItem existingItem = cartItemDAO.getCartItemByProductId(cart.getId(), productId);
//	    int newQuantity = quantity;
//	    
//	    if (existingItem != null) {
//	        newQuantity += existingItem.getQuantity();
//	    }
//
//	    if (newQuantity > product.getQuantity()) {
//	        System.out.println("Cannot add more items than available in stock");
//	        response.sendRedirect("cart.jsp?error=OutOfStock"); // Redirect to the cart page with an error
//	        return;
//	    }
//
//	    // Proceed to add item to cart
//	    if (existingItem == null) {
//	        // Add new item to cart
//	        CartItem newItem = new CartItem(cart, product, quantity);
//	        cartItemDAO.addCartItem(newItem);
//	    } else {
//	        // Update quantity of existing item
//	        existingItem.setQuantity(newQuantity);
//	        cartItemDAO.updateCartItem(existingItem);
//	    }
//
//	    cart.calculateTotalPrice(); // Recalculate cart total
//	    response.sendRedirect("CartController"); // Redirect to cart after adding
//	}


	
	
//	remove the data from the cart
	private void removeFromCartMethod(HttpServletRequest request, HttpServletResponse response, Cart cart,
		CartDAO cartDAO, int productId, int quantity)throws ServletException, IOException, SQLException {
		System.out.println("Removing item from cart");
	    CartItemDAO cartItemDAO = new CartItemDAO(DatabaseConnection.getConnection());

	    // Find the cart item by product ID
	    CartItem cartItem = cartItemDAO.getCartItemByProductId(cart.getId(), productId);
	    
	    if (cartItem != null) {
	        // Remove item from the cart
	        cart.getItems().remove(cartItem);
	        
	        try {
	            cartItemDAO.deleteCartItem(cartItem.getId()); // Add this method to CartItemDAO
	            System.out.println("Product removed from cart");
	        } catch (SQLException e) {
	            System.out.println("Error removing item from cart: " + e.getMessage());
	        }
	        
	        // Recalculate total price after removal
	        cart.calculateTotalPrice();
	        cart.calculateDiscountedPrice(0.10);  // Example 10% discount
	        
	        try {
	            cartDAO.updateCart(cart);  // Save updated cart totals in DB
	        } catch (SQLException e) {
	            System.out.println("Error updating cart: " + e.getMessage());
	            response.sendRedirect("/errorPage.jsp");
	            return;
	        }
	        
	        request.setAttribute("message", "Product removed from cart successfully.");
	    } else {
	        request.setAttribute("message", "Product not found in cart.");
	    }
	    
	    response.sendRedirect(request.getContextPath() + "/CartController");
		
	}


}
