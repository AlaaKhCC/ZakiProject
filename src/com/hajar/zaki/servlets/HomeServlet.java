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
public class HomeServlet extends HttpServlet {  
    protected void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
		response.setContentType("text/html");  
		request.getRequestDispatcher("link.html").include(request, response);  
		
		HttpSession session=request.getSession(false);  
		if(session!=null){  
		String name=(String)session.getAttribute("name");  
		
		}  
		else{  
		  request.getRequestDispatcher("login.jsp").include(request, response);  
		}   
		}  
}  