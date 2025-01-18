package com.model;

import java.util.Objects;

public class Menu {
	
	private int menuId;
	private int resId;
	private String itemName;
	private String description;
	private int price;
	private float rating;
	private boolean isAvailable;
	private String imgPath;
	
	public Menu() {
		
	}

	public Menu(int menuId, int resId, String itemName, String description, int price, float rating,
			boolean isAvailable, String imgPath) {
		super();
		this.menuId = menuId;
		this.resId = resId;
		this.itemName = itemName;
		this.description = description;
		this.price = price;
		this.rating = rating;
		this.isAvailable = isAvailable;
		this.imgPath = imgPath;
	}

	public int getMenuId() {
		return menuId;
	}

	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}

	public int getResId() {
		return resId;
	}

	public void setResId(int resId) {
		this.resId = resId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public boolean isAvailable() {
		return isAvailable;
	}

	public void setAvailable(boolean isAvailable) {
		this.isAvailable = isAvailable;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}
	
	@Override
	public String toString() {
		
	    return "Menu [menuId=" + menuId + ", resId=" + resId + ", itemName=" + itemName + ", description=" 
	                + description + ", price=" + price + ", isAvailable=" + isAvailable + ", imgPath=" + imgPath + "]";
	}
	
	@Override
	public boolean equals(Object obj) {
	    if (this == obj) {
	        return true;
	    }
	    if (obj == null || getClass() != obj.getClass()) {
	        return false;
	    }
	    Menu menu = (Menu) obj;
	    return menuId == menu.menuId;  
	}

	@Override
	public int hashCode() {
	    return Objects.hash(menuId);  
	}
	
}
