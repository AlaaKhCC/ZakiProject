/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.hajar.zaki.dao.UserDAOImpl;
import com.hajar.zaki.model.Customer;
import com.hajar.zaki.model.Supplier;
import com.hajar.zaki.model.User;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
@SuppressWarnings("serial")
public class RegisterationServlet  extends HttpServlet {

	/**
	 * 
	 */

	public RegisterationServlet() {
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.err.println("u r innnnnnnnnnnnnnnnnn"
 		 		+ "");
		//Here username and password are the names which I have given in the input box in Login.jsp page. Here I am retrieving the values entered by the user and keeping in instance variables for further use.
		// add a new user to the system
		 String userName = request.getParameter("username");
		 String surName = request.getParameter("surname");
		 String email = request.getParameter("email");
		 String password = request.getParameter("pass");
		 String phoneNumber = request.getParameter("phoneNumber");
		 String city = request.getParameter("city");
		 
		 
		 boolean supcheckbox = false;
		 boolean cuscheckbox = false;
		 String[] values=request.getParameterValues("user");
		 if(values!=null)
		 if(values.length >0) {
			 if(values[0].equals("customer"))
				 cuscheckbox=true;
			 else
				 supcheckbox=true;
		 }
		 boolean fem=false, male=true;		
		 //creating object for User class, which is a normal java class, contains just setters and getters. Bean classes are efficiently used in java to access user information wherever required in the application.
		 User user=new User();
		 user.setUserName(userName); //setting the username and password through the loginBean object then only you can get it in future.
		 user.setUserSurName(surName);
		 user.setPassword(password);
		 user.setUserMail(email);
		 user.setPhoneNumber(phoneNumber);
		 user.setCity(Integer.parseInt(city));
		 
		 String[] genders=request.getParameterValues("gender");
		 if(genders!=null)
		 if(genders.length >0) {
			 if(genders[0].equals("female"))
				 user.setGender("FEMALE");
			 else
				 user.setGender("MALE");
		 }
		 
		 //creating object for UserDao. This class contains main logic of the application.
		 UserDAOImpl userDao=new UserDAOImpl();
		 System.out.println("checkbox test "+cuscheckbox !=null);
		String userValidate = null;
		try {
			if(cuscheckbox) {
				 System.out.println(" customer checkbox test if     :> "+user.getUserMail() +" test " );

				  Customer customer=new Customer(user.getUserMail());
				  customer.setUserName(user.getUserName());
				  customer.setPassword(user.getPassword());
				  customer.setUserSurName(user.getUserSurName());
				  customer.setPhoneNumber(user.getPhoneNumber());
				  customer.setCity(user.getCity());
				  userValidate = userDao.registerUser(customer);
			 }else {
				 if(supcheckbox) {
					 Supplier supplier=new Supplier(user.getUserMail());
					 supplier.setUserName(user.getUserName());
					  supplier.setPassword(user.getPassword());
					  supplier.setUserSurName(user.getUserSurName());
					  supplier.setPhoneNumber(user.getPhoneNumber());
					  supplier.setCity(user.getCity());
					  userValidate = userDao.registerUser(supplier);

				 }
			 }
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} //Calling authenticateUser function
		 if(userValidate != null)
		if(userValidate.equals("SUCCESS")) //If function returns success string then user will be rooted to Home page
		 {
			
			 request.setAttribute("userName", userName); //with setAttribute() you can define a "key" and value pair so that you can get it in future using getAttribute("key")
//			 request.getRequestDispatcher("index.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.
			  request.getRequestDispatcher("login.jsp").forward(request, response);
		 }
		 else
		 {
			 request.setAttribute("errMessage", userValidate); //If authenticateUser() function returnsother than SUCCESS string it will be sent to Login page again. Here the error message returned from function has been stored in a errMessage key.
			// request.getRequestDispatcher("register.jsp").forward(request, response);//forwarding the request
			  request.getRequestDispatcher("register.jsp").forward(request, response);
		 }
		 }


	
	

}
