/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.OrderDAO;
import com.hajar.zaki.model.Order;

/**
 * @author Hajar Amara
 *
 */
public class OrderConfirmationServlet extends HttpServlet {
/**
 * 
 */
	private static final long serialVersionUID = 2307948868951532056L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int num = Integer.parseInt(request.getParameter("o_num"));
		OrderDAO odao = new OrderDAO();
		Order o = new Order();
		o = odao.updateConfirmation(num);
		
	   request.getRequestDispatcher("sellerProfile.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.
	
		
		
	}
}