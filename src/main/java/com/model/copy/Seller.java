package com.model.copy;

public class Seller {
	private int id;
	private String businessName;
	private String email;
	private String password;
	private String name;
	
	public Seller(String businessName, String email, String password, String name) {
		this.businessName = businessName;
		this.email = email;
		this.password = password;
		this.name = name;
	}
	
	public Seller(int id, String businessName, String email, String password, String name) {
		this.id = id;
		this.businessName = businessName;
		this.email = email;
		this.password = password;
		this.name = name;
	}
	
//	getter
	public int getId() {
		return id;
	}
	
	public String getBusinessName() {
		return businessName;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getPassword() {
		return password;
	}
	

	
	public String getName() {
		return name;
	}



	//	setter
	public void setId(int id) {
		this.id = id;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}
	
	public void SetPassword(String password) {
		this.password = password;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
}
