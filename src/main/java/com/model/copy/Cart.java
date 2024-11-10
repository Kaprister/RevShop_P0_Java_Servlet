package com.model.copy;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Cart {
    private int id;
    private Buyer buyer;
    private Timestamp createdAt;
    private String status;  // Status of the cart (e.g., 'active', 'completed')
    private double totalPrice;  // Total price of items in the cart
    private double discountedPrice;  // Discounted price, if any
    private List<CartItem> items;  // List of items in the cart

    // Constructors
//    public Cart() { }

    public Cart(int id) {
        this.id = id;
    }
    
    public Cart() {
        this.items = new ArrayList<>(); // Initialize items as an empty list
    }

    public Cart(int id, Buyer buyer, Timestamp createdAt, String status, double totalPrice, double discountedPrice) {
        this.id = id;
        this.buyer = buyer;
        this.createdAt = createdAt;
        this.status = status;
        this.totalPrice = totalPrice;
        this.discountedPrice = discountedPrice;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Buyer getBuyer() {
        return buyer;
    }

    public void setBuyer(Buyer buyer) {
        this.buyer = buyer;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public double getDiscountedPrice() {
        return discountedPrice;
    }

    public void setDiscountedPrice(double discountedPrice) {
        this.discountedPrice = discountedPrice;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

//    // Method to calculate the total price of the cart
//    public void calculateTotalPrice() {
//        this.totalPrice = 0;
//        if (items != null) {
//            for (CartItem item : items) {
//                this.totalPrice += item.getQuantity() * item.getProduct().getPrice();
//            }
//        }
//    }
    
 // Method to calculate the total price of the cart
    public void calculateTotalPrice() {
        this.totalPrice = 0;
        if (items != null) {
            for (CartItem item : items) {
                this.totalPrice += item.getTotalPrice(); // Use getTotalPrice() for CartItem
            }
        }
    }

    // Method to calculate the discounted price of the cart
    public void calculateDiscountedPrice(double discountRate) {
//        this.discountedPrice = totalPrice * (1 - discountRate);
        double price = totalPrice * (1 - discountRate);
        // Round down to two decimal places
        this.discountedPrice = Math.floor(price * 100) / 100; // This gives you a double
    }
}
