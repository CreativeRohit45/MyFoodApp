package com.dao;

import java.util.List;
import com.model.Restaurant;

public interface RestaurantDao {

	List<Restaurant> getAllRestaurants();
	String getRestaurantNameById(int restaurantId);
}
