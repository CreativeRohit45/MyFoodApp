package com.dao;

import java.util.List;
import com.model.Order;

public interface OrderDao {
	
	void insert(Order order);                 
	List<Order>getAllUsingUserId(int userId);    
	void update(Order order);  
	boolean exists(int orderId);
	String getOrderStatusById(int orderId);
}
