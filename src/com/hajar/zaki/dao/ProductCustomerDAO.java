/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.Product;
import com.hajar.zaki.model.ProductCustomer;
import com.hajar.zaki.model.User;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Category;
import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class ProductCustomerDAO {
	
	
	public void addProductCustomerLike(ProductCustomer prod_customer) {
		 
		 Connection con = null;
		 PreparedStatement preparedStatement = null;
		 
		 try
		 {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.INSERT_INTO_PRODUCT_Customer; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, prod_customer.getProdId());
			 preparedStatement.setString(2, prod_customer.getMail_Customer());
			 preparedStatement.setInt(3, prod_customer.getLike());
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
	
	public ProductCustomer updateProductCustomerLike(ProductCustomer pc) {
		PreparedStatement pstmnt= null;
		Connection con = null;
		  System.out.println(pc.toString());
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 con.setAutoCommit(true);
			 String query = Constatns.UPDATE_PRODUCT_CUSTOMER_LIKE; 
			 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 pstmnt.setInt(1, pc.getLike());
			 pstmnt.setString(2, pc.getProdId());
			 pstmnt.setString(3, pc.getMail_Customer());	
			 
			 System.out.println(" statement in product customer update  "+pstmnt.toString());
			 
			 int i = pstmnt.executeUpdate();
			 System.out.println("index update like here "+i);			 
			 con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return pc;
	}
	
	public ProductCustomer updateProductCustomerRate(ProductCustomer pc) {
		PreparedStatement pstmnt= null;
		Connection con = null;
		  System.out.println(pc.toString()+ " RATE "+pc.getRate());
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 con.setAutoCommit(true);
			 String query = Constatns.UPDATE_PRODUCT_CUSTOMER_RATING; 
			 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 pstmnt.setInt(1, pc.getRate());
			 pstmnt.setString(2, pc.getProdId());
			 pstmnt.setString(3, pc.getMail_Customer());	
			 
			 System.out.println(" statement in product customer update  "+pstmnt.toString());
			 
			 int i = pstmnt.executeUpdate();
			 System.out.println("index update like here "+i);			 
			 con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return pc;
	}
	
	public ProductCustomer updateProductCustomerComment(ProductCustomer pc) {
		PreparedStatement pstmnt= null;
		Connection con = null;
		  System.out.println(pc.toString());
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 con.setAutoCommit(true);
			 String query = Constatns.UPDATE_PRODUCT_CUSTOMER_COMMENT; 
			 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 pstmnt.setString(1, pc.getComment());
			 pstmnt.setString(2, pc.getProdId());
			 pstmnt.setString(3, pc.getMail_Customer());	
			 
			 System.out.println(" statement in product customer update  "+pstmnt.toString());
			 
			 int i = pstmnt.executeUpdate();
			 System.out.println("index update like here "+i);			 
			 con.close();			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return pc;
	}
	
	
	public ProductCustomer getProductLike(String id, String mail) {
		
		 ProductCustomer prod= new ProductCustomer();		
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_CUSTOMER_LIKE);
             psmt.setString(1, id);
             psmt.setString(2, mail);
            resultSet= psmt.executeQuery();
			if(resultSet.next()) // Until next row is present otherwise it return false
			 {
				prod = new ProductCustomer(resultSet.getString("prod_id"),resultSet.getString("mail_customer"),
						                   resultSet.getInt("liked"));
			 }
			
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return prod;
	}
	
	public ArrayList<String> getListProducts_rate( String mail) {
		
		ArrayList<String> productslist = new ArrayList<>();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 String vals = "count,", a="0",b="0";
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_CUSTOMER_PER_SUP);
            psmt.setString(1, mail);
             resultSet= psmt.executeQuery();
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				if(resultSet.getString(1) == null) {
					  vals += a;	
					}else {
						vals += resultSet.getString(1);
					}
					if(resultSet.getString(2) == null) {
						vals+=",sum,"+b;
					}else {					
					vals +=",sum," +resultSet.getString(2);
					}
					if(resultSet.getString(3)!= null) {
						vals+=","+resultSet.getString(3);
					}
					productslist.add(vals);
					vals = "count,";
			 }
			
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return productslist;
	}
	
	public ArrayList<ProductCustomer> getListProducts_like( String mail) {
		
		ArrayList<ProductCustomer> productslist = new ArrayList<>();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCTLiked );
            psmt.setString(1, mail);
             resultSet= psmt.executeQuery();
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				productslist.add(new ProductCustomer(resultSet.getString("prod_id"),resultSet.getString("mail_customer"), resultSet.getInt("liked")));
			 }
			
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return productslist;
	}

	
	 /////////////////////////////////////
	
	public void addProductCustomerRating(ProductCustomer prod_customer) {
		 
		 Connection con = null;
		 PreparedStatement preparedStatement = null;
		 
		 try
		 {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.INSERT_INTO_PRODUCT_CUSTOMER_RATING; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, prod_customer.getProdId());
			 preparedStatement.setString(2, prod_customer.getMail_Customer());
			 preparedStatement.setInt(3, prod_customer.getRate());
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
	
	public String getRatingProduct( String id) {
				
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 String vals ="",a="0",b="0";;
		 
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_SUM_COUNT_PROD_RATE);
             psmt.setString(1, id);
            resultSet= psmt.executeQuery();
			if(resultSet.next()) // Until next row is present otherwise it return false
			 {
				if(resultSet.getString(1) == null) {
				  vals += a;	
				}else {
					vals = resultSet.getString(1);
				}
				if(resultSet.getString(2) == null) {
					vals+=","+b;
				}else {					
				vals ="," +resultSet.getString(2);
				}
			 }
			
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		System.out.println(" strings vals "+ vals);
		return vals;
	}
	
	public ProductCustomer getProductCustomer(String id, String mail) {
		
		 ProductCustomer prod= new ProductCustomer();		
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_CUSTOMER);
            psmt.setString(1, id);
            psmt.setString(2, mail);
           resultSet= psmt.executeQuery();
			if(resultSet.next()) // Until next row is present otherwise it return false
			 {
				prod = new ProductCustomer(resultSet.getString("prod_id"),resultSet.getString("mail_customer"),
						                   resultSet.getInt("liked"), resultSet.getInt("rate"),resultSet.getString("comment"));
				
				
			 }
			
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return prod;
	}
}
