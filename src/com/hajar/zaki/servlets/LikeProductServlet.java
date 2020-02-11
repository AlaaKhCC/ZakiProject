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
public class LikeProductServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		ProductCustomerDAO pcdao = new ProductCustomerDAO();
		ProductCustomer prodCustomer = new ProductCustomer();
		ProductCustomer prodCustomer_tmp = new ProductCustomer();
		String mail = request.getParameter("mailCus");
		String prodId = request.getParameter("prodidLiked");
		String pageName = request.getParameter("jspPage");
		
		prodCustomer = new ProductCustomer(prodId,mail,1,0,"");

		if(mail != null && prodId != null  ) {
			    prodCustomer_tmp = pcdao.getProductCustomer(prodId, mail);
			    if(prodCustomer_tmp != null && prodCustomer_tmp.getProdId()!=null) {
			        pcdao.updateProductCustomerLike(prodCustomer);
			    }else {
					pcdao.addProductCustomerLike(prodCustomer);
			    }							
		}	
		
		request.getRequestDispatcher(pageName+"?value="+prodId).forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}

}
