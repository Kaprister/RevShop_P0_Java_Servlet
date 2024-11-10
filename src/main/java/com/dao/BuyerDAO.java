package com.dao;

import java.sql.*;
import com.model.Buyer;

public class BuyerDAO {
	private Connection connection;
	
	public BuyerDAO(Connection connection) {
		this.connection = connection;
	}
	
	public boolean registerBuyer(Buyer buyer) {
		String query = "INSERT INTO Buyer (name, email, password, address) VALUES (?, ?, ?, ?)";
		try(PreparedStatement ps = connection.prepareStatement(query)){
			ps.setString(1, buyer.getName());
			ps.setString(2, buyer.getEmail());
			ps.setString(3, buyer.getPassword());
			ps.setString(4, buyer.getAddress());
			int rowsAffected = ps.executeUpdate();
			return rowsAffected > 0;
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("error while buyer registring Dao : " + e);
			return false;
		}
	}
	
	public Buyer loginBuyer(String email, String password) {
		String query = "SELECT * FROM Buyer WHERE email = ? AND password = ?";
		try(PreparedStatement ps = connection.prepareStatement(query)){
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if(rs.next()) {
				return new Buyer(rs.getInt("id"), rs.getString("name"), rs.getString("email"), rs.getString("password"), rs.getString("address"));
			}
		}catch(SQLException e) {
			System.out.println("error while buyer login Dao : " + e);
			e.printStackTrace();
		}
		return null;
	}
}
