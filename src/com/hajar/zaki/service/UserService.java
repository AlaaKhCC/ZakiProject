/**
 * 
 */
package com.hajar.zaki.service;

import java.util.List;

import com.hajar.zaki.model.User;

/**
 * @author Hajar Amara
 *
 */
public interface UserService {

	//add a user
		public void addUser(User user);
		
		
		//Get a single record 
		public User getUser(long id);
		
		//Get all records
		public List<User> getAllOfUsers();
		
		//Delete a record
		void deleteUser(long id);
		
		// Save and update the record
		public User updateUser(User user);
}
