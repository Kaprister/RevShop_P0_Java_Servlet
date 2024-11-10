package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.Product;

public class ProductDAO {
    private Connection connection;
    
    public ProductDAO(Connection connection) {
        this.connection = connection;
    }
    
    public boolean addProduct(Product product) {
        // Check if the seller exists before adding the product
        if (!doesSellerExist(product.getSellerId())) {
            System.out.println("Error: Seller with ID " + product.getSellerId() + " does not exist.");
            return false;
        }

        String query = "INSERT INTO Product (name, description, price, quantity, seller_id, brand, image_url, rating) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setInt(5, product.getSellerId());
            ps.setString(6, product.getBrand());
            ps.setString(7, product.getImageUrl());
            ps.setInt(8, product.getRating());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error in ProductDAO when addProduct: " + e);
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Product> getProductsBySeller(int sellerId) {
        String query = "SELECT * FROM Product WHERE seller_id = ?";
        List<Product> products = new ArrayList<>();
        System.out.println("hello getProductsBySeller");
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                products.add(new Product(
                	rs.getInt("id"),
                    rs.getString("name"), 
                    rs.getString("description"),
                    rs.getDouble("price"), 
                    rs.getInt("quantity"), 
                    rs.getInt("seller_id"),
                    rs.getString("brand"),
                    rs.getString("image_url"),
                    rs.getInt("rating")
                ));
            }
        } catch (SQLException e) {
            System.out.println("Error in ProductDAO when getProductsBySeller: " + e);
            e.printStackTrace();
        }
//        System.out.println("Products : " + products);
        return products;
    }
    
    private boolean doesSellerExist(int sellerId) {
        String query = "SELECT COUNT(*) FROM seller WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Return true if seller exists
            }
        } catch (SQLException e) {
            System.out.println("Error in ProductDAO when checking seller existence: " + e);
            e.printStackTrace();
        }
        return false; // Return false if there's an error or seller doesn't exist
    }
    
    public List<Product> getAllProducts(){
    	List<Product> products = new ArrayList<>();
    	String query = "SELECT * FROM Product";
    	
    	try(PreparedStatement ps = connection.prepareStatement(query)){
    		ResultSet rs = ps.executeQuery();
    		while(rs.next()) {
    			Product product = new Product();
    			product.setId(rs.getInt("id"));
    			product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setBrand(rs.getString("brand"));
                product.setImageUrl(rs.getString("image_url"));
                product.setRating(rs.getInt("rating"));
             // Add more fields like image URL if necessary
                products.add(product);
    		}
    	} catch (SQLException e) {
    		System.out.println("Error while getting all products from database");
    		e.printStackTrace();
    	}
//    	System.out.println(products);
    	return products;
    }
    
    public Product getProductById(int productId) {
    	Product product = null;
    	String query = "SELECT * FROM Product WHERE id = ?";
    	try(PreparedStatement ps = connection.prepareStatement(query)){
    		ps.setInt(1, productId);
    		ResultSet rs = ps.executeQuery();
    		

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setBrand(rs.getString("brand"));
                product.setImageUrl(rs.getString("image_url"));
                product.setRating(rs.getInt("rating"));
            }
            
    	}catch (SQLException e) {
    		System.out.println("Error while getting products by id from database : " + e);
            e.printStackTrace();
        }
    	return product;
    }
    
    public boolean removeProductById(int productId) {
    	String query = "DELETE FROM Product WHERE id = ?";
    	try(PreparedStatement ps = connection.prepareStatement(query)){
    		ps.setInt(1, productId);
    		int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
    	}catch (SQLException e) {
    		System.out.println("Error while getting products by id from database : " + e);
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateProduct(Product product) {
        String query = "UPDATE Product SET name = ?, description = ?, price = ?, quantity = ?, brand = ?, image_url = ?, rating = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, product.getName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setString(5, product.getBrand());
            ps.setString(6, product.getImageUrl());
            ps.setInt(7, product.getRating());
            ps.setInt(8, product.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error in ProductDAO when updateProduct: " + e);
            e.printStackTrace();
            return false;
        }
    }
    
    
    public Product checkProductQuantity(int productId) {
    	Product product = null;
    	String query = "SELECT * FROM Product WHERE id = ?";
    	try(PreparedStatement ps = connection.prepareStatement(query)){
    		ps.setInt(1, productId);
    		ResultSet rs = ps.executeQuery();
    		

            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(rs.getDouble("price"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSellerId(rs.getInt("seller_id"));
                product.setBrand(rs.getString("brand"));
                product.setImageUrl(rs.getString("image_url"));
                product.setRating(rs.getInt("rating"));
            }
            
    	}catch (SQLException e) {
    		System.out.println("Error while getting products by id from database : " + e);
            e.printStackTrace();
        }
    	return product;
    }

    
    
}
