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
import com.hajar.zaki.dao.CustomerDAO;
import com.hajar.zaki.dao.SupplierDAO;
import com.hajar.zaki.dao.UserDAOImpl;
import com.hajar.zaki.model.Customer;
import com.hajar.zaki.model.Supplier;
import com.hajar.zaki.model.User;

/**
 * @author Hajar Amara
 *
 */
public class UpdateUserDataSupServlet extends HttpServlet {
	/**
	 * UpdateUserDataSupServlet
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name = request.getParameter("userName");
		String surName = request.getParameter("surName");
		String mail =  request.getParameter("mail");
		 mail = mail.replaceAll(" ", "");
		String gender = request.getParameter("gender");
		String[] genders = gender.split("-"); 
		String city =   request.getParameter("city");
		city = city.replace(" ", "");
		String phone =  request.getParameter("phone");
		String desc = request.getParameter("description");
		String nameJsp = "index.jsp";
		if(request.getParameter("jspPage") != null)
		nameJsp = request.getParameter("jspPage");
	    UserDAOImpl userDao=new UserDAOImpl();

	//System.out.println("update here "+ genders[2]+ name +" "+ surName+ " " + mail+" "+city+" "+phone+" pass ");

		try {
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
					 System.out.println(" city "+ city);

		  		   long addressId= MainMethods.getInstance().readAddress( Long.parseLong(city));
		  		   System.out.println("addressid into update seller  "+addressId);
		    	   u.setAddressID(new Long(addressId));
		    	   u.setPhoneNumber(phone);
		    	   u.setUserSurName(surName);
		    	   u.setUserMail(mail);
		    	   u.setPassword(u.getPassword());
		    	   u.setCity(Integer.parseInt(city));
			    	System.out.println("complete update here ");
					System.out.println("update " +u);	
			    	userDao.updateObj(u);	
			    	String is_sup =  request.getParameter("is_supplier");
			    	if( is_sup!= null && !is_sup.equals("no")) {
			    		 System.out.println("descriptton : "+desc);
					    	SupplierDAO supDao = new SupplierDAO();
					    	Supplier sup = new Supplier(u.getUserMail(), desc );
					    	sup.setAddressID(u.getAddressID());
					    	sup.setPhoneNumber(u.getPhoneNumber());
					    	sup.setUserName(u.getUserName());
					    	sup.setUserSurName(u.getUserSurName());
					    	sup.setPassword(u.getPassword());
					    	sup.setCity(u.getCity());
					    	supDao.updateObj(sup);
			    	}
			       
			 }
			    
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(nameJsp != null )
		 request.getRequestDispatcher(nameJsp).forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}

}
