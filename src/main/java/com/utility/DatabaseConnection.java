package com.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	private static Connection connection;
	
	public static Connection getConnection() {
		if(connection == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				String url = "jdbc:mysql://localhost:3306/revshop";
	            String username = "root";
	            String password = "Sushant#07";
	            connection = DriverManager.getConnection(url, username, password);
			}catch(Exception e) {
				e.printStackTrace();
				throw new RuntimeException("Error connecting to the database.");
			}
		}
		return connection;
	}
}
