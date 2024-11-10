package com.dao;

import com.model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {
	
	private Connection connection;
	
	public OrderDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean placeOrder(Order order) {
	    String sql = "INSERT INTO Orders (buyer_id, product_id, quantity, total_amount, address, order_date, order_status, order_type, image_url, discounted_price) VALUES (?, ?, ?, ?, ?, NOW(), ?, ?, ?, ?)";
	    
	    try (PreparedStatement st = connection.prepareStatement(sql)) {
	        st.setInt(1, order.getBuyerId());
	        st.setInt(2, order.getProductId());
	        st.setInt(3, order.getQuantity());
	        st.setDouble(4, order.getTotalAmount());
	        st.setString(5, order.getAddress());
	        st.setString(6, order.getOrderStatus());
	        st.setString(7, order.getOrderType());
	        st.setString(8, order.getImageUrl());
	        st.setDouble(9, order.getDiscountedPrice());
	        
	        
	        
	        int rowsAffected = st.executeUpdate();
	        return rowsAffected > 0;
	    } catch (SQLException e) {
	        System.out.println("Error in placeOrder orderDao! SQLState: " + e.getSQLState());
	        System.out.println("Error Code: " + e.getErrorCode());
	        System.out.println("Message: " + e.getMessage());
	        System.out.println("SQL Query: " + sql);
	        System.out.println("Values: " + order.getBuyerId() + ", " + order.getProductId() + ", " + order.getQuantity() + ", " +
	            order.getTotalAmount() + ", " + order.getAddress() + ", " + order.getOrderStatus() + ", " + order.getOrderType());
	        return false;
	    }
	}
	
	public List<Order> getOrdersByBuyerId(int BuyerId){
		String query = "SELECT * FROM Orders WHERE buyer_id = ?";
		List<Order> orders = new ArrayList<>();
		
		try(PreparedStatement st = connection.prepareStatement(query)) {
			st.setInt(1, BuyerId);
			ResultSet rs = st.executeQuery();
			while(rs.next()) {
				 Order order = new Order(
			                rs.getInt("buyer_id"),
			                rs.getInt("product_id"),
			                rs.getInt("quantity"),
			                rs.getDouble("total_amount"),
			                rs.getString("address"),
			                rs.getString("order_type"),
			                rs.getString("order_status"),
			                rs.getString("image_url"),
			                rs.getDouble("discounted_price")
			            );
			            order.setId(rs.getInt("id"));
			            order.setOrderDate(rs.getDate("order_date"));
			            orders.add(order);
			}
		}catch(SQLException e) {
			System.out.println("Error while getting the data from database : getOrderByBuyerId : " + e);
			e.printStackTrace();
		}
		return orders;
	}

}
