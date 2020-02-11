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
public class FeedbackProductServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3912275008326063710L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ProductCustomerDAO pcdao = new ProductCustomerDAO();
		ProductCustomer prodCustomer = new ProductCustomer();
		String mail = request.getParameter("mailCus");
		String prodId = request.getParameter("prod_id_rated");
		String comment = request.getParameter("comment");
		String pageName = request.getParameter("jspPage");
		ProductCustomer prodCustomer_tmp = new ProductCustomer();

		if(mail != null && prodId != null && comment != null  ) {
	    	prodCustomer = new ProductCustomer(prodId,mail,0,0,comment);
			    prodCustomer_tmp = pcdao.getProductCustomer(prodId, mail);
			    if(prodCustomer_tmp != null && prodCustomer_tmp.getProdId() != null) {
			        pcdao.updateProductCustomerComment(prodCustomer);
			    }else {
					pcdao.addProductCustomerRating(prodCustomer);
			    }							
		}
		
		request.getRequestDispatcher(pageName+"?value="+prodId).forward(request, response);
	}
}
