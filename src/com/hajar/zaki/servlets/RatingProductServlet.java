/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.ProductCustomerDAO;
import com.hajar.zaki.model.ProductCustomer;

/**
 * @author Hajar Amara
 *
 */
public class RatingProductServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8948809096520049311L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ProductCustomerDAO pcdao = new ProductCustomerDAO();
		ProductCustomer prodCustomer = new ProductCustomer();
		ProductCustomer prodCustomer_tmp = new ProductCustomer();
		String mail = request.getParameter("mailCus");
		String prodId = request.getParameter("prod_id_rated");
		String rate = request.getParameter("rate");
		String pageName = request.getParameter("jspPage");

		int rating = 0;
		
		if(rate != null){
			switch(rate) {
			case "one" : rating = 1; break;
			case "two" : rating = 2; break;
			case "three" : rating = 3; break;
			case "four" : rating = 4; break;
			case "five" : rating = 5; break;
			}
		}
    	prodCustomer = new ProductCustomer(prodId,mail,0,rating,"");

		if(mail != null && prodId != null  ) {
			    prodCustomer_tmp = pcdao.getProductCustomer(prodId, mail);
			    if(prodCustomer_tmp != null && prodCustomer_tmp.getProdId() != null) {
			        pcdao.updateProductCustomerRate(prodCustomer);
			    }else {
					pcdao.addProductCustomerRating(prodCustomer);
			    }							
		}
		
		request.getRequestDispatcher(pageName+"?value="+prodId).forward(request, response);
	}
}
