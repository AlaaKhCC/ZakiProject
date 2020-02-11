/**
 * 
 */
package com.hajar.zaki.servlets;


import java.sql.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.hajar.zaki.db.DBConnect;
/**
 * @author Hajar Amara
 *
 */


public class DisplayImageServlet extends  HttpServlet{
 	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		  //PrintWriter pw = response.getWriter();
		  String connectionURL = "jdbc:mysql://192.168.10.59:3306/example";
		  java.sql.Connection con=null;
		  try{  
			  Class.forName("com.mysql.jdbc.Driver");
			  con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection  
			  Statement st1=con.createStatement();
			  String prodId=(String) request.getAttribute("prodId");
			  ResultSet rs1 = st1.executeQuery("select image from PicturesOfProducts where productId="+prodId);
			  String imgLen="";
			  if(rs1.next()){
				  imgLen = rs1.getString(1);
				  System.out.println(imgLen.length());
			  }  
			  rs1 = st1.executeQuery ("select image from PicturesOfProducts where productId="+prodId);
			  if(rs1.next()){
				  int len = imgLen.length();
				  byte [] rb = new byte[len];
				  InputStream readImg = rs1.getBinaryStream(1);
				  int index=readImg.read(rb, 0, len);  
				  System.out.println("index"+index);
				  st1.close();
				  response.reset();
				  response.setContentType("image/jpg");
				  response.getOutputStream().write(rb,0,len);
				  response.getOutputStream().flush();  
			  }
		  }catch (Exception e){
			  e.printStackTrace();
		  }
  }
}