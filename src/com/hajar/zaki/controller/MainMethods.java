/**
 * 
 */
package com.hajar.zaki.controller;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.hajar.zaki.db.DBConnect;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class MainMethods {
	
    private static MainMethods main_instance;
    
    private MainMethods () {
    	
    }

	 public static MainMethods getInstance() {
	        if (main_instance == null) {
	            main_instance = new MainMethods();
	        }
	        return main_instance;
	    }


	public int readCity(long addressid) {
		
		System.out.println(" into main methods address "+ addressid);
		int cityid=0;
		
		 Connection con;
		try {
			con = (Connection) DBConnect.getInstance().createConnection();
			 Statement statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 ResultSet resultSet = statement.executeQuery(Constatns.SELECT_CITYID_ADDRESSID+ addressid ); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 while(resultSet.next()) {
				 cityid=Integer.parseInt(resultSet.getString(1));
			 }
			 con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} //establishing connection
		
		System.out.println(" into readcity city id "+ cityid);
	  return  cityid;	
	}
	
	public int readAddress( long cityid) {
		 
		int addressid=0;		
		 Connection con;
		try {
			con = (Connection) DBConnect.getInstance().createConnection();
			 Statement statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
			 ResultSet resultSet = statement.executeQuery(Constatns.SELECT_FROM_ADDRESS+cityid); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
			 while(resultSet.next()) {
				 addressid=Integer.parseInt(resultSet.getString(1));
			 }
			 con.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} //establishing connection
	  return  addressid;	
	}
	
	   public String readCityName(long addressId) {
			
			System.out.println(" into main methods address "+ addressId);
			String cityName="";
			
			 Connection con;
			try {
				con = (Connection) DBConnect.getInstance().createConnection();
				 Statement statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
				 ResultSet resultSet = statement.executeQuery(Constatns.SELECT_CITYNAME+addressId); //Here table nam is users and userName,password are columns. fetching all the records and storing in a resultSet.
				 while(resultSet.next()) {
					cityName=(resultSet.getString(1));
				 }
				 con.close();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} //establishing connection
			
			System.out.println(" into readcity city name "+ cityName);
		  return  cityName;	
		}

}
