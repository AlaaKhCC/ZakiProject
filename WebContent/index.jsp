<%@page import="com.hajar.zaki.model.Customer, com.hajar.zaki.dao.SupplierDAO,  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier "%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="com.hajar.zaki.model.ProductPicture"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import=" java.io.UnsupportedEncodingException,com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl,
 				  com.hajar.zaki.model.User , utils.*, java.sql.*, java.util.*,
 				  com.hajar.zaki.dao.ProductDAO, com.hajar.zaki.model.Product,com.hajar.zaki.dao.OrderDAO,com.hajar.zaki.model.Order, 
 				  com.hajar.zaki.db.DBConnect, com.hajar.zaki.dao.PicturesDao,com.hajar.zaki.dao.ProductCustomerDAO,com.hajar.zaki.model.ProductCustomer, 
 				  java.io.*, javax.swing.*, java.awt.*, java.util.Base64" %>
 				  
 				  


<!DOCTYPE html>
<html lang="he" dir="rtl" >
<head>
<title>zaki Home page</title>
<meta charset="UTF-8">
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
<link rel="stylesheet"href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Alef&display=swap" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

  <link href="view/css/jquery-ui.css" rel="stylesheet">
  <script src="view/js/jquery-1.11.2.js"></script>
  <script src="view/js/jquery-ui.js"></script>
  
<script>
  $(function() {
  
   $('#names').keypress(function () {   
    $.ajax({
     url:"Auto",
     type:"post",
     data:'',
     success:function(data){
      $( "#names" ).autocomplete({   
          source: data   
        });
     
     },error:  function(data, status, er){
              console.log(data+"_"+status+"_"+er);
          },
           
    });
    
    });
 
  });
  </script>
  
