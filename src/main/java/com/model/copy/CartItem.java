//package com.model;
//
//public class CartItem {
//	private Product product;
//	private int quantity;
//	
//	public CartItem(Product product, int quantity) {
//		this.product = product;
//		this.quantity = quantity;
//	}
//	
//	public Product getProduct() {
//		return product;
//	}
//	
//	public int getQuantity() {
//		return quantity;
//	}
//
//	public void setProduct(Product product) {
//		this.product = product;
//	}
//
//	public void setQuantity(int quantity) {
//		this.quantity = quantity;
//	}
//	
//	
//}


package com.model.copy;

public class CartItem {
    private int id;
    private Cart cart;       // Reference to the cart
    private Product product; // Reference to the product
    private int quantity;    // Quantity of the product

    // Constructors
    public CartItem() { }

    public CartItem(int id, Cart cart, Product product, int quantity) {
        this.id = id;
        this.cart = cart;
        this.product = product;
        this.quantity = quantity;
    }

    public CartItem(Cart cart, Product product, int quantity) {
        this.cart = cart;
        this.product = product;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Utility method to calculate the total price for this item
    public double getTotalPrice() {
        return product.getPrice() * quantity;
    }
}
