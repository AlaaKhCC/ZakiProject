/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import java.sql.Date;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.OrderDAO;
import com.hajar.zaki.dao.OrderDetailsDAO;
import com.hajar.zaki.dao.ProductDAO;
import com.hajar.zaki.model.Order;
import com.hajar.zaki.model.OrderDetails;
import com.hajar.zaki.model.Product;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
public class AddOrderServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		OrderDAO orderDao = new OrderDAO();
		String email = request.getParameter("mailCus");
		String productId = request.getParameter("prod_id");
		String pageName = request.getParameter("jspPage");
		if(email != null && productId != null) {
			Order order = new Order(email, (String) productId, new Double(1));
			if(order != null && order != null){
				int id =orderDao.addOrder(order);
				OrderDetailsDAO odsDao = new OrderDetailsDAO();
				OrderDetails ods = new OrderDetails();
				Date date =  new  Date(Calendar.getInstance().getTime().getTime());
				ProductDAO proddao = new ProductDAO();
				Product prod = proddao.getProductPerId(productId);
				ods = new OrderDetails(id,date, date, prod.getPiece_price(),prod.getDescription(),new Double(0), Constatns.STATUS_IN_PROGRESS );
				//(int numberOrder, Date orderDate, Date requireDate, Double price, String description, Double discount, String status)
				odsDao.addObj(ods);
			}
		}
		request.getRequestDispatcher(pageName).forward(request, response);

	}

}
