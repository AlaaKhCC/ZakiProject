/**
 * 
 */
package com.hajar.zaki.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.hajar.zaki.db.DBConnect;
 
/**
 * @author Hajar Amara
 *
 */
public class InsertImageDao {
	 
		public static void main(String[] args) throws SQLException {
			InsertImageDao imageDao = new InsertImageDao();
			imageDao.insertImage();
		}
	 
		
	 
		public void insertImage() {
	        Connection connection = null;
	        PreparedStatement statement = null;
	        FileInputStream inputStream = null;
	        try{
				    Class.forName("com.mysql.jdbc.Driver");
					connection = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
		            File image = new File("C:/Users/Hajar Amara/eclipse-workspace/zakiProj/WebContent/view/images/cookies.jpg");
		            inputStream = new FileInputStream(image);
		            statement = connection.prepareStatement("insert into PicturesOfProducts(productId,image,imageFileName) " + "values(?,?,?)");
		            statement.setString(1, "22");
		            statement.setBinaryStream(2, (InputStream) inputStream, (int)(image.length()));
		            statement.setString(3, image.getName());
		 
		            statement.executeUpdate();
		            connection.close();
	                statement.close();
	 
	        }catch (SQLException e) {
	            System.out.println("SQLException: - " + e);
	        } catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}


}