/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;
import java.sql.Date;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.OrderDetails;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class OrderDetailsDAO implements MainInterface<OrderDetails> {

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(OrderDetails od) {
		 Connection con = null;
		 PreparedStatement preparedStatement = null;
		 if(od != null && ( od.getDescription() != null && od.getDiscount() != null && 
				    od.getNumberOrder()>=0  && od.getPrice() != null && od.getRequireDate()!= null)) {
			 try
			 {
				 Class.forName("com.mysql.jdbc.Driver");
				 con = (Connection) DBConnect.getInstance().createConnection();
				 String query = Constatns.INSERT_INTO_ORDERDETAILS; 
				 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
				 preparedStatement.setInt(1,od.getNumberOrder());
				 preparedStatement.setDate(2, new  Date(Calendar.getInstance().getTime().getTime()));
				 preparedStatement.setDate(3, (Date) od.getRequireDate());
				 preparedStatement.setDouble(4, od.getPrice());
				 preparedStatement.setString(5, od.getDescription());
				 preparedStatement.setDouble(6, od.getDiscount());
				 preparedStatement.setString(7, od.getStatus()); 
				 
				 preparedStatement.executeUpdate();
				 preparedStatement.close();
				 con.close();
				
			 }catch(SQLException e){
		    	 e.printStackTrace();
		    	} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		 }
		 
		 
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public OrderDetails getObj(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@Override
	public List<OrderDetails> getAllOfObjects() {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#deleteObject(long)
	 */
	@Override
	public void deleteObject(long id) {
		
		 Connection con = null;
		 try{
			 con =  (Connection) DBConnect.getInstance().createConnection(); //establishing connection
		     String sql = Constatns.DELETE_ORDER_DETAILS;
		     PreparedStatement pstmt = (PreparedStatement) con.prepareStatement(sql);
		     // set the corresponding param
		       pstmt.setLong(1, id);
		    // execute the delete statement
		       pstmt.executeUpdate();
		       
		       con.close();
		 }catch (SQLException e) {
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public void deleteOrder(int id) {
		
		 Connection con = null;
		 try{
			 con =  (Connection) DBConnect.getInstance().createConnection(); //establishing connection
		     String sql = Constatns.DELETE_ORDER_DETAILS;
		     PreparedStatement pstmt = (PreparedStatement) con.prepareStatement(sql);
		     // set the corresponding param
		       pstmt.setLong(1, id);
		    // execute the delete statement
		       int i = pstmt.executeUpdate();		
		       System.out.println(" delete index "+ i);
		       con.close();
		 }catch (SQLException e) {
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#updateObj(java.lang.Object)
	 */
	@Override
	public OrderDetails updateObj(OrderDetails t) {
		// TODO Auto-generated method stub
		return null;
	}

}
