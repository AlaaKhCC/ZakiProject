<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=utf-8" %>

<%@ page import="javax.activation.*, javax.mail.Authenticator, javax.mail.Message, javax.mail.MessagingException,
                 javax.mail.NoSuchProviderException, javax.mail.PasswordAuthentication, javax.mail.Session, javax.mail.Transport,
                 java.io.IOException, java.net.InetAddress, java.net.UnknownHostException, java.util.*, javax.mail.internet.*,
				 javax.servlet.ServletException, javax.servlet.http.HttpServlet, javax.servlet.http.HttpServletRequest,
                 javax.servlet.http.HttpServletResponse, utils.Constatns,  java.net.InetAddress, java.net.UnknownHostException, java.util.*, javax.mail.internet.*,
                 com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl,com.hajar.zaki.model.User , com.hajar.zaki.dao.ProductDAO, 
				 com.hajar.zaki.model.Product, com.hajar.zaki.model.Order ,  com.hajar.zaki.model.OrderDetails, com.hajar.zaki.dao.OrderDAO, 
				javax.servlet.http.HttpSession" %>
<%@page import="com.hajar.zaki.model.Customer, com.hajar.zaki.dao.SupplierDAO,  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier "%>
				

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
<title>Thank you</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Little Closet template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="view/styles/bootstrap-4.1.2/bootstrap.min.css">
<link href="view/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="view/styles/checkout.css">
<link rel="stylesheet" type="text/css" href="view/styles/checkout_responsive.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://unpkg.com/gijgo@1.9.11/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.11/css/gijgo.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="view/styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="view/styles/responsive.css">


<script type="text/javascript">
	function HandleTimeSelect(a){
		$(a).closest(".timepickercontainer").attr("data-value", $(a).text());
		$(a).closest(".timepickercontainer").find("button").first().html($(a).text() + " <i class='caret'></i>");
		$(a).closest(".timepickercontainer").find("li.active").each(function() {$(this).removeClass("active");});
		$(a).parent().addClass("active");
	}
	function ScrollToActive(btn){
		//console.log("scrolling down "+  $(btn).closest(".timepickercontainer").find(".dropdown-menu").first());
		//$(btn).closest(".timepickercontainer").find(".dropdown-menu").first().scrollTop(600);
		$(btn).closest(".timepickercontainer").find(".dropdown-menu").first().on('show.bs.dropdown', function () {
				$(btn).closest(".timepickercontainer").find(".dropdown-menu").first().scrollTop(600);
				console.log("performing");

		});
	}
	function SetScrollValue(ul){
		$(ul).scrollTop(600);
		console.log("setting scroll");
	}
	function SetScrollValues(){
	 $(".dropdown.focus-active").on("shown.bs.dropdown", function() {$(this).find(".dropdown-menu li.active a").focus();});
	}
</script>
<style type="text/css">
input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

