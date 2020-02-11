/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.SQLException;
import java.util.List;


/**
 * @author Hajar Amara
 *
 */
public interface MainInterface<T> {
	
	   //add an object
		public void addObj(T t);
		
		
		//Get a single record 
		public T getObj(long id);
		
		//Get all records
		public List<T> getAllOfObjects() throws SQLException;
		
		//Delete a record
		void deleteObject(long id);
		
		// Save and update the record
		public T updateObj(T t);


}
