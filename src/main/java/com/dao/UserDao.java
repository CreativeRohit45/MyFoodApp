package com.dao;

import java.util.List;

import com.model.User;

public interface UserDao {

	 int insertUser(User user);
	 List<User> getAllUsers();
	 User getOneUser(int userId);
	 User getEmailPassword(String email,String password);
	 String getEmail(String email);
	 boolean updatePassword(String email,String newPassword);
	 void updateAddress(int userId, String address, String phoneNumber);
}
