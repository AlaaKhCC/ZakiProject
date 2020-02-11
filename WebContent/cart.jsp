<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=utf-8" %><!DOCTYPE html>

<%@ page import=" java.io.UnsupportedEncodingException,com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl,
 				  com.hajar.zaki.model.User , com.hajar.zaki.model.Order ,  com.hajar.zaki.model.OrderDetails, utils.*, java.sql.*, java.util.*,com.hajar.zaki.dao.ProductDAO, com.hajar.zaki.model.Product, com.hajar.zaki.model.ProductPicture ,
 				  com.hajar.zaki.db.DBConnect, com.hajar.zaki.dao.PicturesDao,com.hajar.zaki.dao.OrderDetailsDAO, com.hajar.zaki.dao.OrderDAO, java.io.*, java.util.Base64" %>

<%@page import="com.hajar.zaki.model.Customer, com.hajar.zaki.dao.SupplierDAO,  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier "%>

<html lang="he" dir="rtl">
<head>
<title>Cart</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Little Closet template">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="view/styles/bootstrap-4.1.2/bootstrap.min.css">
<link href="view/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="view/styles/cart.css">
<link rel="stylesheet" type="text/css" href="view/styles/cart_responsive.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">

 
</head>
<body>
        <%
             String jspName ="cart.jsp";

            OrderDAO orderDao= new OrderDAO();
			OrderDetailsDAO odsDao = new OrderDetailsDAO();

			 System.out.println(request.getParameter("orderDelete")+ " is nullllllllllllllllll cart");
 			if(request.getParameter("orderDelete") != null){

				int orderNum = Integer.parseInt(request.getParameter("orderDelete"));
			    System.out.println("ordernum into cart request "+orderNum);
			   if( orderNum > 0){
				 odsDao.deleteObject(orderNum );
				orderDao.deleteObject(orderNum );
			   }
			}
			
		
				String userName = "";
				String password = "";
				String email = "";
				User user =new User();
				UserDAOImpl userdao= new UserDAOImpl();
				boolean sup = false;
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
				  String type=""; 
				  Object sum=0.0;
				  Double totalSum=0.0;
 				  Double quantity= new Double(1);
				  if(request.getParameter("quan")!=null){
					quantity= Double.parseDouble(request.getParameter("quan"));
				  }

				  Object productId=  request.getParameter("val2");
				  ProductDAO prodDao=new ProductDAO();
				  Product prod= prodDao.getProductPerId((String)productId);

				  PicturesDao picDao= new PicturesDao();
				  ProductPicture prodPic = picDao.getPicturePerProductId(prod.getProdID());
				  String imageBase64="";
				  if(prodPic != null && prodPic.getImg()!= null){
				  imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));
				  }
								   
				/* Get below data from HttpSession. */
	
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				
				if(userNameObj!=null){
					userName = (String)userNameObj;
				} 
				ArrayList<Order> orders = new ArrayList<>();
				
				if(emailObj!=null){
					email = (String)emailObj;
					user= userdao.getUserByEmail(email);
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
				if(orderDao != null && productId != null && quantity!= null){
					orderDao.addOrder(new Order(email, (String) productId, (Double) quantity));
				   odsDao = new OrderDetailsDAO();
					OrderDetails ods = new OrderDetails();
					odsDao.addObj(ods);
					
				}
						// select per customer mail 
				    orders = orderDao.getOrderdPerCustomer(email);
					System.out.println("test here in cart, to test "+ orders.size()+ " " +email);
				
			%>
 			    
			<script type="text/javascript" >
			
			</script>
		
			
			
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
			 <a href="chat.jsp?pageJsp=cart" 
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
			    <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
			       <%= userName  %> 
			    </button>
			    <div class="dropdown-menu">
			      <div >
			         <% if (sup){  
				    %>
				         <a  class="active btn btn-sm btn-outline-light text-dark  waves-effect"  
			              href="sellerProfile.jsp?email=<%= email%>"> פרופיל </a>
				    <%}else{%>    
				      <a  class="active btn btn-sm btn-outline-light text-dark  waves-effect"  
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
					<div class="home_title">סל הקניות</div>
					<div class="breadcrumbs d-flex flex-column align-items-center justify-content-center">
					</div>
				</div>
			</div>
		</div>

		<!-- Cart -->

		<div class="cart_section">
			<div class="container">
				<div class="row">
					<div class="col">
						<div class="cart_container">
						 <% int valuesLength=orders.size()-1;
								if(valuesLength>0){ %>
							<!-- Cart Bar -->
							<div class="cart_bar">
								<ul class="cart_bar_list item_list d-flex flex-row align-items-center justify-content-end">
									<li class="ml-auto">מוצר</li>
									<li>מחיר</li>
									<li>כמות</li>
									<li>סכום</li>
									<li></li>
									
								</ul>
							</div>
							<% 
							   int index_order = 0;
							  if(valuesLength>0)
				  				for(index_order=0; index_order<=valuesLength;index_order++){ 
								 
								 prodDao=new ProductDAO();
				  				 prod= prodDao.getProductPerId(orders.get(index_order).getProdId());

				  				 picDao= new PicturesDao();
				  				 prodPic = picDao.getPicturePerProductId(prod.getProdID());
				  			     imageBase64="";
				  				 if(prodPic != null && prodPic.getImg()!= null){
								  imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg()))); 
							%>
									<!-- Cart Items -->
							      <div class="cart_items">
								   <ul class="cart_items_list">
									<!-- Cart Item -->
									<li class="cart_item item_list d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-lg-end justify-content-start">
										<div class="product d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-start ml-auto">
											
											<div><div class="product_image"> 
											<% } if(imageBase64 !=null ){%>
											     	  <img src="data:image/jpeg;base64,<%=imageBase64%>"  />
															<% } %>			
											</div></div>
											<div class="product_name_container">
												<div class="product_name"><a href="product.jsp"><%= prod.getName() %></a></div>
												<div class="product_text"></div>
											</div>
										</div>
										<div class="product_price product_text"><span>מחיר</span>₪ <%= prod.getPiece_price() %></div>
										<div class="product_quantity_container"><span></span><%= orders.get(index_order).getQuantity() %> </div>
										<% sum= (Double) orders.get(index_order).getQuantity()*prod.getPiece_price(); %>
										<div class="product_total product_text"><span>סכום: </span>₪ <%= sum %></div>
										<% totalSum+=(Double)sum; %>
										<div class="button button_continue trans_200">
										   <a href="cart.jsp?delete=<%=1%>&orderDelete=<%=orders.get(index_order).getOrderNum()%>">מחק</a></div>
									</li>
										
									
								</ul>
							</div>
							<%}  %>
					
							

							<!-- Cart Buttons -->
							<div class="cart_buttons d-flex flex-row align-items-start justify-content-start">
							<div class="cart_buttons_inner mr-sm-auto d-flex flex-row align-items-start justify-content-start flex-wrap">
							<div class="button button_continue trans_200"><a href="categories.jsp">ראה עוד מוצרים</a></div>
							
							
							</div>
							<div class="button button_continue trans_200">
							<form action="<%= request.getContextPath()%>/DeleteAllOrdersOFCustomer" method="get">
							<input type="hidden" value=<%= email %> name="mailCustomer" >
							<input type="submit" value=" מחק הכל" style="border: none; text-align:center;
							background: transparent; font-family: sans-serif;
							font-size: 16px; font-style: inherit; color: white;">
							</form>
							</div>
							</div>
						</div>
						<%}%>
					</div>
				</div>
				<div class="row cart_extra_row text-right">
					<!-- div class="col-lg-6">
						<div class="cart_extra cart_extra_1">
							<div class="cart_extra_content cart_extra_coupon">
								
								<div class="coupon_text"></div>
								<div class="shipping">
									<div class="cart_extra_title">שיטת משלוח</div>
									<ul>
										<li class="shipping_option d-flex flex-row align-items-center justify-content-start">
											<label class="radio_container">
												<input type="radio" id="radio_1" name="shipping_radio" class="shipping_radio">
												<span class="radio_mark"></span>
												<span class="radio_text">משלוח באותו יום</span>
											</label>
											<div class="shipping_price mr-auto">₪ 30</div>
										</li>
										<li class="shipping_option d-flex flex-row align-items-center justify-content-start">
											<label class="radio_container">
												<input type="radio" id="radio_2" name="shipping_radio" class="shipping_radio">
												<span class="radio_mark"></span>
												<span class="radio_text">משלוח לפי תאריך</span>
											</label>
											<div class="shipping_price mr-auto">₪ 15</div>
										</li>
										<li class="shipping_option d-flex flex-row align-items-center justify-content-start">
											<label class="radio_container">
												<input type="radio" id="radio_3" name="shipping_radio" class="shipping_radio" checked>
												<span class="radio_mark"></span>
												<span class="radio_text">איסוף עצמי</span>
											</label>
											<div class="shipping_price mr-auto">0</div>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div-->
					<div class="col-lg-6 cart_extra_col">
						<div class="cart_extra cart_extra_2">
							<div class="cart_extra_content cart_extra_total">
								<div class="cart_extra_title">סכום סל</div>
								<ul class="cart_extra_total_list">
									<li class="d-flex flex-row align-items-center justify-content-start">
										<div class="cart_extra_total_title">סכום מחירים</div>
										<div class="cart_extra_total_value mr-auto">₪ <%= totalSum %></div>
									</li>
									<li class="d-flex flex-row align-items-center justify-content-start">
										<div class="cart_extra_total_title">משלוח</div>
										<div class="cart_extra_total_value mr-auto">חינם</div>
									</li>
									<li class="d-flex flex-row align-items-center justify-content-start">
										<div class="cart_extra_total_title">סך הכל לתשלום</div>
										<div class="cart_extra_total_value mr-auto">₪ <%= totalSum %></div>
									</li>
								</ul>
								<div class="checkout_button trans_200">
								   <a href="checkout.jsp?userName=<%=userName%>&email=<%=email%>&totalSum=<%= totalSum %>">המשך לבחירת שיטת תשלום</a></div>
							</div>
						</div>
					</div>
				</div>
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
<script src="view/js/cart.js"></script>
</body>
</html>
