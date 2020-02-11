/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.ProductDAO;
import com.hajar.zaki.dao.UserDAOImpl;
import org.json.JSONArray;

/**
 * @author Hajar Amara
 *
 */
public class AutoCompleteServlet extends HttpServlet {
	
	 private static final long serialVersionUID = 1L;
	 
	    public AutoCompleteServlet() {
	        super();
	 
	    }
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	  ArrayList<String> listofnames=new ArrayList<String>();
	  try{
		    ProductDAO proddao= new  ProductDAO();
			UserDAOImpl userdao = new UserDAOImpl();
			listofnames.addAll(proddao.getNamesOfProducts());
			listofnames.addAll(userdao.getNamesOfUsers());			
	  }catch(Exception e){
	   e.printStackTrace();
	  }
	   JSONArray json=new JSONArray(listofnames );
	   response.setContentType("application/json");
	         response.getWriter().print(json);
	 }   
	}