/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.OrderDAO;
import com.hajar.zaki.dao.OrderDetailsDAO;
import com.hajar.zaki.model.Order;

/**
 * @author Hajar Amara
 *
 */
public class DeleteAllOrdersOFCustomer extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		OrderDAO odao = new OrderDAO();
		ArrayList<Order> orders = new ArrayList<>();
		String mail = request.getParameter("mailCustomer");
		System.out.println("test "+ mail + " test ");

		mail=mail.replace(" ", "");
		orders = odao.getOrderdPerCustomer(mail);
		OrderDetailsDAO odas = new OrderDetailsDAO();
		System.out.println("servlet delete all order test ");			

		for(Order o : orders) {
			System.out.println("servlet delete order "+ o.getOrderNum());			
			odas.deleteObject(o.getOrderNum());
			odao.deleteObject(o.getOrderNum());
		}
		request.getRequestDispatcher("cart.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}

}
