package com.controller;

import com.dao.ProductDAO;
import com.model.Product;
import com.model.Seller;
import com.utility.DatabaseConnection;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/ProductController") // Ensure this URL pattern matches your form action
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductDAO productDAO;

    @Override
    public void init() {
        Connection connection = DatabaseConnection.getConnection();
        productDAO = new ProductDAO(connection);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("addProduct")) {
            addProduct(request, response);
        }else if(action.equals("removeProduct")) {
        	removeProductByProductId(request, response);
        }else if(action.equals("updateProduct")) {
        	updateProduct(request, response);
        }
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("editProduct")) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Product product = productDAO.getProductById(productId);
            request.setAttribute("product", product);
            RequestDispatcher rd = request.getRequestDispatcher( "/views/products/edit_product.jsp");
            rd.forward(request, response);
        } else if (action != null && action.equals("viewProducts")) {
            listAllProductsForBuyer(request, response);
        } else {
            listProductsForSeller(request, response);
        }
    }
    
    
    
    // Method to list products for a seller
    private void listProductsForSeller(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");
        
        if (seller == null) {
            System.out.println("No seller logged in.");
            response.sendRedirect("views/seller/login.jsp");
            return;
        }        
        List<Product> products = productDAO.getProductsBySeller(seller.getId());
        request.setAttribute("products", products);
        
        RequestDispatcher rd = request.getRequestDispatcher("/views/products/list_products.jsp");
        rd.forward(request, response);
    }
    
    
 // Method to list all products for buyers
    private void listAllProductsForBuyer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<Product> productList = productDAO.getAllProducts();
    	request.setAttribute("products", productList);
  
        RequestDispatcher dispatcher = request.getRequestDispatcher("/home.jsp");
        dispatcher.forward(request, response);
    }
    
//    add product
    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");

        // Check if seller is logged in
        if (seller == null) {
            response.sendRedirect("views/seller/login.jsp");
            return;
        }

        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price")); 
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String brand = request.getParameter("brand");
        String imageUrl = request.getParameter("imageUrl");
        int rating = Integer.parseInt(request.getParameter("rating"));

        Product product = new Product(name, description, price, quantity, seller.getId(), brand, imageUrl, rating);
        if (productDAO.addProduct(product)) {
            response.sendRedirect(request.getContextPath() + "/ProductController");
        } else {
            request.setAttribute("errorMessage", "Product creation failed");
            RequestDispatcher rd = request.getRequestDispatcher("views/products/add_product.jsp");
            rd.forward(request, response);
        }
    }
    
    
//    remove product by id
    private void removeProductByProductId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");
        
        if (seller == null) {
            System.out.println("No seller logged in.");
            response.sendRedirect("views/seller/login.jsp");
            return;
        }
        
        System.out.println("Seller Found : " + seller);
        
        // Get product ID from request
        int productId = Integer.parseInt(request.getParameter("productId"));
        System.out.println("Id found : " + productId);
        if(!productDAO.removeProductById(productId)) {
        	System.out.println("Cannot be able to remove data! ");
        	request.setAttribute("errorMessage", "Product removal failed");
            RequestDispatcher rd = request.getRequestDispatcher("/views/products/list_products.jsp");
            rd.forward(request, response);
            return;
        }
        // Redirect or forward to the product list after removal
        System.out.println("successfull to remove data! ");
        response.sendRedirect( request.getContextPath() + "/ProductController"); 
 
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Seller seller = (Seller) session.getAttribute("seller");

        if (seller == null) {
            response.sendRedirect("views/seller/login.jsp");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String brand = request.getParameter("brand");
        String imageUrl = request.getParameter("imageUrl");
        int rating = Integer.parseInt(request.getParameter("rating"));

        Product product = new Product(productId, name, description, price, quantity, seller.getId(), brand, imageUrl, rating);
        if (productDAO.updateProduct(product)) {
            response.sendRedirect( request.getContextPath() + "/ProductController");
        } else {
            request.setAttribute("errorMessage", "Product update failed");
            RequestDispatcher rd = request.getRequestDispatcher("views/products/edit_product.jsp");
            rd.forward(request, response);
        }
    }

    
    
    
    
    
    
}
