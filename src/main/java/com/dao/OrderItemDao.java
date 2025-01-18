package com.dao;

import java.util.List;
import com.model.OrderItem;

public interface OrderItemDao {
	
	void insert(OrderItem orderItem); 
	public List<OrderItem> getAllOrderItemsByOrderId(int orderId);
}