<style>
.btn {
  font-size: 16px;
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

#likedProdsID{
 display: none;
}
</style>
</head>
<body>
                 
                 
              <%
				    Connection con = null;
					Statement statement = null;
					 ResultSet resultSet = null;
					 Product prod=new Product();
					 ArrayList<Product> products=new ArrayList<Product>();
					 ArrayList<Product> products_Sup=new ArrayList<Product>();
					 OrderDAO orderdao = new OrderDAO();
					 ArrayList<Order> orders = new ArrayList<>();
					 Category category=null;  
					 ProductDAO pdao = new ProductDAO();
					 products = pdao.getAllOfObjects();
						session.setAttribute("products_list", products);
					 %>
			 <%
			    String jspName ="index.jsp";
				String userName = "";
				String password = "";
				String email = "";
				boolean sup = false;
				User user = new User ();
				UserDAOImpl userdao = new UserDAOImpl();
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
				
				/* Get below data from HttpSession. */
				
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				
				if(userNameObj!=null){
					userName = (String)userNameObj;					
				}
				
				if(emailObj!=null){
					email = (String)emailObj;
					email =  email.replace(" ","");
					user = userdao.getUserByEmail(email);
					orders= orderdao.getOrderdPerCustomer(email);
					products_Sup = pdao.getAllSupProds(email);
					for(Supplier s : suppliers){

						if(s.getUserMail().equals(email)){
							sup = true;
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
				
				int index_Prod=0;
			
			%>
			
			
<!-- Menu -->

<div class="menu">

	<!-- Search -->
	<div class="menu_search">
		<form action="" id="menu_search_form" class="menu_search_form" >
			<button class="menu_search_button"><img src="view/images/search.png" alt=""></button>
			<input  class="input1_text" style="width: 300px; margin: 50px auto;" 
			       type="text" class="search_input" placeholder="חפש משהו טעים"  id="names" name="names" required="required">
			       
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
				<div id="userName" style="color:black; border: none; background-color: transparent;"> 
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
			<!-- Home Slider -->
			<div class="home_slider_container">
				<div class="owl-carousel owl-theme home_slider">
				
				 

					<!-- Slide -->
					<div class="owl-item">
						<div class="background_image" style="background-image:url(view/images/home1.jpeg)"></div>
						<div class="container fill_height">
							<div class="row fill_height">
								<div class="col fill_height">
									<div class="home_container d-flex flex-column align-items-center justify-content-start">
										<div class="home_content">
											<div class="home_title">הכי טעים</div>
											<div class="home_subtitle"></div>
											<div class="home_items">
												<div class="row">
													<div class="col-sm-3 offset-lg-1">
														<div class="home_item_side">
														<img src="view/images/test.png" alt="" style="height: 230px; width: 205px;"></div>
													</div>
													<div class="col-lg-4 col-md-6 col-sm-8 offset-sm-2 offset-md-0">
														<div class="product_image"><img src="view/images/pro2.jpeg" alt="" style="height: 255px; width: 255px;"></div>
														
														<!-- div class="product home_item_large">
															<div class="product_tag d-flex flex-column align-items-center justify-content-center">
																
															</div>
															
														</div-->
													</div>
													<div class="col-sm-3">
														<div class="home_item_side"><img src="view/images/pro3.jpeg" alt="" style="height: 230px; width: 205px;"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Slide -->
					<div class="owl-item">
					  <div class="background_image" style="background-image:url(view/images/home1.jpeg)"></div>
					 
						<div class="container fill_height">
							<div class="row fill_height">
								<div class="col fill_height">
									<div class="home_container d-flex flex-column align-items-center justify-content-start">
										<div class="home_content">
											<div class="home_title">בריא וטעים</div>
											<div class="home_subtitle"></div>
											<div class="home_items">
												<div class="row">
													<div class="col-sm-3 offset-lg-1">
														<div class="home_item_side"><img src="view/images/salad1.jpeg" alt="" style="height: 230px; width: 205px;"></div>
													</div>
													<div class="col-lg-4 col-md-6 col-sm-8 offset-sm-2 offset-md-0">
												    <div class="product_image"><img src="view/images/salad2.jpeg" alt="" style="height: 255px; width: 255px;"></div>
														
														<!-- div class="product home_item_large">
															<div class="product_tag d-flex flex-column align-items-center justify-content-center">
																
															</div>
															
														</div-->
													</div>
													<div class="col-sm-3">
														<div class="home_item_side"><img src="view/images/salad3.jpeg" alt="" style="height: 230px; width: 205px;"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Slide -->
					<div class="owl-item">
					<div class="background_image" style="background-image:url(view/images/home1.jpeg)"></div>
					
						<div class="container fill_height">
							<div class="row fill_height">
								<div class="col fill_height">
									<div class="home_container d-flex flex-column align-items-center justify-content-start">
										<div class="home_content">
											<div class="home_title">אוכל חם</div>
											<div class="home_subtitle"></div>
											<div class="home_items">
												<div class="row">
													<div class="col-sm-3 offset-lg-1">
														<div class="home_item_side">
														<img src="view/images/hot1.jpeg" alt="" style="height: 230px; width: 205px;"></div>
													</div>
													<div class="col-lg-4 col-md-6 col-sm-8 offset-sm-2 offset-md-0">
													  <div class="product_image"><img src="view/images/hot2.jpeg" alt="" style="height: 255px; width: 255px;"></div>
														
														<!-- div class="product home_item_large">
															<div class="product_tag d-flex flex-column align-items-center justify-content-center">
																
															</div>
															
														</div-->
													</div>
													<div class="col-sm-3">
														<div class="home_item_side"><img src="view/images/hot3.jpeg" alt="" style="height: 230px; width: 205px;"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Slide -->
					<div class="owl-item">
				    	<div class="background_image" style="background-image:url(view/images/home1.jpeg)"></div>
					
						<div class="container fill_height">
							<div class="row fill_height">
								<div class="col fill_height">
									<div class="home_container d-flex flex-column align-items-center justify-content-start">
										<div class="home_content">
											<div class="home_title">אוכל ומאפיים קפואים</div>
											<div class="home_subtitle"></div>
											<div class="home_items">
												<div class="row">
													<div class="col-sm-3 offset-lg-1">
														<div class="home_item_side"><img src="view/images/cold_ali_geven.jpeg" alt="" style="height: 230px; width: 205px;"></div>
													</div>
													<div class="col-lg-4 col-md-6 col-sm-8 offset-sm-2 offset-md-0">
														<div class="product_image"><img src="view/images/cold_etsbaot.jpeg" alt="" style="height: 255px; width: 255px;"></div>
													
														<!-- div class="product home_item_large">
															<div class="product_tag d-flex flex-column align-items-center justify-content-center">
																
															</div>
															
														</div-->
													</div>
													<div class="col-sm-3">
														<div class="home_item_side">
														<img src="view/images/cold_shesh.jpeg" alt="" style="height: 230px; width: 205px;"></div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
				<div class="home_slider_nav home_slider_nav_prev"><i class="fa fa-chevron-left" aria-hidden="true"></i></div>
				<div class="home_slider_nav home_slider_nav_next"><i class="fa fa-chevron-right" aria-hidden="true"></i></div>

				<!-- Home Slider Dots -->

				<div class="home_slider_dots_container">
					<div class="container">
						<div class="row">
							<div class="col">
								<div class="home_slider_dots">
									<ul id="home_slider_custom_dots" class="home_slider_custom_dots d-flex flex-row align-items-center justify-content-center">
										<li class="home_slider_custom_dot active">01</li>
										<li class="home_slider_custom_dot">02</li>
										<li class="home_slider_custom_dot">03</li>
										<li class="home_slider_custom_dot">04</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

		<!-- Products -->
		
		<div class="products">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 offset-lg-3">
						<div class="section_title text-center">בסט סלר אצלנו בזאכי</div>
					</div>
				</div>
				
				<% if(email == null || email.equals("")){ %> >
				<div class="row products_row">
				
				<% 
				   
				  int valuesLength=products.size();
				   InputStream sImage;
				  for(index_Prod=0; index_Prod<valuesLength;index_Prod++){
					  PicturesDao picDao= new PicturesDao();
					  ProductPicture prodPic = picDao.getPicturePerProductId(products.get(index_Prod).getProdID());
					  String imageBase64="";
					  if(prodPic != null && prodPic.getImg()!= null){
						   imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));
					  }				
				  %>
					  
					  <!-- Product -->
					<div class="col-xl-4 col-md-6">
						<div class="product">
							<div class="product_image">
							<% if(imageBase64 !=null ){%>
							  <img style="border-radius: 10%;height: 260px; width:500px" src="data:image/jpeg;base64,<%=imageBase64%>"  />
							  <% } %>
							</div>
							<br>
							<div class="product_content">
								<div class="product_info d-flex flex-row align-items-start justify-content-start">
									<div>
										<div>										    
											<div class="product_name">
											  <a href="product.jsp?value=<%=products.get(index_Prod).getProdID()%>" >
										     <%out.println(products.get(index_Prod).getName()); %>
										     </a>
										     </div>
											<div class="product_category">המחיר / السعر  </div>
										</div>
									</div>
									<div class="ml-auto text-right">
										<div class="rating_r rating_r_4 home_item_rating"><i></i><i></i><i></i><i></i><i></i></div>
										<div class="product_price text-right">₪<%out.println(products.get(index_Prod).getPiece_price() ); %> </div>
									</div>
								</div>
								<div class="product_buttons">
									<div class="text-right d-flex flex-row align-items-start justify-content-start">										
										<div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
											<div><div>
											<form action="login.jsp" >
											 <button  type="submit" value="" 
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/heart_2.svg">
   														 </button>
											</form>
											</div></div>
										</div>
										<div class="product_button product_cart text-center d-flex flex-column align-items-center justify-content-center" >
										<div><div>
										<form action="login.jsp" >
											 <button  type="submit" value="" 
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/cart.svg">
   											 </button>
											</form>
										</div></div>
										</div>										
									</div>
								</div>
							</div>
						</div>
					</div> 
					<%}%>				
				</div>
				
			</div>
		</div>
		<%} else{ 
		   if(email != null && sup){%>
				<div class="row products_row">
				
				<% 
				   
				  int valuesLength=products_Sup.size();
				   InputStream sImage;
				  for(index_Prod=0; index_Prod<valuesLength;index_Prod++){
					  PicturesDao picDao= new PicturesDao();
					  ProductPicture prodPic = picDao.getPicturePerProductId(products_Sup.get(index_Prod).getProdID());
					  String imageBase64="";
					  if(prodPic != null && prodPic.getImg()!= null){
						   imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));
					  }				
				  %>
					  
					  <!-- Product -->
					<div class="col-xl-4 col-md-6">
						<div class="product">
							<div class="product_image">
							<% if(imageBase64 !=null ){%>
							  <img style="border-radius: 10%;height: 260px; width:500px" src="data:image/jpeg;base64,<%=imageBase64%>"  />
							  <% } %>
							</div>
							<div class="product_content">
								<div class="product_info d-flex flex-row align-items-start justify-content-start">
									<div>
										<div>										    
											<div class="product_name">
											  <a href="product.jsp?value=<%=products_Sup.get(index_Prod).getProdID()%>" >
										     <%out.println(products_Sup.get(index_Prod).getName()); %>
										     </a>
										     </div>
											<div class="product_category">המחיר / السعر  </div>
										</div>
									</div>
									<div class="ml-auto text-right">
										<div class="rating_r rating_r_4 home_item_rating"><i></i><i></i><i></i><i></i><i></i></div>
										<div class="product_price text-right">₪<%out.println(products_Sup.get(index_Prod).getPiece_price() ); %> </div>
									</div>
								</div>
								
							</div>
						</div>
					</div> 
					<%}%>				
				</div>	
		<% } }%> 
		<!-- user not empty data  -->
		  <div id="productUserDiv"> 
			<!-- Products -->
			<% if(email != null && !sup){ %>
			 <div class="row page_nav_row">
					<div class="col">
						<div class="page_nav">
							<ul class="d-flex flex-row align-items-start justify-content-center">
								<li><button  class="active" id="prods_id_btn">מוצרים</button></li>
								<li><button  id="prods_liked_id_btn"> מוצרים אהבת</button></li>
							</ul>
						</div>
					</div>
				</div>
			 <div id="likedProdsID">
			   <div class="row products_row">
				
				<% 
				   ArrayList<Product> products_liked=new ArrayList<Product>();
				   products_liked = pdao.getAllLikedProducts(email);
				   
				   int len_liked =products_liked.size();
				   InputStream sImage;
				  for(index_Prod=0; index_Prod<len_liked;index_Prod++){
					  PicturesDao picDao= new PicturesDao();
					  ProductPicture prodPic = picDao.getPicturePerProductId(products_liked.get(index_Prod).getProdID());
					  String imageBase64="";
					  if(prodPic != null && prodPic.getImg()!= null){
						   imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));
					  }				
				  %>
					  
					  <!-- Product -->
					<div class="col-xl-4 col-md-6">
						<div class="product">
							<div class="product_image">
							<% if(imageBase64 !=null ){%>
							  <img style="border-radius: 10%;height: 260px; width:500px" src="data:image/jpeg;base64,<%=imageBase64%>"  />
							  <% } %>
							</div>
							<div class="product_content">
								<div class="product_info d-flex flex-row align-items-start justify-content-start">
									<div>
										<div>										    
											<div class="product_name">
											  <a href="product.jsp?value=<%=products_liked.get(index_Prod).getProdID()%>" >
										     <%out.println(products_liked.get(index_Prod).getName()); %>
										     </a>
										     </div>
											<div class="product_category">המחיר / السعر  </div>
										</div>
									</div>
									<div class="ml-auto text-right">
										<div class="rating_r rating_r_4 home_item_rating"><i></i><i></i><i></i><i></i><i></i></div>
										<div class="product_price text-right">₪<%out.println(products_liked.get(index_Prod).getPiece_price() ); %> </div>
									</div>
								</div>
								<div class="product_buttons">
									<div class="text-right d-flex flex-row align-items-start justify-content-start">										
										<div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
											<div><div>
											<i class="fa fa-heart" style="font-size:48px;color:red"></i></div></div>
										</div>
										
										<div class="product_button product_cart text-center d-flex flex-column align-items-center justify-content-center" >
										<div><div>
										<form action="" method="post">
										<input type="hidden" value="<%= email %>" name="mailCus">
						                <input type="hidden" value="<%=  prod.getProdID()%>" name="prod_id">
										<input type="hidden" value=<%= jspName %> name="jspPage" >	
										 <a   href="product.jsp?value=<%=products.get(index_Prod).getProdID()%>" style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/cart.svg">
   											 </a> 
   											 </form>
										</div></div>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</div> 
					<%}%>				
				</div>
			 </div>
		     <div id="nonlikedProdsID">
			  <div class="row products_row">
				
				<% 
				   ArrayList<Product> products_not=new ArrayList<Product>();
				   products_not = pdao.getNonLikedProducts(email);
				   int len=products_not.size();
				   InputStream sImage1;
				  for(index_Prod=0; index_Prod<len;index_Prod++){
					  PicturesDao picDao= new PicturesDao();
					  ProductPicture prodPic = picDao.getPicturePerProductId(products_not.get(index_Prod).getProdID());
					  String imageBase64="";
					  if(prodPic != null && prodPic.getImg()!= null){
						   imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));
					  }				
				  %>
					  
					  <!-- Product -->
					<div class="col-xl-4 col-md-6">
						<div class="product">
							<div class="product_image">
							<% if(imageBase64 !=null ){%>
							  <img style="border-radius: 10%;height: 260px; width:500px" src="data:image/jpeg;base64,<%=imageBase64%>"  />
							  <% } %>
							</div>
							<div class="product_content">
								<div class="product_info d-flex flex-row align-items-start justify-content-start">
									<div>
										<div>										    
											<div class="product_name">
											  <a href="product.jsp?value=<%=products_not.get(index_Prod).getProdID()%>" >
										     <%out.println(products_not.get(index_Prod).getName()); %>
										     </a>
										     </div>
											<div class="product_category">המחיר / السعر  </div>
										</div>
									</div>
									<div class="ml-auto text-right">
										<div class="rating_r rating_r_4 home_item_rating"><i></i><i></i><i></i><i></i><i></i></div>
										<div class="product_price text-right">₪<%out.println(products_not.get(index_Prod).getPiece_price() ); %> </div>
									</div>
								</div>
								<div class="product_buttons">
									<div class="text-right d-flex flex-row align-items-start justify-content-start">										
										<div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
											<div><div>
											      <form action="<%=request.getContextPath()%>/LikeProductServlet" method="post">
											        <input type="hidden" value="<%= email %>" name="mailCus">
						                            <input type="hidden" value="<%= products_not.get(index_Prod).getProdID()%>" name="prodidLiked">
						                            <input type="hidden" value=<%= jspName %> name="jspPage" >											         
											         <button  type="submit" value="" 
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/heart_2.svg">
   														 </button>											        
											      </form>											      
											     </div></div>
										</div>
										
										<div class="product_button product_cart text-center d-flex flex-column align-items-center justify-content-center" >
										<div><div>
										<form action=""  method="post">
										<input type="hidden" value="<%= email %>" name="mailCus">
						                <input type="hidden" value="<%=  prod.getProdID()%>" name="prod_id">
										<input type="hidden" value=<%= jspName %> name="jspPage" >	
									    <a href="product.jsp?value=<%=products_not.get(index_Prod).getProdID()%>"  
											         style="font-size:32px;border:none; background-repeat:no-repeat;background: transparent; ">  
   														<img alt="" src="view/images/cart.svg">
   											 </a></form>
										</div></div>
										</div>
										
											
										
									</div>
								</div>
							</div>
						</div>
					</div> 
					<%}%>				
				</div>
			 </div>
		</div>
				<div class="row load_more_row">
					<div class="col">
						<div class="button load_more ml-auto mr-auto"><a href="#">טען עוד מוצרים</a></div>
					</div>
				</div>
			</div>
		</div>
		
		<%} %>
		<!-- Boxes -->

		<div class="boxes">
			<div class="container">
				<div class="row">
					<div class="col">
						<div class="boxes_container d-flex flex-row align-items-start justify-content-between flex-wrap">

							<!-- Box -->
							<div class="box">
								<div class="background_image" style="background-image:url(view/images/down3.jpeg)"></div>
								<div class="box_content d-flex flex-row align-items-center justify-content-start">
									<div class="box_left">
										<div class="box_image">
											<a href="category.jsp">
												<div class="background_image" style="background-image:url(view/images/yum3.jpeg)"></div>
											</a>
										</div>
									</div>
									<div class="box_right text-center">
										<div class="box_title">קינוחיים מסורתיים</div>
									</div>
								</div>
							</div>

							<!-- Box -->
							<div class="box">
								<div class="background_image" style="background-image:url(view/images/home1.jpeg)"></div>
								<div class="box_content d-flex flex-row align-items-center justify-content-start">
									<div class="box_left">
										<div class="box_image">
											<a href="category.jsp">
												<div class="background_image" style="background-image:url(view/images/salad2.jpeg)"></div>
											</a>
										</div>
									</div>
									<div class="box_right text-center">
										<div class="box_title">הזמנות גדולות</div>
									</div>
								</div>
							</div>

							<!-- Box -->
							<div class="box">
								<div class="background_image" style="background-image:url(view/images/down1.jpeg)"></div>
								<div class="box_content d-flex flex-row align-items-center justify-content-start">
									<div class="box_left">
										<div class="box_image">
											<a href="category.jsp">
												<div class="background_image" style="background-image:url(view/images/cold3.jpeg)"></div>
											</a>
										</div>
									</div>
									<div class="box_right text-center">
										<div class="box_title">אוכל העונה</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Features -->

		<div class="features">
			<div class="container">
				<div class="row">

					<!-- Feature -->
					<div class="col-lg-4 feature_col">
						<div class="feature d-flex flex-row align-items-start justify-content-start">
							<div class="feature_left">
								<div class="feature_icon"><img src="view/images/icon_1.svg" alt=""></div>
							</div>
							<div class="feature_right d-flex flex-column align-items-start justify-content-center">
								<div class="feature_title">תשלום מהיר ומאובטח</div>
							</div>
						</div>
					</div>

					<!-- Feature -->
					<div class="col-lg-4 feature_col">
						<div class="feature d-flex flex-row align-items-start justify-content-start">
							<div class="feature_left">
								<div class="feature_icon ml-auto mr-auto"><img src="view/images/icon_2.svg" alt=""></div>
							</div>
							<div class="feature_right d-flex flex-column align-items-start justify-content-center">
								<div class="feature_title">מוצרים מיוחדיים</div>
							</div>
						</div>
					</div>

					<!-- Feature -->
					<div class="col-lg-4 feature_col">
						<div class="feature d-flex flex-row align-items-start justify-content-start">
							<div class="feature_left">
								<div class="feature_icon"><img src="view/images/icon_3.svg" alt=""></div>
							</div>
							<div class="feature_right d-flex flex-column align-items-start justify-content-center">
								<div class="feature_title">איסוף עצמי בחינם</div>
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
									 <form action="">
									 <a href="index.jsp">
										<div class="d-flex flex-row align-items-center justify-content-start">
											<div><img src="view/images/logo5.png" alt="" height="80" width="130"></div>
										</div>
									</a></form>
								</div>
								<div  dir="rtl" class="footer_about_text text-center">
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
			<div  dir="ltr" class="footer_bar text-center">
				<div  class="container">
					<div class="row">
						<div class="col">
							<div class="footer_bar_content d-flex flex-md-row flex-column align-items-center justify-content-start">
								<div class="copyright order-md-1 order-2 text-center">Copyright &copy;
								<script>document.write(new Date().getFullYear());</script>
								  All rights reserved to Zaki team <i class="fa fa-heart" style="font-size:48px;color:red;"></i>
								  <br>Alaa && Hajar </div>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</footer>