input[type=submit] {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>
</head>

<body>

                  
         
       
      
			
			 <%

				String userName = "";
				String password = "";
				String email = "";
				/* Get below data from HttpSession. */
				
		    	ArrayList<Order> orders = new ArrayList<>();

	
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				boolean sup = false;
				User user = new User ();
				UserDAOImpl userdao = new UserDAOImpl();
				OrderDAO orderdao = new OrderDAO();
				String surName ="";
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
			    System.out.println(" alaa boma test      > "+ userNameObj);
				if(userNameObj!=null){
					userName = (String)userNameObj;
				}
				
				if(emailObj!=null){
					email = (String)emailObj;
					email = email.replaceAll(" ", "");
					user= userdao.getUserByEmail(email);
					orders= orderdao.getOrderdPerCustomer(email);

				for(Supplier s : suppliers){

						if(s.getUserMail().equals(email)){
							sup = true;
							System.out.print("include the supplier "+ suppliers.contains((email)) +"  test ");
							break;
						}
					}
						for(Customer cus : customers){
							if(cus.getUserMail().equals(email)){
								sup = false;
								break;
							}
						}
				}
			
			%>
			
			
			
			
			
<!-- Menu -->


<div class="menu">

	<!-- Search -->
	<div class="menu_search">
		<form action="#" id="menu_search_form" class="menu_search_form">
			<button class="menu_search_button"><img src="view/images/search.png" alt=""></button>
			<input type="text" class="search_input" placeholder="חפש משהו טעים" required="required">
		</form>
	</div>
	<!-- Navigation -->
	<div class="menu_nav">
		<ul>
		            <li ><a href="category.jsp?userName=<%=userName%>&email=<%=email%>">מנה ראשונה </a></li>
					<li><a href="mainCourse.jsp?userName=<%=userName%>&email=<%=email%>">מנה עיקרית</a></li>
					<li><a href="sweet.jsp?userName=<%=userName%>&email=<%=email%>">קינוח</a></li>
					<li ><a href="salad.jsp?userName=<%=userName%>&email=<%=email%>">סלט</a></li>
		</ul>
	</div>
	<!-- Contact Info -->
	<div class="menu_contact">
		<div class="menu_phone d-flex flex-row align-items-center justify-content-start">
		</div>
		<div class="menu_social">
			<ul class="menu_social_list d-flex flex-row align-items-start justify-content-start">
				<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
				<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
			</ul>
		</div>
	</div>
</div>

<div class="super_container">

	<!-- Header -->

	<header class="header">
		<div class="header_overlay"></div>
		<div class="header_content d-flex flex-row align-items-center justify-content-start">
			
			<div class="logo">
				 <form action="<%=request.getContextPath()%>LIServlet">
				 <a href="index.jsp">
					<div class="d-flex flex-row align-items-center justify-content-start">
						<div class=""><img src="view/images/logo5.png" alt="" height="80" width="130"></div>
					</div>
				</a></form>
			</div>
		<div class="header_right d-flex flex-row align-items-center justify-content-start ml-auto">

			<div class="hamburger"><i class="fa fa-bars" aria-hidden="true"></i></div>
			<nav class="main_nav">
				<ul class="d-flex flex-row align-items-start justify-content-start">
					
					<li ><a href="category.jsp?userName=<%=userName%>&email=<%=email%>">מנה ראשונה </a></li>
					<li><a href="mainCourse.jsp?userName=<%=userName%>&email=<%=email%>">מנה עיקרית</a></li>
					<li><a href="sweet.jsp?userName=<%=userName%>&email=<%=email%>">קינוח</a></li>
					<li  ><a href="salad.jsp?userName=<%=userName%>&email=<%=email%>">סלט</a></li>
					
					</ul>
			</nav>

		</div>
		
		       <!-- Search -->
				<div class="header_search">
					<form action="#" id="header_search_form">
						<button class="header_search_button"><img src="view/images/search.png" alt=""></button>
						<input type="text" class="search_input" placeholder="חפש משהו טעים" required="required">
					</form>
				</div>
		       <!-- Phone -->
				<div class="header_phone d-flex flex-row align-items-center justify-content-start"></div>
				<!-- Cart -->
				<!-- Cart -->
				 <% if(!userName.equals("")){
					 if(!sup){	 %>
					  <div  class="user">
				   <div class="user">
				    <a href="cart.jsp">
				     <div><img src="view/images/cart.svg" alt="https://www.flaticon.com/authors/freepik" >
				    <% if(orders.size() > 0){ %>
				    <div><%= orders.size()%></div>
				    <%} %></div></a>
					<div id="userName" style="color:black;"> </div>
					</div>
				  </div >
				 <% } } else { %>
				     <div class="cart">
				 <a href="login.jsp">
				    <div>
				     <img class="svg" src="view/images/cart.svg" alt="https://www.flaticon.com/authors/freepik">
				     </div></a></div>
				 <% }%>
				  
							<!-- User -->
				<c:if test="${empty userName}">
				
				<div id="userlogin" class="user">
				<div class="user"><a href="login.jsp">
				<div><img src="view/images/user.svg" alt="https://www.flaticon.com/authors/freepik" >
				</div></a>
				<div id="userName" style="color:black;"> 
						<%= userName  %> </div>
				</div>
				 
			  </div >
			  </c:if>
			 
					<c:if test="${not empty userName}">
			 <a href="chat.jsp?pageJsp=index" 
			 	class="btn btn-sm btn-outline-light text-dark  waves-effect" 
			 	 style="border: none; background-color: transparent;" >
					<span> <small><i class="far fa-comments" 
					                 style="font-size: 25px;border: none; background-color: transparent;"> צ'אט</i></small>
					</span>
		     </a>
			<%
			               String imageBase641="";
							  if( user != null && user.getImage() != null ){
								   imageBase641 = new String(Base64.getEncoder().encode(( user.getImage())));
									  if(imageBase641 !=null ){%>
										 <img src="data:image/jpeg;base64,<%=imageBase641%>"  style="border-radius:30%; border: none; height: 30px; width :30px;" />
									  <%}} else{%>
										<img  alt="" src="view/images/none.jpg" style="border-radius:30%; border: none; height: 30px; width :30px;"> 
										 <%}%>
			 <div class="dropdown">
			     <button type="button" class="btn dropdown-toggle" style="border: none; background-color: transparent;" data-toggle="dropdown">
			       	<%= userName  %> 
			  		  </button>
			    <div class="dropdown-menu">
			      <div >
				    <% if (sup){  
				    %>
				         <a  style="border: none; background-color: transparent;"
				          class="active btn btn-sm btn-outline-light text-dark  waves-effect"  
			              href="sellerProfile.jsp?email=<%= email%>"> פרופיל </a>
				    <%}else{%>    
				      <a   style="border: none; background-color: transparent;"
				          class="active btn btn-sm btn-outline-light text-dark  waves-effect"  
			              href="customerProfile.jsp?email=<%= email%>"> פרופיל </a>
				    <%}%>
			     </div>
			       <hr>
						<form action="<%=request.getContextPath()%>/LogoutServlet">
						  <button class="btn btn-sm btn-outline-light text-dark  waves-effect" id="userName" >
									 צא - سجل الخروج
						   </button >
						  </form>
					</div>
			    </div>
			  
 			</c:if>
 			</div>
	</header>

	<div class="super_container_inner">
		<div class="super_overlay"></div>
						<br><br>
		
		<!-- Home -->
		<div class="container" style="background-color: white;">
		<div class="jumbotron text-center" style="background-color: white; border: 2px solid orange;" class="btn btn-outline-warning btn-block">
			  <form action="<%=request.getContextPath()%>/ContactServlet" method="post">
			     <label for="fname" style="font-size: 28px;">צור קשר איתנו </label>
			     <div>
			     <input type="text" id="fullname" name="fullname" value = "שם מלא : <%= userName %> <%= user.getUserSurName() %>" disabled="disabled">
			     <input type="hidden" name="mailCustomer" value=<%= email %>>
			    <textarea id="subject" name="subject" placeholder="בבקשה כתוב השאלה כאן.." style="height:300px;"></textarea>
			     </div>
			    <input type="submit" value="שלח השאלה" style="border: 2px solid balck; font-size: 18px;"
			    								  class="btn btn-outline-warning btn btn-block">
			  </form>
		
		</div>
		
		</div>
		
			<!-- Footer -->

		<footer class="footer">
			<div class="footer_content">
				<div class="container">
					<div class="row">

						<!-- About -->
						<div class="col-lg-4 footer_col">
							<div class="footer_about">
								<div class="footer_logo">
									 <form action="<%=request.getContextPath()%>LIServlet">
									 <a href="index.jsp">
										<div class="d-flex flex-row align-items-center justify-content-start">
											<div><img src="view/images/logo5.png" alt="" height="80" width="130"></div>
										</div>
									</a></form>
								</div>
								<div  dir="rtl" class="footer_about_text text-center"">
									<p>זאכי מעניקה לך מגוון רחב של מנות טעימות, אנחנו מאמינים כי כל אחד מגיע לו אוכל  ביתי חם, טעים ומעולה בכל מקום ובכל זמן</p>
									<p>בתיאבון, אלאא והאג'ר</p>
								</div>
							</div>
						</div>

						<!-- Footer Links -->
						<div class="col-lg-4 footer_col">
							<div class="footer_menu">
								<div class="footer_title text-center">עזרה ושירותים</div>
								<ul class="footer_list text-center">
									<li>
										<a href="#"><div>שירות לקוחות<div class="footer_tag_1">אונלין</div></div></a>
									</li>
									<li>
										<a href="#"><div>מדיניות החזרה</div></a>
									</li>
									<li>
										<a href="#"><div>כמויות של מוצרים<div class="footer_tag_2">מומלץ</div></div></a>
									</li>
									<li>
										<a href="#"><div>תקנון האתר</div></a>
									</li>
									<li>
										<a href="#"><div>צור קשר</div></a>
									</li>
								</ul>
							</div>
						</div>
						

						<!-- Footer Contact -->
						<div dir="rtl" class="col-lg-4 footer_col">
							<div dir="rtl" class="footer_contact">
								
								<div dir="rtl" class="footer_social">
									<div dir="rtl" class="footer_title">רשתות חברתיות</div>
									<ul  class="footer_social_list d-flex flex-row align-items-start justify-content-start text-center">
										
										<li><a   href="#"><i class="fa fa-facebook " aria-hidden="true"></i></a></li>
										<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div  dir="ltr" class="footer_bar text-center"">
				<div  class="container">
					<div class="row">
						<div class="col">
							<div class="footer_bar_content d-flex flex-md-row flex-column align-items-center justify-content-start">
								<div class="copyright order-md-1 order-2">Copyright &copy;
								<script>document.write(new Date().getFullYear());</script>
								 All rights reserved  <i class="fa fa-heart-o" aria-hidden="true"></i>
								  Alaa && Hajar </div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</footer>
			

	</div>
</div>

<script src="view/js/jquery-3.2.1.min.js"></script>
<script src="view/styles/bootstrap-4.1.2/popper.js"></script>
<script src="view/styles/bootstrap-4.1.2/bootstrap.min.js"></script>
<script src="view/plugins/greensock/TweenMax.min.js"></script>
<script src="view/plugins/greensock/TimelineMax.min.js"></script>
<script src="view/plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="view/plugins/greensock/animation.gsap.min.js"></script>
<script src="view/plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="view/plugins/easing/easing.js"></script>
<script src="view/plugins/parallax-js-master/parallax.min.js"></script>
<script src="view/js/checkout.js"></script>
</body>
</html>
