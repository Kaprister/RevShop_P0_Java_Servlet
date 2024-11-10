package com.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.model.Cart;
import com.model.CartItem;
import com.model.Product;
import com.model.Buyer;

public class CartDAO {
	private Connection connection;
	
	public CartDAO(Connection connection) {
		this.connection = connection;
	}

    // Check if the buyer exists before creating a cart
    private boolean doesBuyerExist(int buyerId) throws SQLException {
        String query = "SELECT COUNT(*) FROM buyer WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, buyerId);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0; // Buyer exists if count > 0
        }
        return false;
    }
    
    // Get Buyer object by ID
    private Buyer getBuyerById(int buyerId) throws SQLException {
        String query = "SELECT * FROM buyer WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, buyerId);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            Buyer buyer = new Buyer();
            buyer.setId(rs.getInt("id"));
            buyer.setName(rs.getString("name"));  // Assuming you have a name field in Buyer
            return buyer;
        }
        return null;
    }
	
	public Cart getCartByBuyerId(int buyerId) throws SQLException {
        // Get buyer details
        Buyer buyer = getBuyerById(buyerId);
        if (buyer == null) {
            throw new SQLException("Buyer not found with ID: " + buyerId);
        }

		String query = "SELECT * FROM cart WHERE buyer_id = ?";
		PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, buyerId);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            // Use the correct constructor, passing the Buyer object
            Cart cart = new Cart(rs.getInt("id"), buyer, rs.getTimestamp("created_at"), rs.getString("status"), rs.getDouble("total_price"), rs.getDouble("discounted_price"));
            return cart;
        }
        return null;
	}
	
	public void createCart(Cart cart) throws SQLException {
        // Check if buyer exists before creating cart
        if (!doesBuyerExist(cart.getBuyer().getId())) {
            throw new SQLException("Cannot create cart: Buyer does not exist.");
        }

        String query = "INSERT INTO cart (buyer_id, created_at, status) VALUES (?, NOW(), ?)";
        PreparedStatement statement = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        statement.setInt(1, cart.getBuyer().getId());
        statement.setString(2, cart.getStatus());
        statement.executeUpdate();

        ResultSet rs = statement.getGeneratedKeys();
        if (rs.next()) {
            cart.setId(rs.getInt(1));
        }
	}
    
    // Update cart method to save totals
    public void updateCart(Cart cart) throws SQLException {
        String query = "UPDATE cart SET total_price = ?, discounted_price = ? WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setDouble(1, cart.getTotalPrice());
        statement.setDouble(2, cart.getDiscountedPrice());
        statement.setInt(3, cart.getId());
        statement.executeUpdate();
    }
    
    // Update cart method to save totals
    public void removeCartItemById(int cartId) throws SQLException {
        String query = "DELETE FROM cart WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, cartId);
        statement.executeUpdate();
    }
    
    public void loadCartItems(Cart cart) throws SQLException {
        String query = "SELECT * FROM cart_item WHERE cart_id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, cart.getId());
        ResultSet rs = statement.executeQuery();
        List<CartItem> items = new ArrayList<CartItem>();


        while (rs.next()) {
            Product product = new ProductDAO(connection).getProductById(rs.getInt("product_id")); // Assuming you have this method
            int quantity = rs.getInt("quantity");
            CartItem item = new CartItem(cart, product, quantity);
            items.add(item);
        }
        cart.setItems(items);
    }
}
