package com.model.copy;


import java.util.Date;

public class Order {
    private int id;
    private int buyerId;
    private int productId;
    private int quantity;
    private double totalAmount;
    private String address;
    private Date orderDate;
    private String orderStatus;
    private String orderType;

    // Constructors, getters, and setters
    public Order(int buyerId, int productId, int quantity, double totalAmount, String address, String orderType) {
        this.buyerId = buyerId;
        this.productId = productId;
        this.quantity = quantity;
        this.totalAmount = totalAmount;
        this.address = address;
        this.orderType = orderType;
        this.orderDate = new Date(); // Set the current date
        this.orderStatus = "Pending"; // Default status
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBuyerId() {
		return buyerId;
	}

	public void setBuyerId(int buyerId) {
		this.buyerId = buyerId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

    // Getters and setters...
    
}

