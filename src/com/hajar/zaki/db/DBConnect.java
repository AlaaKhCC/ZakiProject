/**
 * 
 */
package com.hajar.zaki.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

import org.springframework.orm.jpa.vendor.Database;

import com.sun.xml.bind.v2.runtime.reflect.opt.Const;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class DBConnect {
	

	   // private static final Logger logger = Logger.getLogger(DBConnection.class);
	    private static DBConnect instance;
	    private static final String URL =Constatns.DATABASE_URL; 
	    private static final String USER = Constatns.USERNAME;
	    private static final String PASSWORD = Constatns.PASSWORD;

	    private DBConnect() {
	        try {
	            Class.forName(Constatns.DATABASE_DRIVER);
	           // logger.info("Database(): MySQL driver loaded");
	        } catch (ClassNotFoundException e) {
	           // logger.error("Database(): MySQL driver failed to load", e);
	            System.exit(0);
	        }
	    }

	    public static DBConnect getInstance() {
	        if (instance == null) {
	            instance = new DBConnect();
	        }
	        return instance;
	    }

	   private static Connection getConnection() throws SQLException, ClassNotFoundException {
	       Class.forName(Constatns.DATABASE_DRIVER);
	        return DriverManager.getConnection(URL, USER, PASSWORD);
	    }
	    
	    public static Connection createConnection() throws SQLException, ClassNotFoundException{
	    	return getConnection();
	    }

	

}
