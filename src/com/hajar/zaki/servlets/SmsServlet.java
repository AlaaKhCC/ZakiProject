package com.hajar.zaki.servlets;

  
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.*; 
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hajar.zaki.dao.OrderDAO;
import com.hajar.zaki.dao.UserDAOImpl;
import com.hajar.zaki.model.Order;
import com.hajar.zaki.model.User;

import utils.Constatns;

import javax.activation.*;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session; 
import javax.mail.Transport; 
  
  
public class SmsServlet  extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5259834591032046693L; 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  // outMail login Details
		HttpSession session=request.getSession();  
	      
	    final String outmailUsername = "zakiproject2019@gmail.com" ;
	    final String outmailPassword = Constatns.PASSWORD;
	    String email= request.getParameter("customerMail"); 
	     session.setAttribute("email",email);
	    System.out.println(email+" in sms email test ");
	    User user =new User();
		UserDAOImpl userdao= new UserDAOImpl();
		OrderDAO orderDao= new OrderDAO();
		ArrayList<Order> orders = new ArrayList<Order>();
	    try {
			user= userdao.getUserByEmail(email);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		orders = orderDao.getOrderdPerCustomer(email);
		String msg =" user need to order, please check your profile and orders!";
	    		        if(user != null) {
	    		        	msg = "<div id=\"msgId\" class=\"text-right\" style=\"display: none\"  >"+
	    		    		        
						"								    		,שלום "+
						"								    		"+user.getUserName()+
						"								    		  רוצה להזמין ההזמנוה  נמצאת באתר, מספר הטלפון הינו: "+
						"								    		"+ user.getPhoneNumber()+
						"								    		האי-מייל הינו:"+
						"								    		"+ user.getUserMail()+
						"								    		כנס/י לאתר כדי לאשר לו ההזמנה או יצר איתו קשר."+
						"								    		"+
						"								    		<% "+
						"								    		  String msgContent=\"\";"+
						"								    		 "+
						"								    		%>"+
						"								     </div>";
	    		        }
	    		        	
	

	    
	   // email ID of Recipient. 
	   String recipient = "hajar.amara.9@gmail.com"; 

	   // email ID of  Sender. 
	   String sender = "zakiproject2019@gmail.com"; 

	   // using host as localhost 
	   String host = "localhost";
	   System.out.println(host);
	   final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";

	   // Getting system properties 
		   Properties properties = System.getProperties(); 

		   // Setting up mail server 
	    properties.setProperty("mail.smtp.host", "smtp.gmail.com");
	    properties.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
	    properties.setProperty("mail.smtp.socketFactory.fallback", "false");
	    properties.setProperty("mail.smtp.port", "465");
	    properties.setProperty("mail.smtp.socketFactory.port", "465");
	    properties.put("mail.smtp.auth", "true");
	    properties.put("mail.debug", "true");
	    properties.put("mail.store.protocol", "pop3");
	    properties.put("mail.transport.protocol", "smtp");

	    
	    Authenticator auth = new Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(outmailUsername, outmailPassword);
	        }
	    };
	    
		   // creating session object to get properties 
		   Session session1 = Session.getInstance(properties,auth);

		   try {
			   
		        MimeMessage message = new MimeMessage(session1);
		        message.setFrom(new InternetAddress(sender));
		        message.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
		        message.setSubject("הזמנה באתר!","utf-8");
		        
		        
		        System.out.println("test in sms "+msg);

		        System.out.println(msg);
		        if(msg!=null)
		        message.setText((String) msg,"utf-8");
		        message.setHeader("Content-Type", "text/html; charset=UTF-8");
		        Transport.send(message);
		        System.out.println("Sent Successfully");
		    } 
		    catch (MessagingException mex) {
		        mex.printStackTrace();
		    }
		   
			 request.getRequestDispatcher("thankYou.jsp").forward(request, response);//RequestDispatcher is used to send the control to the invoked page.

	}
	
	

} 