/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import java.io.Serializable;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hajar.zaki.dao.UserDAO;
import com.hajar.zaki.dao.UserDAOImpl;
import com.hajar.zaki.model.User;

/**
 * @author Hajar Amara
 *
 */
@SuppressWarnings("serial")
public class UserServlet extends HttpServlet{
	public UserServlet() {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		//Here username and password are the names which I have given in the input box in Login.jsp page. Here I am retrieving the values entered by the user and keeping in instance variables for further use. 
		 String email = request.getParameter("email");
		 String password = request.getParameter("pass");
		 System.out.println(email+"    test     "+password);
		 
		 //creating object for User class, which is a normal java class, contains just setters and getters. Bean classes are efficiently used in java to access user information wherever required in the application.
		 User user=new User();
		 user.setUserMail(email); //setting the username and password through the loginBean object then only you can get it in future.
		 user.setPassword(password);
		 
		 //creating object for UserDao. This class contains main logic of the application.
		 UserDAOImpl userDao=new UserDAOImpl();
		String userValidate = null;
		try {
			userValidate = userDao.authenticateUser(user);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} //Calling authenticateUser function
		 System.err.println(user.getUserMail());
		 System.out.println("testBolean"+"     here   "+userValidate.equals("SUCCESS"));
		if(userValidate.equals("SUCCESS")){ //If function returns success string then user will be rooted to Home page
			if(email!=null && userDao!=null && user!=null && userDao != null && user.getUserMail()!= null) {
				try {
					 user=userDao.getUserByEmail(user.getUserMail());
					 System.err.println(user.getUserMail());

					 System.out.println("test  number millllion "+"     here   "+user.getUserName()+"   "+user.getUserMail());

				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(user!=null){
					System.out.println("user name is here "+user.getUserName());
					 request.setAttribute("email",user.getUserMail()); 
					 request.setAttribute("userName",user.getUserName()); //with setAttribute() you can define a "key" and value pair so that you can get it in future using getAttribute("key")
					 request.setAttribute("password", user.getPassword());
				     request.setAttribute("surName", user.getUserSurName());
				     request.setAttribute("city", user.getCity());
				     request.setAttribute("phone", user.getPhoneNumber());

				     HttpSession session=request.getSession(true);  				     
				     session.setAttribute("userName",user.getUserName());  
				     session.setAttribute("email",user.getUserMail()); 
				     session.setAttribute("password", user.getPassword());
				     session.setAttribute("surName", user.getUserSurName());
				     session.setAttribute("city", user.getCity());
				     session.setAttribute("phone", user.getPhoneNumber());
				     
				    
					 request.getRequestDispatcher("index.jsp").forward(request, response); //RequestDispatcher is used to send the control to the invoked page.
				        
				}
			}
				
		}else{
		 request.setAttribute("errMessage", "invaild details"); //If authenticateUser() function returnsother than SUCCESS string it will be sent to Login page again. Here the error message returned from function has been stored in a errMessage key.
		 request.getRequestDispatcher("login.jsp").forward(request, response);//forwarding the request
		}
	 }

}
