package com.dao;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.Product;
import com.model.Seller;

public class SellerDAO {
	private Connection connection;
	
	public SellerDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean registerSeller(Seller seller) {
		String query = "INSERT INTO Seller (business_name, email, password, name) VALUES (?, ?, ?, ?)";
		try(PreparedStatement ps = connection.prepareStatement(query)){
			ps.setString(1,  seller.getBusinessName());
			ps.setString(2,  seller.getEmail());
			ps.setString(3,  seller.getPassword());
			ps.setString(4, seller.getName());
			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("error while seller registring seller : " +  e);
			return false;
		}
	}
	
	public Seller loginSeller(String email, String password) {
		String query = "SELECT * FROM Seller WHERE email = ? AND password = ?";
		try(PreparedStatement ps = connection.prepareStatement(query)){
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return new Seller(rs.getInt("id"), rs.getString("business_name"), rs.getString("email"), rs.getString("password"), rs.getString("name"));
			}
		}catch(SQLException e) {
			System.out.println("error while seller registring Dao : " + e);
			e.printStackTrace();
		}
		return null;
	}
	
	// Method to get sold products for a specific seller
    public List<Product> getSoldProductsBySellerId(int sellerId) {
        List<Product> soldProducts = new ArrayList<>();
        String sql = "SELECT DISTINCT p.id, p.name, p.description, p.price, p.quantity, p.seller_id, p.brand, p.image_url, p.rating " +
                     "FROM orders o " +
                     "JOIN Product p ON o.product_id = p.id " +
                     "WHERE p.seller_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, sellerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product product = new Product(rs.getInt("id"));
                		product.setName(rs.getString("name"));
                		product.setDescription(rs.getString("description"));
                		product.setPrice(rs.getDouble("price"));
                		product.setQuantity(rs.getInt("quantity"));
                		product.setBrand(rs.getString("brand"));
                		product.setSellerId(rs.getInt("seller_id"));
                		product.setImageUrl(rs.getString("image_url"));
                		product.setRating(rs.getInt("rating"));
                        
                
                soldProducts.add(product);
            }
        } catch (SQLException e) {
        	System.out.println("Error inside getSoldProductsBySellerId : " + e);
            e.printStackTrace();
        }
        return soldProducts;
    }
}
