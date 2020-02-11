/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.Supplier;
import com.hajar.zaki.model.User;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class SupplierDAO implements MainInterface<Supplier> {

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(Supplier t) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public Supplier getObj(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@Override
	public List<Supplier> getAllOfObjects() {
		return null;
	}
	public ArrayList<Supplier> getAllSuppliers() throws ClassNotFoundException {
		
		 ArrayList<Supplier> suppliers = new ArrayList<Supplier>();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 
		 String emailDB="";
		 String desc = "" ;
		 
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_SUPPLLIER ); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				emailDB = resultSet.getString("supplier_email");
				desc = resultSet.getString("foodDescription");
					 suppliers.add(new Supplier(emailDB,desc));	
			 }
			con.close();				  
		 }catch(SQLException e){
		    e.printStackTrace();
		   }
		
		return suppliers;
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
	public Supplier updateObj(Supplier sup){
		System.out.println(" supplier : "+sup);
		PreparedStatement pstmnt= null;
		Connection con = null;
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 con.setAutoCommit(true);
			 String query = Constatns.UPDATE_SUPPLIER; 
			 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 pstmnt.setString(1,sup.getFoodDescription());
			 pstmnt.setString(2,sup.getUserMail());
			 int i = pstmnt.executeUpdate();			 
			 con.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return sup;
	}

}
