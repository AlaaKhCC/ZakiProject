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
import com.hajar.zaki.model.Product;
import com.hajar.zaki.model.Supplier;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Category;
import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class ProductDAO implements MainInterface<Product> {

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(Product prod) {
		 
		 Connection con = null;
		 PreparedStatement preparedStatement = null;
		 
		 try
		 {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.INSERT_INTO_PRODUCT; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, prod.getProdID());
			 preparedStatement.setString(2, prod.getName());
			 preparedStatement.setString(3, prod.getSupID().replace(" ", ""));
			 preparedStatement.setDouble(4, prod.getPiece_price());
			 preparedStatement.setString(5, prod.getCategory().toString());
			 preparedStatement.setString(6, prod.getDescription());
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

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	
	public Product getProductPerId(String id) {
		
	     Product prod= new Product();		
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 Category category=null;
		 
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 statement = (Statement) con.createStatement();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_PER_ID);
             psmt.setString(1, id);
            resultSet= psmt.executeQuery();
			if(resultSet.next()) // Until next row is present otherwise it return false
			 {
				if(resultSet.getString("category") != null) {
					category= Enum.valueOf(Category.class, resultSet.getString("category").toUpperCase());
					 prod= new Product(resultSet.getString("productID"), resultSet.getString("emailSupplier"),resultSet.getString("prodName"),
							  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
				}
			   
			 }
			
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return prod;
	}
	
	
	@SuppressWarnings("static-access")
	public Product getProductPerName(String name) {
		Product prod= new Product();
		
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 Category category=null;
			
		return prod;		
	}

	
	public ArrayList<Product> getAllSalads() throws SQLException {
		
		 ArrayList<Product> salads = new ArrayList<>();
		 Product prod = new Product();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 Category category=null;
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT_SALADS); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
				 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT_SALADS); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
				 
				while(resultSet.next()) // Until next row is present otherwise it return false
				 {
						category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
					  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
							  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
					 	  salads.add(prod);
					
				 }
			 }
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return salads;
		
	}
	
	public ArrayList<Product> getAllSweets() throws SQLException {
		
		 ArrayList<Product> sweets = new ArrayList<>();
		 Product prod = new Product();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 Category category=null;
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT_SWEET); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
					category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
				  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
						  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
				 	  sweets.add(prod);
				
			 }
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return sweets;
		
	}
	
	
	public ArrayList<Product> getAllMainCourses() throws SQLException {
		
		 ArrayList<Product> mains = new ArrayList<>();
		 Product prod = new Product();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 Category category=null;
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT_MAIN); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
			  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
					  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
			 	  
			 	  mains.add(prod);
			 }
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return mains;
		
	}
	
	public ArrayList<Product> getAllAPPETIZERS() throws SQLException {
		
		 ArrayList<Product> appetizers = new ArrayList<>();
		 Product prod = new Product();
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 Category category=null;
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT_APPETIZERS); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
			  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
					  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
			 	  
			 	  appetizers.add(prod);
			 }
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}	
		return appetizers;
		
	}
	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@Override
	public ArrayList<Product> getAllOfObjects() throws SQLException {
		 
		 Connection con = null; 
			Statement statement = null;
			 ResultSet resultSet = null;
			 Product prod=new Product();
			 ArrayList<Product> products=new ArrayList<Product>();
			 Category category=null;

		try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
				 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
				 
				while(resultSet.next()) // Until next row is present otherwise it return false
				 {
					if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
						category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
					  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
							  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
					 	  products.add(prod);
					}								
				 }
			 }catch(SQLException e){
			    e.printStackTrace();
			   } catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
		return products;
	}
	
	
	public ArrayList<Product> getAllSupProds(String mail) throws SQLException {
		 
		    Connection con = null; 
			Statement statement = null;
			 ResultSet resultSet = null;
			 Product prod=new Product();
			 ArrayList<Product> products=new ArrayList<Product>();
			 Category category=null;

		try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
				 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_PER_SUP); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
				 psmt.setString(1, mail);
	             resultSet= psmt.executeQuery();
	            
				while(resultSet.next()) // Until next row is present otherwise it return false
				 {
					if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
						category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
					  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
							  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
					 	  products.add(prod);
					}								
				 }
			 }catch(SQLException e){
			    e.printStackTrace();
			   } catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
		return products;
	}
	
	public ArrayList<Product> getAllSalads_SUP(String mail) throws SQLException {
		

	    Connection con = null; 
		Statement statement = null;
		 ResultSet resultSet = null;
		 Product prod=new Product();
		 ArrayList<Product> products=new ArrayList<Product>();
		 Category category=null;

	try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_SALADS_SUP); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 psmt.setString(1, mail);
             resultSet= psmt.executeQuery();
            
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
					category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
				  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
						  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
				 	  products.add(prod);
				}								
			 }
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	
	return products;
	}
	
