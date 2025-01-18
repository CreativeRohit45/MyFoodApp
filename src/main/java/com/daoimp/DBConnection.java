package com.daoimp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {
	
	public static Connection con;
	
	public static Connection connect(){
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FoodApp", "root", "rohit45");
			
		}catch(SQLException e) {
			e.printStackTrace();
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		return con;
	}
	
	public static void disconnect(ResultSet result, PreparedStatement pst, Statement st, Connection con) {
		try {
			if(result!=null) {
				result.close();
			}
			if(st!=null) {
				st.close();
			}
			if(pst!=null) {
				pst.close();
			}
			if(con!=null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
}
