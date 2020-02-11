/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Date;
import java.util.List;

import org.hibernate.SessionFactory;

import com.hajar.zaki.controller.MainMethods;
import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.Customer;
import com.hajar.zaki.model.ProductPicture;
import com.hajar.zaki.model.Supplier;
import com.hajar.zaki.model.User;
import com.hajar.zaki.model.UserImage;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Constatns;



/**
 * @author Hajar Amara
 *
 */
public class UserDAOImpl implements MainInterface<User> {

	SessionFactory sessionFactory;
	
	@SuppressWarnings("static-access")
	public String authenticateUser(User user) throws ClassNotFoundException{
	 
	 String email = user.getUserMail(); //Keeping user entered values in temporary variables.
	// String userName = user.getUserName(); //Keeping user entered values in temporary variables.
	 String password = user.getPassword();
	 
	 Connection con = null;
	 Statement statement = null;
	 ResultSet resultSet = null;
	 
	// String userNameDB = "";
	 String emailDB="";
	 String passwordDB = "";
	 
	try
	 {
		 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
		 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
		 resultSet = statement.executeQuery(Constatns.SELECT_FROM_USERS ); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
		 
		while(resultSet.next()) // Until next row is present otherwise it return false
		 {
		  emailDB = resultSet.getString("email"); //fetch the values present in database
		  passwordDB = resultSet.getString("pass");
		 
		   System.out.println(emailDB+" test here DAO  "+ passwordDB);
		  if(emailDB!=null&& email != null &&  password != null && passwordDB!=null) {
		   if(email.equals(emailDB) && password.equals(passwordDB)){
			   
		      return "SUCCESS"; ////If the user entered values are already present in database, which means user has already registered so I will return SUCCESS message.
		   }
		  }
		 }   con.close();
			   return "invalid deails";
		  
	 }catch(SQLException e){
	    e.printStackTrace();
	   }
	 return "you must to fill the rows"; // Just returning appropriate message otherwise
	 
	 }
	
	@SuppressWarnings("static-access")
	public String authenticateRegisteredUser(User user) throws ClassNotFoundException {
		
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 
		 String userEmail = user.getUserMail(); //Keeping user entered values in temporary variables.

		
		 String userMail = "";
		 
		 ////////
		 try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_USERS); //Here table name is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
			  userMail = resultSet.getString("email"); //fetch the values present in database
			 