public ArrayList<Product> getAllSWEETS_SUP(String mail) throws SQLException {
		

	    Connection con = null; 
		Statement statement = null;
		 ResultSet resultSet = null;
		 Product prod=new Product();
		 ArrayList<Product> products=new ArrayList<Product>();
		 Category category=null;

	try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_SWEET_SUP); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 psmt.setString(1, mail);
             resultSet= psmt.executeQuery();
            
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
					category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
				  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
						  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
				 	  products.add(prod);
				}								
			 }
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	
	return products;
	}
	
	public ArrayList<Product> getAllAPPET_SUP(String mail) throws SQLException {
	
	
	    Connection con = null; 
		Statement statement = null;
		 ResultSet resultSet = null;
		 Product prod=new Product();
		 ArrayList<Product> products=new ArrayList<Product>();
		 Category category=null;
	
	try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_APPETIZERS_SUP); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 psmt.setString(1, mail);
	         resultSet= psmt.executeQuery();
	        
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
					category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
				  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
						  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
				 	  products.add(prod);
				}								
			 }
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	
	return products;
	}
	
	public ArrayList<Product> getAllMain_SUP(String mail) throws SQLException {
			
	
		    Connection con = null; 
			Statement statement = null;
			 ResultSet resultSet = null;
			 Product prod=new Product();
			 ArrayList<Product> products=new ArrayList<Product>();
			 Category category=null;
	
		try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
				 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_MAIN_SUP); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
				 psmt.setString(1, mail);
	             resultSet= psmt.executeQuery();
	            
				while(resultSet.next()) // Until next row is present otherwise it return false
				 {
					if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
						category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
					  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
							  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
					 	  products.add(prod);
					}								
				 }
			 }catch(SQLException e){
			    e.printStackTrace();
			   } catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
		return products;
		}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#deleteObject(long)
	 */
	@Override
	public void deleteObject(long id) {
		
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#updateObj(java.lang.Object)
	 */
	@Override
	public Product updateObj(Product prod) {
		PreparedStatement pstmnt= null;
		Connection con = null;
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 con.setAutoCommit(true);
			 String query = Constatns.UPDATE_PRODUCT; 
			 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 pstmnt.setString(1,prod.getName());
			 pstmnt.setString(2,prod.getSupID());
			 pstmnt.setFloat(3, (float) prod.getPiece_price());
			 pstmnt.setString(4, prod.getCategory().toString());
			 pstmnt.setString(5, prod.getDescription());
			 pstmnt.setString(6, prod.getProdID());			
			 int i = pstmnt.executeUpdate();
			 System.out.println("index update "+i);			 
			 con.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return prod;
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public Product getObj(long id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public ArrayList<String> getNamesOfProducts() throws ClassNotFoundException {
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 ArrayList<String> names = new ArrayList<String>();
		 String prodName="", supplier="";
		 
		try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery("SELECT * FROM Product " + 
			 		"INNER JOIN Supplier ON Product.emailSupplier = Supplier.supplier_email;"); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
					prodName = resultSet.getString("prodName");
					supplier = resultSet.getString("emailSupplier");
					names.add(new String(prodName+ " "+ supplier));

			}con.close();				  
		 }catch(SQLException e){
		    e.printStackTrace();
		   }
		
		return names;
      // Just returning appropriate message otherwise
}

	 
	public ArrayList<Product> getAllLikedProducts(String mail) throws SQLException {
		 
		 Connection con = null;
			Statement statement = null;
			 ResultSet resultSet = null;
			 Product prod=new Product();
			 ArrayList<Product> products=new ArrayList<Product>();
			 Category category=null;

		try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement();
				 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCTLiked );
	            psmt.setString(1, mail);
	             resultSet= psmt.executeQuery();
				while(resultSet.next()) // Until next row is present otherwise it return false
				 {
					if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
						category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
					  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
							  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
					 	  products.add(prod);
					 	  System.out.println(prod.toString());
					}								
				 }
			 }catch(SQLException e){
			    e.printStackTrace();
			   } catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
		return products;
	}
	
	public ArrayList<Product> getNonLikedProducts(String mail) throws SQLException {
		 
		 Connection con = null;
			Statement statement = null;
			 ResultSet resultSet = null;
			 Product prod=new Product();
			 ArrayList<Product> products=new ArrayList<Product>();
			 Category category=null;
		 	  System.out.println(" non liked ");


		try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement();
				 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_PRODUCT_NOTLIKED );
	            psmt.setString(1, mail);
	             resultSet= psmt.executeQuery();
				while(resultSet.next()) // Until next row is present otherwise it return false
				 {
					if(!resultSet.getString("category").toString().equals("") || resultSet.getString("category").toString()!=null){
						category= Category.valueOf(resultSet.getString("category").toString().toUpperCase());
					  	prod= new Product(resultSet.getString("productID"),resultSet.getString("emailSupplier"), resultSet.getString("prodName"),
							  Double.parseDouble(resultSet.getString("priceOfPiece")), category, resultSet.getString("description"));
					 	  products.add(prod);
					 	  System.out.println(" non liked "+prod.toString());

					}								
				 }
			 }catch(SQLException e){
			    e.printStackTrace();
			   } catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		
		return products;
	}
	/**
	 * @param prod
	 */
	@SuppressWarnings("static-access")
	public void delete(Product prod) {
	   	 
		 Connection con = null;
		 Statement statement = null;
		 
		   String sql = "delete from Product where productID= ";

		    try {
		    	 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
		         statement.executeUpdate(sql+prod.getProdID());
		         System.out.println("Record deleted successfully");
		         con.close();
		    } catch (SQLException e) {
		      e.printStackTrace();
		    } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}

}
