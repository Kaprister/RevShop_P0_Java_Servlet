package com.dao;

import java.sql.*;

import com.model.Cart;
import com.model.CartItem;
import com.model.Product;

public class CartItemDAO {
    private Connection connection;

    public CartItemDAO(Connection connection) {
        this.connection = connection;
    }

    public CartItem getCartItemByProductId(int cartId, int productId) throws SQLException {
        String query = "SELECT * FROM cart_item WHERE cart_id = ? AND product_id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, cartId);
        statement.setInt(2, productId);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            return new CartItem(rs.getInt("id"), new Cart(cartId), new Product(productId), rs.getInt("quantity"));
        }
        return null;
    }
    
    

    public void addCartItem(CartItem item) throws SQLException {
        String query = "INSERT INTO cart_item (cart_id, product_id, quantity) VALUES (?, ?, ?)";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, item.getCart().getId());
        statement.setInt(2, item.getProduct().getId());
        statement.setInt(3, item.getQuantity());
        statement.executeUpdate();
    }
    

    public void updateCartItem(CartItem item) throws SQLException {
        String query = "UPDATE cart_item SET quantity = ? WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, item.getQuantity());
        statement.setInt(2, item.getId());
        statement.executeUpdate();
    }
    
    public void deleteCartItem(int cartItemId) throws SQLException {
        String query = "DELETE FROM cart_item WHERE id = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setInt(1, cartItemId);
        statement.executeUpdate();
    }

    
}

