/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hajar.zaki.dao.OrderDAO;
import com.hajar.zaki.dao.UserDAOImpl;
import com.hajar.zaki.model.Order;
import com.hajar.zaki.model.User;

import utils.Constatns;

/**
 * @author Hajar Amara
 *
 */
@WebServlet 
public class ContactServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5259834591032046693L; 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		  // outMail login Details
		HttpSession session=request.getSession(); 
		final String outmailUsername = "zakiproject2019@gmail.com" ;
		final String outmailPassword = Constatns.PASSWORD;
	    String mailCustomer = request.getParameter("mailCustomer");
	    mailCustomer= mailCustomer.replaceAll(" ", "");
	    UserDAOImpl userdao = new UserDAOImpl();
	    User u =new User();
	    try {
			u = userdao.getUserByEmail(mailCustomer);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String msg =" user need to order, please check your profile and orders!";
	    		        if(u != null) {
	    		        	msg = "<div id=\"msgId\" class=\"text-right\" style=\"display: none\"  >"+
	    		    		        
						"								    		,  שלום רב זאכי אדמין"+
						"								    		"+u.getUserName()+" בעל הדואר האלקטרוני :"+ u.getUserMail()+
						"								    		  שואל שאלה והינה: "+
						"								    		"+ request.getParameter("subject")+
						"								    		 הדואר האלקטרוני שלו/ה הינו: "+
						"								     </div>";
	    		        }
	    		        	
	

	    
	   // email ID of Recipient. 
	   String recipient = "hajar.amara.9@gmail.com"; 

	   // email ID of  Sender. 
	   String sender = outmailUsername ; 

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

	    System.out.println("check username and password "+ outmailPassword + " "+ outmailUsername );
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
		        message.setSubject("שאלת משתמש!","utf-8");
		        

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
