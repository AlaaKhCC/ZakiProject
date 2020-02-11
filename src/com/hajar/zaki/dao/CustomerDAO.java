/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.Customer;
import com.hajar.zaki.model.Supplier;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class CustomerDAO implements MainInterface<Customer> {

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(Customer t) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public Customer getObj(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@Override
	public List<Customer> getAllOfObjects() {
		 ArrayList<Customer> customers = new ArrayList<Customer>();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 
		 String emailDB="";
		 
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_CUSTOMER ); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				emailDB = resultSet.getString("customer_email");
				customers.add(new Customer(emailDB));	
			 }
			con.close();				  
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return customers;
	}
	
	
	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#deleteObject(long)
	 */
	@Override
	public void deleteObject(long id) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#updateObj(java.lang.Object)
	 */
	@Override
	public Customer updateObj(Customer cust) {
		
		return null;
	}

}
