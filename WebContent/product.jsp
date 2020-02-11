<%@page import="javax.swing.text.DefaultEditorKit.CutAction"%>
<%@page import="com.hajar.zaki.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@page import="com.hajar.zaki.model.Customer, com.hajar.zaki.dao.SupplierDAO,  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier "%>

<%@ page import=" java.io.UnsupportedEncodingException,com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl,
 				  com.hajar.zaki.model.User , com.hajar.zaki.model.Order, com.hajar.zaki.model.Product ,  com.hajar.zaki.model.OrderDetails, utils.*, java.sql.*, java.util.*,com.hajar.zaki.dao.ProductDAO, com.hajar.zaki.model.Product, com.hajar.zaki.model.ProductPicture ,
 				  com.hajar.zaki.db.DBConnect, com.hajar.zaki.dao.PicturesDao,com.hajar.zaki.dao.OrderDetailsDAO, com.hajar.zaki.dao.OrderDAO, java.io.*, 
 				  java.util.Base64,  java.sql.Date, utils.Constatns, com.hajar.zaki.dao.ProductCustomerDAO, com.hajar.zaki.model.ProductCustomer" %>
	  

<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
<title>Product</title>
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
<link rel="stylesheet" type="text/css" href="view/styles/bootstrap-4.1.2/bootstrap.min.css">
<link href="view/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" type="text/css" href="view/plugins/flexslider/flexslider.css">
<link rel="stylesheet" type="text/css" href="view/styles/product.css">
<link rel="stylesheet" type="text/css" href="view/styles/product_responsive.css">
<link rel="stylesheet" type="text/css" href="view/styles/global.css">
<link href="https://fonts.googleapis.com/css?family=Alef&display=swap" rel="stylesheet">


<link rel="stylesheet" type="text/css" href="view/styles/cart.css">
<link rel="stylesheet" type="text/css" href="view/styles/cart_responsive.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    
<!-- stars  -->
<link rel="stylesheet" href="jquery.rating.css">
        <script src="jquery.js"></script>
        <script src="jquery.rating.js"></script>
        
     
