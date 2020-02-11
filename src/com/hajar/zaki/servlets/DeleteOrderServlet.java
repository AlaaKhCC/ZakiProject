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
import com.hajar.zaki.dao.OrderDetailsDAO;
import com.hajar.zaki.dao.ProductDAO;
import com.hajar.zaki.model.Order;
import com.hajar.zaki.model.Product;

/**
 * @author Hajar Amara
 *
 */
public class DeleteOrderServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 813856234514071458L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		OrderDAO odao = new OrderDAO();
		OrderDetailsDAO odas = new OrderDetailsDAO();
		Order o = new Order();
		String nameJsp = request.getParameter("jspPage");
		System.out.println("servlet delete order test ");			

		if(request.getParameter("o_num") != null) {
			
			o.setOrderNum(Integer.parseInt(request.getParameter("o_num")));
			odao.deleteOrder(o.getOrderNum());			
		}
		
		request.getRequestDispatcher(nameJsp).forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}
	
}
