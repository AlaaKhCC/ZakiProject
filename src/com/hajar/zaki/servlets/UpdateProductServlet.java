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
import com.hajar.zaki.dao.ProductDAO;
import com.hajar.zaki.dao.SupplierDAO;
import com.hajar.zaki.dao.UserDAOImpl;
import com.hajar.zaki.model.Product;
import com.hajar.zaki.model.Supplier;
import com.hajar.zaki.model.User;

import utils.Category;

/**
 * @author Hajar Amara
 *
 */
public class UpdateProductServlet extends HttpServlet {
	         
	/**
	 * 
	 */
	private static final long serialVersionUID = -3537238960843906884L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id_prod");
		String name = request.getParameter("productName");
		String mail =  request.getParameter("mailSup");
		 mail = mail.replaceAll(" ", "");
		Double price = Double.parseDouble(request.getParameter("new_price"));
		String description = request.getParameter("new_description");
		Category category =  null ;
		String a = request.getParameter("new_category");
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
		Product prod =new  Product(id,mail,name,price,category,description);	

	//System.out.println("update here "+ genders[2]+ name +" "+ surName+ " " + mail+" "+city+" "+phone+" pass ");

		try {
			  ProductDAO proddao = new ProductDAO();
			  proddao.updateObj(prod);
			    
		} catch ( Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		 request.getRequestDispatcher("sellerProfile.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}

}