<style>
.btn {
  border: 0px solid black;
  color: black;
  padding: 6px 16px;
  font-size: 18px;
  /*cursor: pointer;*/
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

<script type="text/javascript">
	function addToCart(){
		document.getElementById("cartCount").style.display = "block";
		var countDiv =	document.getElementById("cartCount").innerHTML = "1";
	}
</script>

</head>
<body>
			 <%
			    String jspName = "product.jsp";
				String userName = "";
				String password = "";
				String email = "";
				Double val2= new Double(1);
				String val3 = "";
				/* Get below data from HttpSession. */
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				Object productId=  request.getParameter("value");// for displaying 
				Object prodIdadd =  request.getParameter("val2"); // for add 
				boolean sup = false;
				User user = new User ();
				UserDAOImpl userdao = new UserDAOImpl();
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
				System.out.println(" test in product jsp "+productId);
				ProductCustomer pc= new ProductCustomer();
				ProductCustomerDAO pc_dao = new ProductCustomerDAO();
				  String type=""; 
				  Object sum=0.0;
				  Double totalSum=0.0;
 				  Double quantity= new Double(1);
				  if(request.getParameter("quan")!=null){
					quantity= Double.parseDouble(request.getParameter("quan"));
				  }
				  
				ProductDAO prodDao=new ProductDAO();
				Product prod= prodDao.getProductPerId((String)productId);
				if(prod == null){
					prod= prodDao.getProductPerId((String)prodIdadd);
					
				}
			    System.out.println(" second test "+ prod.getProdID());
				
				if(userNameObj!=null){
					userName = (String)userNameObj;
				} 
				ArrayList<Order> orders = new ArrayList<>();
				
				if(emailObj!=null){
					email = (String)emailObj;
					user= userdao.getUserByEmail(email);
					OrderDAO orderDao= new OrderDAO();
				if(orderDao != null &&  quantity!= null && quantity >=1 && prodIdadd != null){
					Order order = new Order(email, (String) productId, (Double) quantity);
					if(order != null && order != null){
						int id =orderDao.addOrder(order);
						OrderDetailsDAO odsDao = new OrderDetailsDAO();
						OrderDetails ods = new OrderDetails();
						Date date =  new  Date(Calendar.getInstance().getTime().getTime());
						ProductDAO proddao = new ProductDAO();
						ods = new OrderDetails(id,date, date, prod.getPiece_price(),prod.getDescription(),new Double(0), Constatns.STATUS_IN_PROGRESS );
						//(int numberOrder, Date orderDate, Date requireDate, Double price, String description, Double discount, String status)
						odsDao.addObj(ods);
					}
				}
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
						System.out.print(" before pc  is  like is ");

						if(prod != null){
						    pc= new ProductCustomer();
							pc_dao = new ProductCustomerDAO();
							pc= pc_dao.getProductLike(prod.getProdID(), email);
							System.out.print(" pc  is "+ pc.getProdId()+ " like is "+pc.getLike());
						}
						// select per customer mail 
			      orders = orderDao.getOrderdPerCustomer(email);

				}
				System.out.print(" syso product jsp category "+ prod.getCategory());
				String cate = "";
				String catePath = "product.jsp";
				if(prod != null && prod.getCategory()!= null){
				    cate = prod.getCategory().toString();
					switch(cate){
					case "SALAD" : catePath = "salad.jsp"; break;
					case "MAINCOURSE" : catePath = "mainCourse.jsp"; break;
					case "SWEET" : catePath = "sweet.jsp"; break;
					case "APPETIZERS" : catePath = "category.jsp"; break;
					case "CAKE" : catePath = "sweet.jsp"; break;
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

		<!-- Home -->

		<div class="home">
			<div class="home_container d-flex flex-column align-items-center justify-content-end">
				<div class="home_content text-center">
					<div dir="rtl" class="home_title"><%= prod.getName() %></div>
					<div class="breadcrumbs d-flex flex-column align-items-center justify-content-center">
						<ul class="d-flex flex-row align-items-start justify-content-start text-center">
							<li><a href="<%=catePath%>?userName=<%=userName%>&email=<%=email%>"><%= prod.getCategory() %></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>

		<!-- Product -->

		<div class="product">
		  <div class="row">
			<div class="container">
					<!-- Product Image -->
					<div class="col-sm-6">
						<div class="product_image_slider_container">
							<div id="slider" class="flexslider">
								<ul class="slides">
									<li>
									    <%
										  PicturesDao picDao= new PicturesDao();
									      ProductPicture prodPic = picDao.getPicturePerProductId(prod.getProdID());
										  String imageBase64="";
										  if(prodPic != null && prodPic.getImg()!= null){
											   imageBase64 = new String(Base64.getEncoder().encode((prodPic.getImg())));
											   
										  }	 if(imageBase64 !=null ){%>
											  <img src="data:image/jpeg;base64,<%=imageBase64%>"  />
											  <div class="continer">
											   <form action="<%=request.getContextPath() %>/RatingProductServlet" method="get">
												 <div class="row">
												  <div class="col-6" >
												  <div class="rating">
														<input type="radio" id="star10" name="rate" value="five" /><label for="star10" title="Rocks!">5 stars</label>
														<input type="radio" id="star9" name="rate" value="four" /><label for="star9" title="Rocks!">4 stars</label>
														<input type="radio" id="star8" name="rate" value="three" /><label for="star8" title="Pretty good">3 stars</label>
														<input type="radio" id="star7" name="rate" value="two" /><label for="star7" title="Pretty good">2 stars</label>
														<input type="radio" id="star6" name="rate" value="one" /><label for="star6" title="Meh">1 star</label>
													</div>
													</div>
													<div class="col">
													<input type="hidden" value="<%= email %>" name="mailCus">
						                            <input type="hidden" value="<%=  prod.getProdID()%>" name="prod_id_rated">
											        <input type="hidden" value=<%= jspName %> name="jspPage" >	
											        <br>
													<input type="submit" value="דרג המוצר" style="border: 2px solid green;"
													class="btn btn-outline-success btn-sm btn-block" >
												   </div>
												   </div>
												</form>
												</div>
												<div class="text-right">
													<form action="<%=request.getContextPath() %>/FeedbackProductServlet" method="get">
													<textarea class="form-control animated" cols="150" id="new-review" name="comment" placeholder="השאר חוות דעת" rows="5"></textarea>
												     <input type="hidden" value="<%= email %>" name="mailCus">
						                            <input type="hidden" value="<%=  prod.getProdID()%>" name="prod_id_rated">
											        <input type="hidden" value=<%= jspName %> name="jspPage" >	
											        <br>													
												    <input type="submit" style="border: 2px solid orange;"
												     value="הוסיף חוות דעת " class="btn btn-outline-warning btn-lg btn-block" >
												    </form>
												</div>
											<% } %>
									</li>
								</ul>
							</div>
							
						</div>
						
					</div>
					
					<!-- Product Info -->
					                                        <%
																ProductCustomerDAO pcdao = new ProductCustomerDAO();
																String vals = pcdao.getRatingProduct(prod.getProdID());
																int ratingSum = 0;
																int cusNum =  0;
																System.out.print(" vakues in products "+ vals);
																if(vals != null ){
																	String [] arr = vals.split(",");
																	if(arr[0] != null && arr[1] != null
																			&& (!arr[0].equals("") && !arr[1].equals("") )){
																		ratingSum = Integer.parseInt(arr[1]);
																		cusNum =  Integer.parseInt(arr[0]);
																	}																	
																}	
																 double avgSum = 0;
																 if(ratingSum >0 && cusNum >0)
																  avgSum = (double) ratingSum/cusNum;
								                                  %>
					<div class="col-sm-6 product_col text-right">
						<div class="product_info">
							<div class="product_name">
							 <!-- %session.getAttribute("productName"); %--> <%= prod.getName() %>
							  <input name="prodName" type="hidden" value="<%= prod.getName() %>"> 
							  <div class="product_rating_container d-flex flex-row align-items-center justify-content-start">
								
								  <div class="product_reviews"><%= avgSum %>|<%= cusNum %> לקוחות</div>	
								  							
								<div class="rating_r rating_r_4 product_rating">
								<% for(int i=0; i<avgSum; i++){ %>
								<i></i>
								<%} %>
								</div>
								
							  </div></div>
							
							<div class="product_text left"> <!-- %session.getAttribute("category"); %-->
							  <div class=" product-text " style="font-size: 18px;"> تصنيف- קטגוריה </div>
							  <%  if(prod.getCategory().equals(Category.SWEET)){ %>
								     <p> حلويات- קינוח </p>
							      <% }%>
							   <%  if(prod.getCategory().equals(Category.CAKE)){ %>
								     <p> كعكة - עוגות </p>
							      <% }%>
							   <%  if(prod.getCategory().equals(Category.MAINCOURSE)){ %>
								     <p> وجبة رئيسية - מנה עיקרית</p>
							      <% }%>
							   <%  if(prod.getCategory().equals(Category.APPETIZERS)){ %>
								   <p>  מנה ראשונה </p>
							      <% }%>
							   <%  if(prod.getCategory().equals(Category.SALAD)){ %>
								     <p> سلطات - סלטים </p>
							      <% }%>
							   </div>
							  <br>
							 <div class="product-text" style="font-size: 18px; color: #000;">السعر- המחיר 
						       <div >₪ <%= prod.getPiece_price() %>
						       </div>
						     </div>  
							
							
							 <br>
							<div class=" product-text right"  style="font-size: 18px; color: #000;">وصف- תיאור </div> <p style="font-size: 18px"> <%= prod.getDescription() %> </p>
							
							<br> 
									<div class="product-text" style="font-size: 18px;">كمية- כמות
							<br>
							  
							   		<% if(prod.getCategory().equals(Category.CAKE)){
							   			val3="cake";
							   		%>
							   		 <div class="product-text"  >
							   		   <label style="font-size: 16px; color: #A9A9A9;">  الطلبية حسب عدد الكعكات- ההזמנה לפי מספר העוגות</label>
									   <input type="number" name="quantity" id="quantityId" value="0" class="text-center" min="1" >
									</div>
									<% }else{
										val3="kilo";
									%>
									 <div class="product-text" >
							   		   <label  style="font-size: 16px; color: #A9A9A9;">  الطلبية حسب  الكيلو- ההזמנה לפי קילו</label>
									   <input type="number" name="quantity" id="quantity" value="<%=val2 %>" class="text-center" min="1" >
									</div>
									 <input type="hidden" name="type" value=val3>
									<%} 
									  
									%>
									<div class="product_buttons text-right">
								    <div class="text-right d-flex flex-row align-items-start justify-content-start">
									 <div class="product_button product_cart text-center d-flex flex-column align-items-center justify-content-center" >
										<div><div><a href="product.jsp?val1=<%=email%>&val2=<%=productId%>&val3=<%=val3%>&value=<%= productId%>&" onclick="addTextBoxData(this)">
										<img src="view/images/cart.svg" class="svg" alt=""></a>
										
										<script>
										function addTextBoxData(e){
										    e.href = e.href + "quan=" + document.getElementById('quantity').value;
										}
										</script>
										<!--a href="cart.jsp?value=<%=prod.getProdID()%>&val2=<%= val2 %>&val3=<%=val3%>">
										  <img src="view/images/cart.svg" class="svg" alt=""></a--><div>+</div></div></div>
									</div>
									<% System.out.print(" like is liked "+pc.getLike() );
									  if(pc.getLike() ==1 ){ %>
									<div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
									   
									     <div class="user">
											      <form action="<%=request.getContextPath()%>/LikeProductServlet" method="post">
											        <input type="hidden" value="<%= email %>" name="mailCus">
						                            <input type="hidden" value="<%= prod.getProdID()%>" name="prodidLiked">
						                            <input type="hidden" value=<%= jspName %> name="jspPage" >											         
											        <button  type="submit" value="" class="fa fa-heart"
											         style="font-size:48px;color:red; border: none;background-color: Transparent;
   														 background-repeat:no-repeat;">     </button>
											        
											      </form>
											      
										  </div>
									</div>
									<%}else{ %>
									
									 <div class="product_button product_fav text-center d-flex flex-column align-items-center justify-content-center">
									   <div>
									     <div class="user">
											      <form action="<%=request.getContextPath()%>/LikeProductServlet" method="post">
											        <input type="hidden" value="<%= email %>" name="mailCus">
						                            <input type="hidden" value="<%= prod.getProdID()%>" name="prodidLiked">
						                            <input type="hidden" value=<%= jspName %> name="jspPage" >											         
											        <button  type="submit" value="" 
											        style="border: none;"><img src="view/images/heart_2.svg" class="svg" > 
											        </button>
											      </form>
										  </div>
									   </div>
									</div>
								   <%} %>
								   </div>
							     </div>
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
										<a href="#"><div>שירות לקוחות<div class="footer_tag_1">אונליין</div></div></a>
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
								  All rights reserved to Zaki team <i class="fa fa-heart-o" aria-hidden="true"></i>
								  <br>Alaa && Hajar </div>
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
<script src="view/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
<script src="view/plugins/easing/easing.js"></script>
<script src="view/plugins/progressbar/progressbar.min.js"></script>
<script src="view/plugins/parallax-js-master/parallax.min.js"></script>
<script src="view/plugins/flexslider/jquery.flexslider-min.js"></script>
<script src="view/js/product.js"></script>
<script src="view/js/cart.js"></script>
</body></html>