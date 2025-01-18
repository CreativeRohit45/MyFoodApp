package com.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dao.OrderItemDao;
import com.model.OrderItem;

public class OrderItemDaoImp implements OrderItemDao {

	@Override
	public void insert(OrderItem orderItem) {
		String query = "INSERT INTO `orderitem` (orderId, menuId, quantity, totalPrice) VALUES (?, ?, ?, ?)";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		try{
			ps = con.prepareStatement(query);
			ps.setInt(1, orderItem.getOrderId());
			ps.setInt(2, orderItem.getMenuId());
			ps.setInt(3, orderItem.getQuantity());
			ps.setDouble(4, orderItem.getTotalPrice());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(null, ps, null, con);
	    }
	
	}
	
	@Override
	public List<OrderItem> getAllOrderItemsByOrderId(int orderId){
		List<OrderItem> orderItemList = new ArrayList<>();
		String query = "SELECT * FROM `OrderItem` where orderId = ?";
		Connection con = DBConnection.connect();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try{
			ps = con.prepareStatement(query);
			ps.setInt(1, orderId);
			rs = ps.executeQuery();
			while (rs.next()) {
                OrderItem orderItem = new OrderItem(
                    rs.getInt("orderItemId"),
                    rs.getInt("orderId"),
                    rs.getInt("menuId"),
                    rs.getInt("quantity"),
                    rs.getDouble("totalPrice")
                );
                orderItemList.add(orderItem);
            }
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
		
		return orderItemList;
	}
}
