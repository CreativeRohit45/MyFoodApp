package com.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.dao.RestaurantDao;
import com.model.Restaurant;

public class RestaurantDaoImp implements RestaurantDao{

	@Override
	public List<Restaurant> getAllRestaurants() {
		
		List<Restaurant> lists = new ArrayList<>();
        String query = "SELECT * FROM `restaurant`";
        Connection con = DBConnection.connect();
        Statement st = null;
        ResultSet rs = null;
        try{
        	st = con.createStatement();
			rs = st.executeQuery(query);
            while (rs.next()) {
            	Restaurant user = new Restaurant(
            			rs.getInt("resId"),
            			rs.getString("name"),
            			rs.getString("address"),
            			rs.getFloat("rating"),
            			rs.getString("cuisineType"),
            			rs.getBoolean("isActive"),
            			rs.getInt("deliveryTime"),
            			rs.getString("imgPath")
                );
            	lists.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
	        DBConnection.disconnect(rs, null, st, con);
	    }
        return lists;
	}
	
	@Override
	public String getRestaurantNameById(int restaurantId) {
	    String resName = "";
	    String query = "SELECT name FROM `restaurant` WHERE resId=?";
	    Connection con = DBConnection.connect();
	    PreparedStatement ps = null;
	    ResultSet rs = null;
	    try {
	        ps = con.prepareStatement(query);
	        ps.setInt(1, restaurantId);
	        rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            resName = rs.getString("name");
	        } else {
	            System.out.println("No restaurant found for ID: " + restaurantId);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
	    return resName;
	}

}
