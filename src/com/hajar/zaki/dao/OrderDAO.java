/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.Order;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class OrderDAO implements MainInterface<Order> {

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(Order t) {
		
	}
	 
	public int addOrder(Order o) {
		 Connection con = null;
		 PreparedStatement preparedStatement = null;
		 ResultSet rs ;
		 int auto_id=0;
		 if(o != null)
		 try
		 {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.INSERT_INTO_ORDER; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query ,  Statement.RETURN_GENERATED_KEYS); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, o.getCustomerId());
			 preparedStatement.setString(2, o.getProdId());
			 preparedStatement.setDouble(3, o.getQuantity());			 
			 preparedStatement.executeUpdate();
			 rs = preparedStatement.getGeneratedKeys();
		     if(rs != null && rs.next()) {
		    	 auto_id = rs.getInt(1);
		     }
			 preparedStatement.close();
			 con.close();
			
		 }catch(SQLException e){
	    	 e.printStackTrace();
	    	} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 return auto_id;
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public Order getObj(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	public ArrayList<Order> getOrderdPerCustomer(String mail) {
		 ArrayList<Order> orders = new ArrayList<>();
		 Connection con = null;
		 ResultSet resultSet = null;
		 System.out.println(" orderdao customer orders cut_mail "+ mail);
		try
		 {
             con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_ORDER_PER_CUSTOMER);// set it 
             psmt.setString(1, mail);
             resultSet= psmt.executeQuery();
			 while(resultSet.next()) // Until next row is present otherwise it return false
			 {
					orders.add(new Order(resultSet.getInt("orderNumber"),
											resultSet.getString("customer_mail"),resultSet.getString("prodId"),
											resultSet.getDouble("quantity")));
			 }
			 con.close();
			 
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return orders;
		
	}
	
	public ArrayList<Order> getOrderdPerSupplier(String sup_mail) {
		 ArrayList<Order> orders = new ArrayList<>();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		try
		 {
            con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
 			 PreparedStatement psmt =  (PreparedStatement) 
					           con.prepareStatement(Constatns.SELECT_FROM_ORDER_PER_SUPPLIER);
            psmt.setString(1, sup_mail);
            resultSet= psmt.executeQuery();
			 while(resultSet.next()) // Until next row is present otherwise it return false
			 {
			   orders.add(new Order(resultSet.getInt("orderNumber"),
									resultSet.getString("customer_mail"),resultSet.getString("prodId"),
											resultSet.getDouble("quantity")));
			 }
			 con.close();
			 
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return orders;
		
	}
	
	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@Override
	public List<Order> getAllOfObjects() {
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
		     String sql = Constatns.DELETE_ORDER;
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
			 System.out.println(" delete order mwthod in order dao  number order is "+id);
			 Class.forName("com.mysql.jdbc.Driver");
			 con =  (Connection) DBConnect.getInstance().createConnection(); //establishing connection
		       System.out.println("statemnet delete ");

		     String sql = Constatns.DELETE_ORDER;
		     PreparedStatement pstmt = (PreparedStatement) con.prepareStatement(sql);
		     // set the corresponding param
		       pstmt.setLong(1, id);
		       System.out.println("statemnet delete "+ pstmt.toString());
		    // execute the delete statement
		       int i = pstmt.executeUpdate();	
		       System.out.println(" deletedao index "+ i);
		       con.close();
		 }catch (SQLException e) {
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
//	public void deleteOrdersPerCustomer(String mail) {
//		
//		 Connection con = null;
//		 try{
//			 con =  (Connection) DBConnect.getInstance().createConnection(); //establishing connection
//		     String sql = Constatns.DELETE_ORDER;
//		     PreparedStatement pstmt = (PreparedStatement) con.prepareStatement(sql);
//		     // set the corresponding param
//		       pstmt.setLong(1, id);
//		    // execute the delete statement
//		       pstmt.executeUpdate();		       
//		       con.close();
//		 }catch (SQLException e) {
//		} catch (ClassNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//	}
	
	
	public Order getOrderByNum( int num) {

	     Connection con = null;
		 ResultSet resultSet = null;			 
		 String customerMail = "", prodId="";
		 int orderNumber=0; double quantity=0.0;
		 PreparedStatement preparedStatement = null;
		 Order o = new Order();
		 try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.SELECT_ALL_USER; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setInt(1, num);
			 resultSet= preparedStatement.executeQuery();
			 if (resultSet.next()) {  //Just to ensure data has been inserted into the database
				  customerMail = resultSet.getString("customer_mail");
				  prodId=resultSet.getString("prodId");
				  orderNumber=resultSet.getInt("orderNumber");
				  quantity=resultSet.getDouble("quantity");
				  o = new Order(orderNumber,customerMail,prodId,quantity);
			}
			 
			 con.close();		
		 }catch(SQLException | ClassNotFoundException e){
	    	 e.printStackTrace();
	    	}
		
		return o;
	}

	public Order updateStatus(int num ) {
		
		PreparedStatement pstmnt= null;
		Connection con = null;
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 con.setAutoCommit(true);
			 String query = Constatns.UPDATE_ORDER_STATUS; 
			 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 pstmnt.setInt(1,num);		
			 int i = pstmnt.executeUpdate();
			 System.out.println("index update "+i);			 
			 con.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return getOrderByNum(num);
	}
	
	public Order updateConfirmation(int num ) {
			
			PreparedStatement pstmnt= null;
			Connection con = null;
			try {
				 Class.forName("com.mysql.jdbc.Driver");
				 con = (Connection) DBConnect.getInstance().createConnection();
				 con.setAutoCommit(true);
				 String query = Constatns.UPDATE_ORDER_STATUS_Confirmation; 
				 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
				 pstmnt.setInt(1,num);		
				 int i = pstmnt.executeUpdate();
				 System.out.println("index update "+i);			 
				 con.close();
				
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			return getOrderByNum(num);
		}
	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#updateObj(java.lang.Object)
	 */
	@Override
	public Order updateObj(Order t) {
		// TODO Auto-generated method stub
		return null;
	}

}
