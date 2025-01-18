package com.dao;

import java.util.List;
import com.model.Menu;

public interface MenuDao {

    List<Menu> getMenuByRestaurantId(int restaurantId);
    public Menu getMenuItem(int menuId);
}
