/**
 * 
 */
package com.hajar.zaki.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.hajar.zaki.db.DBConnect;
import com.hajar.zaki.model.Message;
import com.hajar.zaki.model.Product;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;

import utils.Category;
import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class MessageDAO {
	
	public void addMSG(	Message msg ) {
		
		 Connection con = null;
		 PreparedStatement preparedStatement = null;
		 
		 try
		 {
			 Class.forName("com.mysql.jdbc.Driver");
			 con = (Connection) DBConnect.getInstance().createConnection();
			 String query = Constatns.INSERT_INTO_MSG; 
			 System.out.println(" content msg "+ msg.getContent());
			 preparedStatement = (PreparedStatement) con.prepareStatement(query); //Making use of prepared statements here to insert bunch of data
			 preparedStatement.setString(1, msg.getMail1());//from
			 preparedStatement.setString(2, msg.getMail2());//to
			 preparedStatement.setString(3, msg.getContent());
			 preparedStatement.setTimestamp(4, msg.getTime());			 
			 
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
	
	public ArrayList<Message> readMSGsPerMail(	String  mail , String mail2) {
		
		    Message msg = new Message();
		    ArrayList<Message> msgs = new ArrayList<Message>();
			 Connection con = null;
			 Statement statement = null;
			 ResultSet resultSet = null;
			 
			try
			 {
				 con = (Connection) DBConnect.getInstance().createConnection();
				 PreparedStatement psmt =  (PreparedStatement) con.prepareStatement(Constatns.SELECT_FROM_MSG);
				 psmt.setString(1, mail);
				 psmt.setString(2, mail2);
	             resultSet= psmt.executeQuery();
				if(resultSet.next()) // Until next row is present otherwise it return false
				 {
						 msg= new Message(Integer.parseInt(resultSet.getString("msgNum")), resultSet.getString("userEmail1"),resultSet.getString("userEmail2"),
								  resultSet.getString("content"),  resultSet.getTimestamp("time"));						 
				         msgs.add(msg);
				 }
				
				con.close();
			 }catch(SQLException e){
			    e.printStackTrace();
			   } catch (ClassNotFoundException e) {
				e.printStackTrace();
			}	
			return msgs;
	}
}
