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

import com.hajar.zaki.dao.OrderDAO;
import com.hajar.zaki.model.Order;

/**
 * @author Hajar Amara
 *
 */
public class OrderServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			  throws ServletException, IOException {
		
	}
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			  throws ServletException, IOException {
		String productId="";
		
		String email= (String) request.getParameter("val1");
		System.out.println(request.getParameter(email)+" ");
		if ( email != null && request.getParameter("val2") != null && request.getParameter("quantity")!= null 
		          &&request.getParameter("val3")!= null ){
		productId=  (String) request.getParameter("val2");
		Double val2=  Double.parseDouble(request.getParameter("quantity"));
		String val3=  (String) request.getParameter("val3");
		
		System.out.print("test in product val2 val3 "+ val2+ " "+ val3);
		if(productId != null && val2 != null && val3 != null){
			OrderDAO orderDao= new OrderDAO();
			orderDao.addObj(new Order(email,productId,val2));
		}
	  }
		
		
	
		 request.getRequestDispatcher("product.jsp").forward(request, response);
	}

}
