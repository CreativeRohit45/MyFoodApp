package com.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.dao.UserDao;
import com.model.User;

public class UserDaoImp implements UserDao {

	@Override
	public int insertUser(User user) {
		String query = "INSERT INTO `user` (username, password, email, address) VALUES (?, ?, ?, ?)";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		try{
			ps = con.prepareStatement(query);
			ps.setString(1, user.getUsername());
			ps.setString(2, user.getPassword());
			ps.setString(3, user.getEmail());
			ps.setString(4, user.getAddress());
			return ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(null, ps, null, con);
	    }
		return 0;
	}

	@Override
	public List<User> getAllUsers() {
		List<User> users = new ArrayList<>();
		String query = "SELECT * FROM `user`";
		Connection con = DBConnection.connect();
		Statement stmt = null;
		ResultSet rs = null;
		try{
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				User user = new User(rs.getString("username"),rs.getString("password"),rs.getString("email"),rs.getString("address"));
				users.add(user);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(rs, null, stmt, con);
	    }
		return users;
	}

	@Override
	public User getOneUser(int userId) {
		String query = "SELECT * FROM `user` WHERE userId = ?";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			ps = con.prepareStatement(query);
			ps.setInt(1, userId);
			rs = ps.executeQuery();
			while(rs.next()) {
				return new User(rs.getString("username"),rs.getString("password"),rs.getString("email"),rs.getString("address"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
		return null;
	}


	
	public User getEmailPassword(String email,String password) {
		User user = null;
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			String query = "SELECT * FROM `user` WHERE email=? AND password=?";
			ps = con.prepareStatement(query);
			ps.setString(1, email);
			ps.setString(2, password);
			rs = ps.executeQuery();
			if(rs.next()) {
				user=new User(rs.getInt("userId"),rs.getString("username"),rs.getString("password"),rs.getString("email"),rs.getString("phone"),rs.getString("address"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
		return user;
	}

	public String getEmail(String email) {
		String userEmail = "";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			String query="SELECT * FROM `user` WHERE email=?";
			ps = con.prepareStatement(query);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				userEmail = rs.getString("email");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
		return userEmail;
	}
	
	public boolean updatePassword(String email, String newPassword) {
		String query = "UPDATE `user` SET password = ? WHERE email = ?";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		boolean isUpdated = false;
		try{
			ps = con.prepareStatement(query);
			ps.setString(1, newPassword);
			ps.setString(2, email);
			int rowsAffected = ps.executeUpdate(); 
	        if (rowsAffected > 0) {
	            isUpdated = true; 
	        }
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(null, ps, null, con);
	    }
		 return isUpdated;
	}
	
	@Override
	public void updateAddress(int userId, String address, String phoneNumber) {
		String query = "UPDATE `user` SET address = ?, phone = ? WHERE userId = ?";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		try{
			ps = con.prepareStatement(query);
			ps.setString(1, address);
			ps.setString(2, phoneNumber);
			ps.setInt(3, userId);
			ps.executeUpdate(); 
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(null, ps, null, con);
	    }
	}
}
