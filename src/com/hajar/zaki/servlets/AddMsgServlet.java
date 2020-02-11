/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.MessageDAO;
import com.hajar.zaki.model.Message;

/**
 * @author Hajar Amara
 *
 */
public class AddMsgServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String msg = request.getParameter("usermsg");
		String  mail1 = request.getParameter("mailUser1");
		String  mail2 = request.getParameter("mailUserSup");
		Message msgObj = new Message(mail1,mail2,msg,new Timestamp((new Date()).getTime()));		
		MessageDAO msgdao = new MessageDAO();
	    System.out.println(" content msgObj "+ msgObj.getContent());

		msgdao.addMSG(msgObj);		
		request.setAttribute("userMail1", mail1);		
		request.setAttribute("msgs", msgdao.readMSGsPerMail(mail1, mail2));
		
		request.getRequestDispatcher("chat.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.
		
	}

}
