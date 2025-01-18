package com.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dao.OrderDao;
import com.model.Order;

public class OrderDaoImp implements OrderDao{

	@Override
	public void insert(Order order) {
		 String query = "INSERT INTO `orders` (orderId, userId, resId, orderDate, totalAmount, status, paymentMode) VALUES (?, ?, ?, ?, ?, ?, ?)";
		 Connection con = DBConnection.connect();
		 PreparedStatement ps = null;
	        try{
	        	ps = con.prepareStatement(query);
	            ps.setInt(1, order.getOrderId());
	            ps.setInt(2, order.getUserId());
	            ps.setInt(3, order.getResId());
	            ps.setDate(4, order.getOrderDate());
	            ps.setDouble(5, order.getTotalAmount());
	            ps.setString(6, order.getStatus());
	            ps.setString(7, order.getPaymentMode());
	            ps.executeUpdate();
	        } 
	        catch (SQLException e) {
	            e.printStackTrace();
	        }finally {
		        DBConnection.disconnect(null, ps, null, con);
		    }
		}

	@Override
	public List<Order> getAllUsingUserId(int userId) {
		List<Order> ordersList = new ArrayList<>();
        String query = "SELECT * FROM `orders` WHERE userId = ?";
        Connection con = DBConnection.connect();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
        	ps = con.prepareStatement(query);
			ps.setInt(1, userId);
			rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order(
                    rs.getInt("orderId"),
                    rs.getInt("userId"),
                    rs.getInt("resId"),
                    rs.getDate("orderDate"),
                    rs.getInt("totalAmount"),
                    rs.getString("status"),
                    rs.getString("paymentMode")
                );
                ordersList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
        return ordersList;
	}
	
	@Override
	public boolean exists(int orderId) {
	    boolean exists = false;
	    String query = "SELECT COUNT(*) FROM `orders` WHERE orderId = ?";
	    Connection con = DBConnection.connect();
	    PreparedStatement ps = null;
        ResultSet rs = null;
	    try{
	    	ps = con.prepareStatement(query);
	    	ps.setInt(1, orderId);
	 	    rs = ps.executeQuery();
	        if (rs.next()) {
	                exists = rs.getInt(1) > 0; 
	         }
	       
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
	    return exists;
	}

	@Override
	public void update(Order order) {
		 String query = "UPDATE `orders` SET status = ? WHERE orderId = ?";
		 Connection con = DBConnection.connect();
		 PreparedStatement ps = null;
		 try{
			 ps = con.prepareStatement(query);
			 ps.setString(1, order.getStatus());
			 ps.setInt(2, order.getOrderId());
			 ps.executeUpdate();
		       
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }finally {
		        DBConnection.disconnect(null, ps, null, con);
		    }
	}
	
	@Override
	public String getOrderStatusById(int orderId) {
		String status = null;
		String query = "SELECT status FROM `orders` WHERE orderId = ?";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			 ps = con.prepareStatement(query);
			 ps.setInt(1, orderId);
			 rs = ps.executeQuery();
		        if (rs.next()) {
		                status = rs.getString("status"); 
		         }
		       
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }finally {
		        DBConnection.disconnect(null, ps, null, con);
		    }
		System.out.println("Order Status Fetched");
		return status;
	}

}
