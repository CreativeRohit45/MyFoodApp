package com.model;

import java.sql.Date;

public class Order {
	
	private int orderId;
	private int userId;
	private int resId;
	private Date orderDate;
	private double totalAmount;
	private String status;
	private String paymentMode;
	
	public Order() {
	
	}

	public Order(int orderId, int userId, int resId, java.sql.Date orderDate, double totalAmount, String status,
			String paymentMode) {
		super();
		this.orderId = orderId;
		this.userId = userId;
		this.resId = resId;
		this.orderDate = orderDate;
		this.totalAmount = totalAmount;
		this.status = status;
		this.paymentMode = paymentMode;
	}

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getResId() {
		return resId;
	}

	public void setResId(int resId) {
		this.resId = resId;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(float totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	
	@Override
	public String toString() {
		return "Order [orderId=" + orderId + ", userId=" + userId + ", resId=" + resId + ", orderDate=" + orderDate
				+ ", totalAmount=" + totalAmount + ", status=" + status + ", paymentMode=" + paymentMode + "]";
	}
	
}
