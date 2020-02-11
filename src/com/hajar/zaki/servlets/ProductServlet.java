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

import com.hajar.zaki.dao.ProductDAO;
import com.hajar.zaki.model.Product;

/**
 * @author Hajar Amara
 *
 */
public class ProductServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
	     HttpSession session=request.getSession(true);  
	     String id = (String) request.getParameter("id");
	     
	     ProductDAO prodDao = new ProductDAO();
	     Product prod = prodDao.getProductPerId(id);
	     System.out.println(prod.getProdID());
	     
	      System.out.println("test in productservlet  "+ session.getAttribute("productId")+ " name " + session.getAttribute("productName")+ "  "+ session.getAttribute("price")) ;
	      request.setAttribute("productId",prod.getProdID());
	      request.setAttribute("productName",prod.getName());
	      request.setAttribute("descrition",prod.getDescription());
	      request.setAttribute("price",prod.getPiece_price());
	      
	     
	     session.setAttribute("productName",prod.getName());
	     session.setAttribute("description",prod.getDescription());
	     session.setAttribute("price",prod.getPiece_price());	
	     session.setAttribute("category",prod.getCategory());	    

		 request.getRequestDispatcher("product.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.
	     
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	

}