			   if(userEmail.equals(userMail) )
			   {
			      return "User already there"; ////If the user entered values are already present in database, which means user has already registered so I will return SUCCESS message.
			   }
			 }
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   }
		 return "SUCCESS"; // Just returning appropriate message otherwise
		 
		 }

	 @SuppressWarnings("static-access")
	public String registerUser(User user) throws ClassNotFoundException {
		 
		 String firstName = user.getUserName();
		 String email = user.getUserMail();
		 String surName = user.getUserSurName();
		 String password = user.getPassword();
		 String phoneNumber= user.getPhoneNumber();
		 int city=user.getCity();
		 long addressId= readCity(city);

		 
		 System.out.println("test into userdao, "+firstName+ "test email "+email);
		 Connection con = null;
		 PreparedStatement preparedStatement = null;
		 
		 try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 //String query = "insert into Users(email,userName,surName,pass,addressId,phoneNumber) values (?,?,?,?,?,?)"; //Insert user details into the table 'USERS'
			 String query = Constatns.INSERT_INTO_USERS; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, email);
			 preparedStatement.setString(2,firstName);
			 preparedStatement.setString(3, surName);
			 preparedStatement.setString(4, password);
			 preparedStatement.setLong(5, addressId);
			 preparedStatement.setString(6, phoneNumber);
			 
			 
			 int i= preparedStatement.executeUpdate();
			 preparedStatement.close();
			 con.close();
			 if(user instanceof Customer) 
			   return registerCustomer(user);
			 if(user instanceof Supplier)
				   return registerSupplier(user);
		 }catch(SQLException e){
	    	 e.printStackTrace();
	    	}
		 
		 return "Oops.. Something went wrong there..!";  // On failure, send a message from here.
	 }

	/**
	 * @param city
	 * @return
	 */
	private int readCity(long addressid) {
	   return MainMethods.getInstance().readCity(addressid);
	}
	
	private String readCityFromAddress(long cityId) {
		if(cityId>0) {
			 Connection con;
				try {
					 con = (Connection) DBConnect.getInstance().createConnection();
					 Statement statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
					 ResultSet resultSet = statement.executeQuery(Constatns.SELECT_FROM_ADDRESS+cityId ); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
					 while(resultSet.next()) {
						 cityId=Integer.parseInt(resultSet.getString(1));
					return  readCityName(cityId);
					 }
					 
					 con.close();
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				} 
		}
		return "";
	}
	
	private String readCityName(long cityId) {
		String cityName="";
		if(cityId>0) {
			 Connection con;
				try {
					 con = (Connection) DBConnect.getInstance().createConnection();
					 Statement statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
					 ResultSet resultSet = statement.executeQuery(Constatns.SELECT_CITYNAME+cityId ); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
					while(resultSet.next()) {
						cityName=resultSet.getString(1);
					}
					
					con.close();
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				} 
		}
		return cityName;
	}

	

	/**
	 * @param user
	 * @throws ClassNotFoundException 
	 */
	private String registerSupplier(User user) throws ClassNotFoundException {
		 User supplier =new Supplier(user.getUserMail());
		 String email = supplier.getUserMail();
		 
		 Connection con = null;
		 PreparedStatement preparedStatement = null;		 
		 try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.INSERT_INTO_SUPPLIER; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, email);
			 
			 int i= preparedStatement.executeUpdate();
			 preparedStatement.close();
			 con.close();
			
			 if (i!=0) {  //Just to ensure data has been inserted into the database
			 return "SUCCESS"; 
			}
		 }catch(SQLException e){
	    	 e.printStackTrace();
	    	}
		 
		 return "Oops.. Something went wrong there..!";  // On failure, send a message from here.
	
	}

	/**
	 * @param user
	 * @throws ClassNotFoundException 
	 */
	private String registerCustomer(User user) throws ClassNotFoundException {
	     
		 User customer =new Customer(user.getUserMail());
		 String email = customer.getUserMail();		 
		 Connection con = null;
		 PreparedStatement preparedStatement = null;		 
		 try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.INSERT_INTO_CUSTOMER; 
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, email);
			 
			 int i= preparedStatement.executeUpdate();
			 preparedStatement.close();
			 con.close();
			
			 if (i!=0) {  //Just to ensure data has been inserted into the database
			 return "SUCCESS"; 
			}
		 }catch(SQLException e){
	    	 e.printStackTrace();
	    	}
		 
		 return "Oops.. Something went wrong there..!";  // On failure, send a message from here.
	
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(User user) {

		sessionFactory.getCurrentSession().saveOrUpdate(user);
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<User> getAllOfObjects() {
		 return sessionFactory.getCurrentSession().
				 createQuery("from Users")
	                .list();
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#deleteObject(long)
	 */
	@Override
	public void deleteObject(long id) {
		User user = (User) sessionFactory.getCurrentSession().load(
                User.class,id);
        if (null != user) {
            this.sessionFactory.getCurrentSession().delete(user);
        }
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public User getObj(long id) {
		return (User) sessionFactory.getCurrentSession().get(
                User.class, id);
	}
	
	public User getUserByEmail(String userEmail) throws ClassNotFoundException {
			
		     Connection con = null;
			 ResultSet resultSet = null;			 
			 String userNameDB = "", surName="",emailDB="", passwordDB = "", phoneNumber="", gender ="";
			 long addressId=0;
			 byte [] profilePic ;
			 User user = new User();
			 PreparedStatement preparedStatement = null;		 
			 try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection();
				 String query = Constatns.SELECT_ALL_USER; 
				 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
				 preparedStatement.setString(1, userEmail);
				 resultSet= preparedStatement.executeQuery();
				 if (resultSet.next()) {  //Just to ensure data has been inserted into the database
					  emailDB = resultSet.getString("email");
					  userNameDB=resultSet.getString("userName");
					  surName=resultSet.getString("surName");
					  passwordDB = resultSet.getString("pass");
					  addressId=resultSet.getLong("addressId");
					  phoneNumber=resultSet.getString("phoneNumber");
					  gender = resultSet.getString("gender");
		              profilePic = resultSet.getBytes("profileImage");
					  user= new User(emailDB,userNameDB,surName,passwordDB,phoneNumber,
							  MainMethods.getInstance().readCity(addressId),gender,profilePic);
					  System.out.println("user "+user);
					  return user;
				}
				 
				 con.close();		
			 }catch(SQLException e){
		    	 e.printStackTrace();
		    	}
			
			return user;
           // Just returning appropriate message otherwise
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#updateObj(java.lang.Object)
	 */
	@Override
	public User updateObj(User user) {
		PreparedStatement pstmnt= null;
		Connection con = null;
		System.out.println("into update obj "+user);
		try {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 con.setAutoCommit(true);
			 String query = Constatns.UPDATE_USER; 
			 pstmnt = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 pstmnt.setString(1,user.getUserName());
			 pstmnt.setString(2,user.getUserSurName());
			 pstmnt.setString(3, user.getPassword());
			 pstmnt.setLong(4, user.getAddressID());
			 pstmnt.setString(5, user.getPhoneNumber());
			 System.out.println( user.getGender());
			 pstmnt.setString(6, user.getGender());
			 pstmnt.setString(7,user.getUserMail());			
			 int i = pstmnt.executeUpdate();
			 System.out.println("index update "+i);
			 
			 con.close();
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}
	
	public ArrayList<String> getNamesOfUsers() throws ClassNotFoundException {
			 Connection con = null;
			 Statement statement = null;
			 ResultSet resultSet = null;
			 ArrayList<String> names = new ArrayList<String>();
			 String userNameDB="", surNameDB="";
			 
			try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
				 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
				 resultSet = statement.executeQuery(Constatns.SELECT_FROM_USERS_NAMES ); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
				 
				while(resultSet.next()) // Until next row is present otherwise it return false
				 {
						  userNameDB=resultSet.getString("userName");						  
						  surNameDB=resultSet.getString("surName");
						  names.add(new String(userNameDB+ " "+ surNameDB ));

				}con.close();				  
			 }catch(SQLException e){
			    e.printStackTrace();
			   }
			
			return names;
           // Just returning appropriate message otherwise
	}
	
	public UserImage getUserImage(String mail) {
		
		 Connection con = null;
		 ResultSet resultSet = null;
		 UserImage img= new UserImage();
		try{
			 con = (Connection) DBConnect.getInstance().createConnection();
			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SelectImage);
             psmt.setString(1, mail);
             resultSet= psmt.executeQuery();
            if(resultSet.next()){
               byte[] arrayImg = resultSet.getBytes("image");
               int picNum = resultSet.getInt("picNum");  
               img = new UserImage(mail,picNum,arrayImg);
            }
            con.close();
           
       }catch(Exception ex){
           ex.printStackTrace();
       }
		return img;
	}
	
	/**
	 * 
	 * @param user_img
	 * @return 1 if added -1 else 
	 */
	public int insertUserImage(UserImage user_img) {
		return -1;
		
//		 Connection con = null;
//		 ResultSet resultSet = null;
//		 UserImage img= new UserImage();
//		try{
//			 con = (Connection) DBConnect.getInstance().createConnection();
//			 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.InsertImgUser);
//            psmt.setString(1, user_img.getMail());
//            File image = new File(user_img.getImage().);
//            inputStream = new FileInputStream(image);
//            statement = connection.prepareStatement("insert into PicturesOfProducts(productId,image,imageFileName) " + "values(?,?,?)");
//            statement.setString(1, "22");
//            statement.setBinaryStream(2, (InputStream) inputStream, (int)(image.length()));
//            statement.setString(3, image.getName())
//            resultSet= psmt.executeUpdate();
//           if(resultSet.next()){
//              byte[] arrayImg = resultSet.getBytes("image");
//              int picNum = resultSet.getInt("picNum");  
//              img = new UserImage(mail,picNum,arrayImg);
//           }
//           con.close();
//          
//      }catch(Exception ex){
//          ex.printStackTrace();
//      }
//		return img;
	}
	
	
}
