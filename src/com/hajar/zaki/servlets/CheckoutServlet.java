/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Hajar Amara
 *
 */
public class CheckoutServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7039867964723396779L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		
		 HttpSession session=request.getSession();  
	     session.setAttribute("userName",request.getParameter("userName"));  
	     session.setAttribute("email",request.getParameter("email"));  
	     session.setAttribute("password", request.getAttribute("password"));
	     session.setAttribute("surName", request.getAttribute("surName"));
	     session.setAttribute("city", request.getAttribute("city"));
	     session.setAttribute("phone", request.getAttribute("phone"));
	     
		 request.getRequestDispatcher("CustomerMSGDetails.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.
	        
	       
	}

}
