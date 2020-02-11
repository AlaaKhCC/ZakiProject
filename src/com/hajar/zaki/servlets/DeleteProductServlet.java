/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.ProductDAO;
import com.hajar.zaki.model.Product;

import utils.Category;

/**
 * @author Hajar Amara
 *
 */
public class  DeleteProductServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ProductDAO proddao = new ProductDAO();		
		Product prod = new Product ();
		prod.setProdID(request.getParameter("prodId_"));
		
		
		/// delete the order and the product
		proddao.delete(prod);
		
		request.getRequestDispatcher("sellerProfile.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}
}