/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.controller.MainMethods;
import com.hajar.zaki.dao.CityDAO;
import com.hajar.zaki.dao.UserDAOImpl;
import com.hajar.zaki.model.User;

/**
 * @author Hajar Amara
 *
 */
public class UpdateUserDataServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8476946354231762565L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("userName");
		String surName = request.getParameter("surName");
		String mail =  request.getParameter("mail");
		 mail = mail.replaceAll(" ", "");
		String gender = request.getParameter("gender");
		String[] genders = gender.split("-"); 
		String city =   request.getParameter("city");
		String phone =  request.getParameter("phone");
		String nameJsp = "";
		if(request.getParameter("jspPage") != null)
         nameJsp = request.getParameter("jspPage");

	    UserDAOImpl userDao=new UserDAOImpl();

	//System.out.println("update here "+ genders[2]+ name +" "+ surName+ " " + mail+" "+city+" "+phone+" pass ");

		try {
			 System.out.println(" city "+ city);
			  User u = new User();
			  System.out.println(mail);
			  u = userDao.getUserByEmail(mail); 
			  
			  System.out.println(" is null? "+ u);				  
			  if(u != null && u.getUserMail() != null) {
				  System.out.println("update here  u "+ u.getUserMail());			  
		    	   u.setUserName(name);
		    	   if(genders.length>1) {
		    		   u.setGender(genders[2]);
		    	   }else {
		    		   u.setGender(genders[0]);
		    	   }
		    	   
		  		   long addressId= MainMethods.getInstance().readCity(Integer.parseInt(city));
		    	   u.setCity(Integer.parseInt(city));
		    	   u.setAddressID(new Long(addressId));
		    	   u.setPhoneNumber(phone);
		    	   u.setUserSurName(surName);
		    	   u.setUserMail(mail);
		    	   u.setPassword(u.getPassword());
		    	   u.setCityName(MainMethods.getInstance().readCityName(addressId));
			    	System.out.println("complete update here ");
					System.out.println("update " +u);	
			    	userDao.updateObj(u);
			 }
			    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(nameJsp != null)
		 request.getRequestDispatcher(nameJsp).forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}

}
