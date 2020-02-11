/**
 * 
 */
package com.hajar.zaki.dao;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

import org.hibernate.SessionFactory;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.City;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class CityDAO implements MainInterface<City> {
	
	public CityDAO() {
		 Logger logger = Logger.getLogger("MyLog");  
         FileHandler fh;  

         try {  

             // This block configure the logger with handler and formatter  
             fh = new FileHandler("C:/Users/Hajar Amara/Desktop/LOGFILETEST");  
             logger.addHandler(fh);
             SimpleFormatter formatter = new SimpleFormatter();  
             fh.setFormatter(formatter);  

             // the following statement is used to log any messages  
             logger.info("My first log");  

         } catch (SecurityException e) {  
             e.printStackTrace();  
         } catch (IOException e) {  
             e.printStackTrace();  
         }  


         
	}
	
	SessionFactory sessionFactory;


	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#addObj(java.lang.Object)
	 */
	@Override
	public void addObj(City t) {
		// TODO Auto-generated method stub
		
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getObj(long)
	 */
	@Override
	public City getObj(long id) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.dao.MainInterface#getAllOfObjects()
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<City> getAllOfObjects() throws SQLException {
//		 return sessionFactory.getCurrentSession().//	 createQuery("from City").list();
		System.out.println("test fromm citydao ");
		 Connection con = null;
		 Statement statement = null;
		 ResultSet resultSet = null;
		 
		City city=new City();
		ArrayList<City> cities=new ArrayList<City>();
		 ////////
		 try
		 {
			 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
			 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 resultSet = statement.executeQuery(Constatns.SELECT_FROM_CITY); //Here table name is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 
			while(resultSet.next()) // Until next row is present otherwise it return false
			 {
				city.setCityID(Integer.parseInt(resultSet.getString("cityID")));
				city.setCityName(resultSet.getString("cityName"));  System.out.println(resultSet.getString("cityName"));
				city.setCountry_id(Integer.parseInt(resultSet.getString("country_id")));
			   cities.add(city);
			 }
			con.close();
		 }catch(SQLException e){
		    e.printStackTrace();
		   } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return cities; // Just returning appropriate message otherwise
		 
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
	public City updateObj(City t) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@SuppressWarnings({ "static-access" })
	public List<City> list() throws SQLException, ClassNotFoundException {
		
		 List<City> listCity = new ArrayList<City>(); 
		 
       try (Connection connection = (Connection) DBConnect.getInstance().createConnection()) {
           String sql = Constatns.SELECT_FROM_CITY;
           Statement statement = (Statement) connection.createStatement();
           ResultSet result = statement.executeQuery(sql);
            
           while (result.next()) {
               int id = result.getInt("cityID");
               String name = result.getString("cityName");
               City city=new City(id,result.getInt("country_id"), name);/// 1 to israel id  
               System.err.println(city.getCityID());
               listCity.add(city);
               
               ///////////////////////////////////////////////
               
              
               ///////////////////////////////////////////////
           }
           
           connection.close();
            
       } catch (SQLException ex) {
           ex.printStackTrace();
       }
       
       return listCity;
		
	}
}