<script type="text/javascript">

$(document).ready(function() {
    $('#prods_id_btn').click( function() {
    	$('#nonlikedProdsID').show();
    	$('#productUserDiv').show();
    	$('#likedProdsID').hide();
    	});
 });

$(document).ready(function() {
    $('#prods_liked_id_btn').click( function() {
    	$('#nonlikedProdsID').hide();
    	$('#productUserDiv').show();
    	$('#likedProdsID').show();
    	});
 });
</script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="view/js/jquery-3.2.1.min.js"></script>
<script src="view/styles/bootstrap-4.1.2/popper.js"></script>
<script src="view/styles/bootstrap-4.1.2/bootstrap.min.js"></script>
<script src="view/plugins/greensock/TweenMax.min.js"></script>
<script src="view/plugins/greensock/TimelineMax.min.js"></script>
<script src="view/plugins/scrollmagic/ScrollMagic.min.js"></script>
<script src="view/plugins/greensock/animation.gsap.min.js"></script>
<script src="view/plugins/greensock/ScrollToPlugin.min.js"></script>
<script src="view/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="view/plugins/easing/easing.js"></script>
<script src="view/plugins/progressbar/progressbar.min.js"></script>
<script src="view/plugins/parallax-js-master/parallax.min.js"></script>
<script src="view/js/custom.js"></script>
</body>
</html>
