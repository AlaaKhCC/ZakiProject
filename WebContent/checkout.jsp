<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="com.hajar.zaki.model.Customer, com.hajar.zaki.dao.SupplierDAO,  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier "%>
<%@page import=" java.net.InetAddress, java.net.UnknownHostException, java.util.*, javax.mail.internet.*,
                 utils.Constatns, javax.activation.*, javax.mail.Authenticator,
                 javax.mail.Message, javax.mail.MessagingException, javax.mail.NoSuchProviderException,
                 javax.mail.PasswordAuthentication,javax.mail.Session, javax.mail.Transport,com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl
                 ,com.hajar.zaki.model.User , com.hajar.zaki.dao.ProductDAO, com.hajar.zaki.model.Product, 
                 com.hajar.zaki.model.Order ,  com.hajar.zaki.model.OrderDetails, com.hajar.zaki.dao.OrderDAO" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
<title>Checkout</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Little Closet template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="view/styles/bootstrap-4.1.2/bootstrap.min.css">
<link href="view/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="view/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="view/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="view/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="view/styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="view/styles/responsive.css">
<link rel="stylesheet" type="text/css" href="view/styles/global.css">
<link href="https://fonts.googleapis.com/css?family=Alef&display=swap" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="view/styles/checkout.css">
<link rel="stylesheet" type="text/css" href="view/styles/checkout_responsive.css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<link href="https://unpkg.com/gijgo@1.9.11/css/gijgo.min.css" rel="stylesheet" type="text/css" />

<style>
.btn {
  border: 0px solid black;
  background-color: white;
  color: black;
  padding: 6px 16px;
  font-size: 12px;
  cursor: pointer;
}
/* Gray */
.default {
  border-color: #fff;
  color: black;
}

