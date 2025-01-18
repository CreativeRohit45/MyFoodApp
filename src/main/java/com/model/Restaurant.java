package com.model;

public class Restaurant {

	private int resId;
	private String name;
	private String address;
	private String phone;
	private float rating;
	private String cuisineType;
	private boolean isActive;
	private int deliveryTime;
	private String imgPath;

	public Restaurant() {
	
	}

	public Restaurant(int resId, String name, String address, float rating, String cuisineType,
			boolean isActive, int deliveryTime, String imgPath) {

		this.resId = resId;
		this.name = name;
		this.address = address;
		this.rating = rating;
		this.cuisineType = cuisineType;
		this.isActive = isActive;
		this.deliveryTime = deliveryTime;
		this.imgPath = imgPath;
	}

	public int getResId() {
		return resId;
	}

	public void setResId(int resId) {
		this.resId = resId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public String getCuisineType() {
		return cuisineType;
	}

	public void setCuisineType(String cuisineType) {
		this.cuisineType = cuisineType;
	}

	public boolean isActive() {
		return isActive;
	}

	public void setActive(boolean isActive) {
		this.isActive = isActive;
	}

	public int getDeliveryTime() {
		return deliveryTime;
	}

	public void setdeliveryTime(int eta) {
		this.deliveryTime = eta;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	
}
