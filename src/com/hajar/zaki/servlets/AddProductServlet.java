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
public class AddProductServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductDAO proddao = new ProductDAO();		
		Product prod = new Product ();
		prod.setProdID(request.getParameter("id"));
		System.out.println(" category : "+request.getParameter("category")+" id "+ request.getParameter("id"));
		Category category=null;
		//prod.setCategory(category);
		String a = request.getParameter("category");
		switch (a) {
		case "1" : category= Category.SALAD;
		           break;
		case "2" : category= Category.SWEET;
                   break;
		case "3" : category= Category.APPETIZERS;
                   break;
		case "4" : category= Category.MAINCOURSE;
                   break;
		}
		prod.setDescription((request.getParameter("description")));
		prod.setName((request.getParameter("prodName")));
		prod.setPiece_price(Double.parseDouble(request.getParameter("price")));
		prod.setSupID((request.getParameter("email")));
		prod.setCategory(category);
		if(prod != null) 
			proddao.addObj(prod);
		
		request.getRequestDispatcher("sellerProfile.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

		
		
	}

}
