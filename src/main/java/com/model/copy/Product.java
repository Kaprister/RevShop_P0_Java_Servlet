package com.model.copy;

public class Product {


	private int id;
	private String name;
	private String description;
	private double price;
	private int quantity;
	private int sellerId;
	private String brand;
	private String imageUrl;
	private int rating;
	
	public Product() {
		super();
	}
	
	public Product(int id) {
		this.id = id;
	}
	
	public Product(String name, String description, double price, int quantity, int sellerId, String brand, String imageUrl, int rating) {
		this.name = name;
		this.description = description;
		this.price = price;
		this.quantity = quantity;
        this.sellerId = sellerId;
        this.brand = brand;
        this.imageUrl = imageUrl;
        this.rating = rating;
	}
	
	
	// Getters
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getSellerId() {
        return sellerId;
    }
    
    public String getBrand() {
        return brand;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public int getRating() {
        return rating;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }
    
    public void setBrand(String brand) {
        this.brand = brand;
    }
    
    public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}


	public void setRating(int rating) {
		this.rating = rating;
	}


	@Override
    public String toString() {
        return "Product{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", sellerId=" + sellerId +
                ", brand= " + brand +
                ", imageUrl= " + imageUrl +
                ", rating= " + rating +
                '}';
    }

	
}