.default:hover {
  background: #e7e7e7;
}
</style>
</head>
<body>
			 <%

				String userName = "";
				String password = "";
				String email = "";
				String msg="";
				User user =new User();
				UserDAOImpl userdao= new UserDAOImpl();
				OrderDAO orderDao= new OrderDAO();
				ArrayList<Order> orders = new ArrayList<Order>();
				boolean sup = false;
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
				
				// select per customer mail 
				  
				/* Get below data from HttpSession. */	
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				
			    System.out.println(" alaa boma test checkout     > "+ userNameObj);
				if(userNameObj!=null){
					userName = (String)userNameObj;
				}
				
				if(emailObj!=null){
					email = (String)emailObj;
					user= userdao.getUserByEmail(email);
					orders = orderDao.getOrderdPerCustomer(email);
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
			
			<%
			
			  // deleviry way 
			   int delevryWay = 0;
			   Double total_price =  Double.parseDouble(request.getParameter("totalSum"));
			  /*if(request.getParameter("shipping_radio")!= null){
				  String del = request.getParameter("shipping_radio");
					 
				  switch(del){
				  case "חינם" : delevryWay =0; break;
				  case "₪ 15" : delevryWay =15; break;
				  case "₪ 30" : delevryWay =30; break;
				  }
				 
			  }*/

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
				<c:if test="${not empty userName}">
				<div class="cart">
				 <a href="cart.jsp">
				    <div>
				     <img class="svg" src="view/images/cart.svg" alt="https://www.flaticon.com/authors/freepik">
				     </div></a></div>
				</c:if>
				<c:if test="${ empty userName}">
				<div class="cart">
				 <a href="login.jsp">
				    <div>
				     <img class="svg" src="view/images/cart.svg" alt="https://www.flaticon.com/authors/freepik">
				     </div></a></div>
				</c:if>
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

		<!-- Home -->

		<div class="home">
			<div class="home_container d-flex flex-column align-items-center justify-content-end">
				<div class="home_content text-center">
					<div class="home_title">בצע תשלום</div>
				</div>
			</div>
		</div>

		<!-- Checkout -->

		<div class="checkout" id="checkoutID">
			<div class="container">
				<div class="row">

					<!-- Billing -->
					<div class="col-lg-6">
						<div class="billing">
							<div class="checkout_title">פרטי מקבל המשלוח</div>
							<div class="checkout_form_container">
								<form action="#" id="checkout_form" class="checkout_form">
									<div class="row">
										<div class="col-lg-6">
											<!-- Name -->
											<input type="text" id="checkout_name" class="checkout_input" value="<%= session.getAttribute("userName")%>" placeholder="שם פרטי" required="required">
										</div>
										<div class="col-lg-6">
											<!-- Last Name -->
											<input type="text" id="checkout_last_name" class="checkout_input" placeholder="שם משפחה " value="<%= session.getAttribute("surName")%>">
										</div>
									</div>
									<div>
										<!-- Phone no -->
										<input type="phone" id="checkout_phone" class="checkout_input" placeholder=" מספר טלפון סוללרי" value="<%= session.getAttribute("phone")%>">
									</div>
									<div>
										<!-- Email -->
										<input type="email" id="checkout_email" class="checkout_input" placeholder="אי-מייל"  value="<%= session.getAttribute("email")%>">
									</div>
									<div>
										<!-- City / Town -->
								    	<input type="text" id="checkout_city" class="checkout_input" placeholder="עיר"  value="<%= session.getAttribute("city")%>">
										
									</div>
									<div>
										<!-- Address -->
										<input type="text" id="checkout_address" class="checkout_input" placeholder="רחוב" required="required">
										<input type="text" id="checkout_address_2" class="checkout_input checkout_address_2" placeholder="מספר בית" required="required">
									</div>
									
									<!-- delivery time -->
									<div class="checkout_title">מועד משלוח</div>
										<div class="container">
						            <div class="row">
						                <div class="col-md-12">
						                    <input placeholder="תאריך משלוח" id="datepicker" width="270" name="checkout_time" />
						                </div>
						            </div>
						        </div>
						       
						       	<div>
										<!-- ship hour -->
										<select name="checkout_hour" id="checkout_city" class="dropdown_item_select checkout_input" required="required">
											<option disabled selected > שעת משלוח </option>
											<option>בוקר</option>
											<option>צהריים</option>
											<option>ערב</option>
										</select>
									</div>
									<div class="checkout_extra">
										<ul>
											<li class="billing_info d-flex flex-row align-items-center justify-content-start">
												<label class="checkbox_container">
													<input type="checkbox" id="cb_1" name="billing_checkbox" class="billing_checkbox  pull-right">
													<span class="checkbox_mark"></span>
													<span class="checkbox_text">אני מסכים על תקנון השימוש</span>
												</label>
											</li>
											<!-- li class="billing_info d-flex flex-row align-items-center justify-content-start">
												<label class="checkbox_container">
													<input type="checkbox" id="cb_3" name="billing_checkbox" class="billing_checkbox  pull-right">
													<span class="checkbox_mark"></span>
													<span class="checkbox_text">הרשם למעודון לקוחות</span>
												</label>
											</li-->
										</ul>
									</div>
								</form>
							</div>
						</div>
					</div>

					<!-- Cart Total -->
					<div class="col-lg-6 cart_col">
						<div class="cart_total">
							<div class="cart_extra_content cart_extra_total">
								<div class="checkout_title">סך הכל</div>
								<ul class="cart_extra_total_list">
									<li class="d-flex flex-row align-items-center justify-content-start">
										<div class="cart_extra_total_title">מחיר</div>
										<div class="cart_extra_total_value mr-auto"><%= total_price %></div>
									</li>
									<li class="d-flex flex-row align-items-center justify-content-start">
										<div class="cart_extra_total_title">משלוח</div>
										<div class="cart_extra_total_value mr-auto">חינם</div>
									</li>
									<li class="d-flex flex-row align-items-center justify-content-start">
										<div class="cart_extra_total_title">סה"כ לתשלום</div>
										<div class="cart_extra_total_value mr-auto"> ₪  <%= total_price %></div>
									</li>
								</ul>
								<!-- div class="payment_options">
									<div class="checkout_title">שיטת תשלום</div>
									<ul>
										<li class="shipping_option d-flex flex-row align-items-center justify-content-start">
											<label class="radio_container">
												<input type="radio" id="radio_2" name="payment_radio" class="payment_radio">
												<span class="radio_mark"></span>
												<span class="radio_text">מזומן בעת משלוח</span>
											</label>
										</li>
										<li class="shipping_option d-flex flex-row align-items-center justify-content-start">
											<label class="radio_container">
												<input type="radio" id="radio_3" name="payment_radio" class="payment_radio pull-right" checked>
												<span class="radio_mark"></span>
												<span class="radio_text">העברה בנקאית - פרטים בהמשך</span>
											</label>
										</li>
									</ul>

								</div-->
								<!--  <%=request.getContextPath()%>/SmsServlet -->
								  <form action=" <%=request.getContextPath()%>/SmsServlet" method="post">
								     <!-- textarea id="msgId" class="text-right" style="display: none"  >
								    		,שלום 
								    		<%= user.getUserName() %>
								    		  רוצה להזמין ההזמנוה  נמצאת באתר, מספר הטלפון הינו: 
								    		<%= user.getPhoneNumber() %>
								    		האי-מייל הינו:
								    		<%= user.getUserMail() %>
								    		כנס/י לאתר כדי לאשר לו ההזמנה או יצר איתו קשר.
								    		
								     </textarea-->
								     <input  type="hidden" value=<%= user.getUserMail()%> name="customerMail">
								     
				                    <input class="checkout_button trans_200" id="orderBtn" value="בצע הזמנה" type="submit"  />
				                    <br>
				                    </form>
				                   <!-- a class="checkout_button trans_200 text_center" href="thankYou.jsp" onclick="addDivData(this)" style="font-size: 28px;"> בצע הזמנה </a-->
				              </div>
						</div>
					</div>

				</div>
			</div>
		</div>
		 <script> 
				 function addDivData(e){
			         e.href = e.href + "?msg=" + document.getElementById('msgId').value;
			}
		 </script>

	<!-- Footer -->

		<footer class="footer">
			<div class="footer_content">
				<div class="container">
					<div class="row">

						<!-- About -->
						<div class="col-lg-4 footer_col">
							<div class="footer_about">
								<div class="footer_logo">
									<a href="#">
										<div class="d-flex flex-row align-items-center justify-content-start">
											<div class="footer_logo_icon"><img src="view/images/logo5.png" alt=""></div>
											<div></div>
										</div>
									</a>
								</div>
								<div  dir="rtl" class="footer_about_text text-center"">
									<p>זאכי מעניקה לך מגוון רחב של מנות טעימות, אנחנו מאמינים כי כל אחד מגיע לו אוכל  ביתי חם, טעים ומעולה בכל מקום ובכל זמן</p>
									<p>בתיאבון, אלאא והאג'ר</p>
								</div>
							</div>
						</div>

						<!-- Footer Links -->
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


<script type="text/javascript">
	function HandleTimeSelect(a){
		$(a).closest(".timepickercontainer").attr("data-value", $(a).text());
		$(a).closest(".timepickercontainer").find("button").first().jsp($(a).text() + " <i class='caret'></i>");
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

<script type="text/javascript">

$("orderBtn").click(function() {
	 

	<%
	
	   

	%>
});
</script>

	


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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

</body>
</html>
