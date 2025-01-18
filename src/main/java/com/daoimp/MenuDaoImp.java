package com.daoimp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.dao.MenuDao;
import com.model.Menu;

public class MenuDaoImp implements MenuDao {
	
	@Override
	public List<Menu> getMenuByRestaurantId(int restaurantId) {
		List<Menu> menuItems = new ArrayList<>();
        String query = "SELECT * FROM `menu` where resId=?";
        Connection con = DBConnection.connect();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
        	 ps = con.prepareStatement(query);
        	 ps.setInt(1,restaurantId);
             rs = ps.executeQuery();
             while (rs.next()) {
                Menu menu = new Menu(
                    rs.getInt("menuId"),
                    rs.getInt("resId"),
                    rs.getString("itemName"),
                    rs.getString("description"),
                    rs.getInt("price"),
                    rs.getFloat("rating"),
                    rs.getBoolean("isAvailable"),
                    rs.getString("imgPath")
                );
                menuItems.add(menu);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
	        DBConnection.disconnect(rs, ps, null, con);
	    }
        return menuItems;
	}
	
	@Override
    public Menu getMenuItem(int menuId) {
        String query = "SELECT * FROM menu WHERE menuId = ?";
        Connection con = DBConnection.connect();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{ 
        	ps = con.prepareStatement(query);
        	ps.setInt(1,menuId);
   	 		rs = ps.executeQuery();
            while (rs.next()) {
                    return new Menu(
                            rs.getInt("menuId"),
                            rs.getInt("resId"),
                            rs.getString("itemName"),
                            rs.getString("description"),
                            rs.getInt("price"),
                            rs.getFloat("rating"),
                            rs.getBoolean("isAvailable"),
                            rs.getString("imgPath")
                            
                        );
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }finally {
    	        DBConnection.disconnect(rs, ps, null, con);
    	    }
     
        return null;
    }
	
	


}
