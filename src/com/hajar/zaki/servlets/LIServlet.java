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
public class LIServlet extends HttpServlet{

		/**
		 * 
		 */
		public LIServlet() {
		}
		
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			 
			
			 HttpSession session=request.getSession(); 
			 System.out.println("tttttttttttttt "+ request.getAttribute("userName"));
		     session.setAttribute("userName",request.getParameter("userName"));  
		     session.setAttribute("email",request.getParameter("email"));  
		    
			 request.getRequestDispatcher("index.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.
		        
		       
		}
}
