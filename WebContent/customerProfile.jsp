<%@page import="com.hajar.zaki.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.hajar.zaki.model.Customer, com.hajar.zaki.dao.SupplierDAO,  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier "%>
<%@ page import=" java.io.UnsupportedEncodingException,com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl,
 				  com.hajar.zaki.model.User, com.hajar.zaki.model.Supplier , utils.*, java.sql.*, java.util.*,com.hajar.zaki.dao.ProductDAO, com.hajar.zaki.model.Product,
 				  com.hajar.zaki.db.DBConnect, com.hajar.zaki.model.Order, com.hajar.zaki.model.ProductPicture, com.hajar.zaki.model.City ,com.hajar.zaki.dao.PicturesDao, java.io.*, java.util.Base64" %>
 <%@page import=" java.text.DecimalFormat" %>		
 
 <%
 response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
 response.setHeader("Pragma","no-cache"); //HTTP 1.0
 response.setDateHeader ("Expires", 0); 
 %>
 
 				
<!DOCTYPE html>
<html  lang="he" dir="rtl">
<head>
<meta charset="ISO-8859-1">
<title> פרופיל  לקוח</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="view/styles/bootstrap-4.1.2/bootstrap.min.css">
<link href="view/plugins/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="view/styles/sellerProfile.css">
<link rel="stylesheet" type="text/css"	href="view/styles/checkout_responsive.css">
<link rel="stylesheet"href="https://use.fontawesome.com/releases/v5.8.2/css/all.css" integrity="sha384-oS3vJWv+0UjzBfQzYUhtDYW+Pj2yciDJxpsK1OYPAYjqT085Qq/1cq5FLXAZQ7Ay" crossorigin="anonymous">
<link rel="stylesheet" type="text/css"	href="view/css/style.css">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>


<script type="text/javascript" src="view/js/jquery-1.4.2.min.js"></script>
<script src="view/js/jquery.autocomplete.js"></script>

  <link href="view/css/jquery-ui.css" rel="stylesheet">
  <script src="view/js/jquery-1.11.2.js"></script>
  <script src="view/js/jquery-ui.js"></script>
  

<script>
jQuery(function(){
$("#names").autocomplete("list.jsp");
});
</script>
  
<style type="text/css">
	.column {
  width:30%;
  }
  .img1 {
   border-radius: 50%;
  }
  
   #profileupdateDiv, #orders, #report{
    display : none;
  }
   tr:nth-child(even) {
  background-color: white;
  /*color : white;*/
}
tr:nth-child(odd) {
  background-color: white;
  /*color : #68D9B4;*/
}
	.btn{
	   background-color: white;
	   border: none;
	}
  
</style>
</head>
<body>
       <%

				String userName = "";
				String password = "";
				String email = "";
				String jspName  = "customerProfile.jsp" ;
				/* Get below data from HttpSession. */
	
				Object emailObj = session.getAttribute("email");
				User user = new User();
				boolean sup = false;
				UserDAOImpl userdao = new UserDAOImpl();	
				OrderDAO orderdao = new OrderDAO();
				ArrayList<Order> orders = new ArrayList<>();
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
				
				if(emailObj!=null){
					email = (String)emailObj;
					user = userdao.getUserByEmail(email);
					orders= orderdao.getOrderdPerCustomer(email);
					userName = user.getUserName();
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


<div class="menu">

	<!-- Search -->
	<div class="menu_search">
		<form action="" id="menu_search_form" class="menu_search_form" >
			<button class="menu_search_button"><img src="view/images/search.png" alt=""></button>
			<input  class="input1_text" style="width: 300px; margin: 50px auto;" 
			       type="text" class="search_input" placeholder="..." 
			        id="names" name="names" required="required">
			       
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
					<li><a href="salad.jsp?userName=<%=userName%>&email=<%=email%>">סלט</a></li>
					
					</ul>
			</nav>

		</div>
		
		       <!-- Search -->
				<div class="header_search">
					<form action="#" id="header_search_form">
						<button class="header_search_button"><img src="view/images/search.png" alt=""></button>
						<input  style="width: 300px; margin: 50px auto;"
						        type="text" class="search_input" placeholder="..." id="names" name="names" required="required">
					</form>
				</div>
				
				
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
				<div class="user">
				<a href="login.jsp">
				<div>
				  <img src="view/images/user.svg" alt="https://www.flaticon.com/authors/freepik" >
				   
				</div></a>
				<div id="userName" style="color:black;"> 
						<%= userName  %> </div>
				</div>
				 
			  </div >
			  </c:if>
			 
			<c:if test="${not empty userName}"> 
			<a href="chat.jsp?pageJsp=customerProfile" 
				class="btn btn-sm btn-outline-light text-dark  waves-effect" style="border: none; background-color: white; ">
					<span> <small><i class="far fa-comments"style="font-size: 25px"> צ'אט</i></small>
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
</div>
	 <div>
	   <div class="super_container_inner">
		<!-- div class="home  text-center" style="background:#FAF8F7;"-->
			<!-- >div class="home  text-center" style="background:#68D9B4;"-->
			<div class="home  text-center" style="background-image:url(view/images/hme1.png);  background-repeat: no-repeat; width:100%;">
				<div class="container text-center " style="width: 100%;" >
			  	<div class="column">
			  	  <table style="font-size: 18px;">
			  	    <tbody>
			  	    <tr > 
			  	           <td style="padding:0 0 0 0;" > 
			  	    		  <div  class=""  align="center">
								<button type="button" id="profilebtnId"
								   class="btn btn-lg  text-dark btn-block waves-effect" >
									<span ><small> מידע אישי </small></span>
								</button>
							</div>
			  	    		</td> 
			  	    		
			  	    		<td style="padding:0 25px 0 25px;">
			  	    		<div id="b3" class="" align="center">
								<button type="button" id="ordersbtnId"
									class="btn btn-lg  text-dark btn-block waves-effect" >
									<small> ההזמנות  </small> <span class="badge badge-success badge-pill" style="font-size: 14px;"><%=orders.size()  %></span>
								</button>
							</div>
			  	    		</td>
			  	    		
			  	    		<td style="padding:0 25px 0 25px;">
			  	    		<div id="b3" class="" align="center">
								<button type="button" id="reportbtnId"
									class="btn btn-lg  text-dark btn-block waves-effect" >
									<small> דוח פעילות </small>
								</button>
							</div>
			  	    		</td>
			  	    	</tr>
			  	    </tbody>
			  	  </table>				
			  	</div>				
			</div>
						
		</div>
	</div>
		
	  </div>
				
			  
				
        <br>
		<!-- profile -->
			<div  class="container">
			 
			<div id="profileDiv"  style="font-size: 20px; ">
			<br>
			   <table>
		       <tbody>
				 <tr> 
				   <th style="padding:0 0 0 15px;"> 
				     <div class="" align="center" >
								<button type="button" id="profilebtnIdDtails"
									class="btn btn-sm btn-outline-dark  btn-block waves-effect" >
									<span> <small> מידע אישי</small> </span>
								</button>
							</div>
				  	    </th>
				  	<th style="padding:0 0 0 0;"> <div class="" align="center" >
								<button type="button" id="updatebtnId"
									class="btn btn-sm btn-outline-dark  btn-block waves-effect" >
									<span> <small> עדכן מידע אישי</small> </span>
								</button>
							</div>
				     </th>
				   </tr>		       
		        </tbody>				  	    
			  </table>
			  
			  <br>
			  <div id="profileDetails"  class="container ">
				 <!-- h4 class="" style="color: #000; ">מידע אישי  </h4-->
				  <table>
				    <tbody>
				      <tr style="background-color: white; ">
				        <td>
				         <form enctype="multipart/form-data"> 
				         	   <%
										  
										  String imageBase64="";
										  if( user != null && user.getImage() != null ){
											   imageBase64 = new String(Base64.getEncoder().encode(( user.getImage())));
											   
										  }	 if(imageBase64 !=null ){%>
											  <img src="data:image/jpeg;base64,<%=imageBase64%>"  style="border-radius:30%; border: none; height: 200px; width :240px;" />
											  <%} else{
												%>
											    <img  alt="" src="view/images/none.jpg" style="border-radius:30%; border: none; height: 30px; width :30px;"> 
											  <%}%>
				         </form> 
				        </td>
				           <td style="padding: 0 25px 0 25px ;">
				              <strong> <input type="text" name='userEmail' value="<%= userName %> <%= user.getUserSurName()%>"
					         disabled style=" background: rgba(0, 0, 0, 0);  border: none;">  </strong>
					        </td> 
				      </tr>
				      
				    </tbody>
				  </table>
				  <div>
				  </div>	
			 
			  	<div class="container" >
			  		 <br> <br>
						<div class="panel panel-body text-right" >
							<table class="table  table-striped" style=" width: 100%; height: 100%;">
								<tbody style="color: black;">
									<tr>
										<td style="font-size: 18px;">מין</td>
										<td style="font-size: 16px;" ><%= user.getGender() %></td>
									</tr>
									<tr>
										<td style=" font-size: 18px;">כתובת</td>
										<td style="font-size: 16px;"> <%= user.getCityName() %></td>
									</tr>
									<tr>
										<td style=" font-size: 18px;">דואר אלקטרוני</td>
										<td style="font-size: 16px;"><a href="mailto:info@support.com">
										  <%= user.getUserMail()%></a></td>
									</tr>
									<tr>
									<td style=" font-size: 18px;">טלפון</td>
									<td style="font-size: 16px;" ><%= user.getPhoneNumber() %></td> 
									</tr>
								</tbody>
							</table>
						</div>
				</div>
			   </div>
			
		    	<div id="profileupdateDiv" >
				 <div class="column "> </div>
		         <div  style="font-size: 18px; ">
				  <div class="column ">
					<!-- h4 class="" style="color: #000; ">מידע אישי  </h4-->
					  <form action="<%=request.getContextPath()%>/FileUploadDBServlet" method="post" enctype="multipart/form-data">					  
					  <table>
					    <tbody>
							
					      <tr > <td class="text-center">  
					      <input type="hidden" name="mailUser" value=<%= email%>>
						<input type="hidden" value=<%= jspName %> name="jspPage" >	
						<input type="hidden" value="no" name="is_supplier" >	
						
					      <input  class="btn btn-sm "style="background:url(view/images/none.jpg) no-repeat; 
					               border: none; height: 200px; width :240px;" type="file" name="photo" value="בחר תמונה" />
	                        </td>
	                        </tr>
					      <tr style="background-color: white;"> 
					       <td class="text-center">   
					       <input class="btn btn-sm btn-dark btn-outline-dark" style="border-radius: 20%;" type="submit" value="העלה תמונה" /> </td>
					      </tr>
					    </tbody>
					  </table>
					  </form>
			      </div>
				  	   <br> <br>
				<div class="panel panel-body text-right" style="font-size: 16px; color: #000;">
						  <form action="<%=request.getContextPath()%>/UpdateUserDataSupServlet" method="post">
							<table class="table table-light table-striped" style=" width: 100%; height: 100%;">
								<tbody>
								    <tr>
								      <td > שם  </td>
								      <td> 
								        <input style=" width: 50%" type="text" value=" <%= userName %> " name="userName">
								       </td> 
								     </tr>
								     <tr>
								        <td > שם משפחה  </td>
								      <td> 
								        <input style=" width: 50%" type="text" value=" <%= user.getUserSurName() %>" name="surName">
								       </td> 
								     </tr> 
									<tr>
										<td >דואר אלקטרוני </td>
										<td><input style=" width: 50%;" type="text" value=" <%= user.getUserMail()  %>" name="mail"> </td>
									</tr>
									
									
									<tr>
										<td >מין</td>
										<td> 
										  <select name="gender">
										    <option> <%= user.getGender()  %> </option>
										    <option>انثى- נקבה-female</option>
							                <option>ذكر- זכר- male</option>										    
										  </select>
										
									</tr>
									
									<tr>
										<td >כתובת</td>
										<td> 
						<select style = " width: 50% " name="city" > 
						
				    <%
				    Connection con1 = null;
					 Statement statement1 = null;
					 ResultSet resultSet1 = null;
					 
					City city=new City();
					ArrayList<City> cities=new ArrayList<City>();
					 ////////
					 try
					 {
						 con1 = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
						 statement1 = (Statement) con1.createStatement(); //Statement is used to write queries. Read more about it.
						 resultSet1 = statement1.executeQuery(Constatns.SELECT_FROM_CITY); //Here table name is users and userName,password are columns. fetching all the records and storing in a resultSet.
						 
						while(resultSet1.next()) // Until next row is present otherwise it return false
						 {							
						  %>
						      <option value="<%=Integer.parseInt(resultSet1.getString("cityID"))%>"><%=resultSet1.getString("cityName")%></option>  
						  <%
						 }
						con1.close();
					 }catch(SQLException e){
					    e.printStackTrace();
					   } catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					 %>
				      </select>  
				    
					</td>
									</tr>
									<tr>
									<td >טלפון</td>
									<td><input style=" width: 50%;" type="text" value=" <%= user.getPhoneNumber()  %>" name="phone"></td> 
									</tr>
									
									<tr>
									<td >						<input type="hidden" value=<%= jspName %> name="jspPage" >	
									</td>
									
									<td  >
									 <input type="submit" style=" width: 50%; font-size: 24px; color: dark;" class="btn btn-sm btn-dark btn-outline-dark" value="עדכן">  
									 
									 </td>
									</tr>
								</tbody>
							</table>
							</form>
						</div>
				</div>
		    </div>
		</div>
			
		 <div id="orders" style="font-size: 22px;" class="container" >
						<div class="panel panel-body text-right">
						<form action="<%=request.getContextPath()%>/DeleteOrderServlet" method="post">
							<table class="table table-user-information" >
								<tbody >
									<tr style="font-size: 16 px;"> <!--  create a dynamic td tr  -->
										<th>לקוח/ה</th>
										<th>מספר ההזמנה </th>
										<th> מוצר </th>
										<th>  כמות</th>
										<th></th>
									    <% int N=100; %> <!-- length the orders after the join and inner queries -->
										<% for(int row=0; row < orders.size(); row++) { 
						                   			ProductDAO pdao = new ProductDAO();
										 		    Product tmp_p = pdao.getProductPerId(orders.get(row).getProdId());
													DecimalFormat format = new DecimalFormat("0.#");
										       %>
									  </tr>
									  <tr> 
										    	<td><%= orders.get(row).getCustomerId() %> </td>
												<td>  <input type="text" name="o_num" style="background-color: white; border: none;" 
												             value="<%= orders.get(row).getOrderNum() %>">
												            <input type="hidden" name="mailC" value= <%= email %>>
												          	<input type="hidden" value=<%= jspName %> name="jspPage" >	
												            
												 </td>
												<td> <% out.println(tmp_p.getName());%></td>
												<td> <%=(format.format(orders.get(row).getQuantity())) %> </td>
												<td>
												<input type="submit" class="btn btn-sm btn-outline-dark  btn-block waves-effect" value=" מחק" > <!--  will be deleted from db after the confirmation -->											   
										
										<% }  %>	
										 </tr>													
								</tbody>
							</table>
							</form>
							<form action="<%= request.getContextPath()%>/DeleteAllOrdersOFCustomer" method="post">
							  <table>
							    
							     <tbody>
							       <tr >
									 <td  style=" padding:0 750px 0 0;" class="text-center" >
									   <input type="hidden" name="mailCustomer" value="<%= email %>" >
									  	<input type="submit" 
									  	   class=" btn-lg btn-dark  btn-block waves-effect" value="מחק הכל" style="width: 350px; " >   <!--  will be deleted from db after the confirmation -->											   
									 </td>
										 </tr>	
							     </tbody>
							  </table>
							</form>
							
										  
						</div>		
			</div>
			   
			<div id="report"  class="container text-center" >
			
									 
			</div>
			
			</div>
	 	<br> 
			 
			<!-- Footer -->

		<footer class="footer">
			<div class="footer_content">
				<div class="container">
					<div class="row">

						<!-- About -->
						<div class="col-lg-4 footer_col">
							<div class="footer_about">
								<div class="footer_logo">
									<a href="#" class="d-flex flex-row align-items-center justify-content-start">
									 <img src="view/images/logo5.png" alt="" class="footer_logo_icon">
									</a>
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
		
    <script type="text/javascript">
    $(document).ready(function() {
	    $('#profilebtnId').click( function() {
	    	$('#profileDiv').show();
	    	$('#profileDetails').show();
	    	$('#profileupdateDiv').hide();
	    	$('#orders').hide();
	    	$('#report').hide();
	    	});
	   });
   
    $(document).ready(function() {
	    $('#profilebtnIdDtails').click( function() {
	    	$('#profileDiv').show();
	    	$('#profileDetails').show();
	    	$('#profileupdateDiv').hide();
	    	$('#orders').hide();
	    	$('#report').hide();
	    	});
	   });
    
    
    $(document).ready(function() {
	    $('#updatebtnId').click( function() {
	    	$('#profileDiv').show();
	    	$('#profileDetails').hide();
	    	$('#profileupdateDiv').show();
	    	$('#orders').hide();
	    	$('#report').hide();
	    	});
	   });
    
    $(document).ready(function() {
	    $('#ordersbtnId').click( function() {
	    	$('#profileDiv').hide();
	    	$('#profileupdateDiv').hide();
	    	$('#profileDetails').hide();
	    	$('#orders').show();
	    	$('#report').hide();
	    	});
	   });
    
    $(document).ready(function() {
	    $('#reportbtnId').click( function() {
	    	$('#profileDiv').hide();
	    	$('#profileDetails').hide();
	    	$('#profileupdateDiv').hide();
	    	$('#orders').hide();
	    	$('#report').show();

	    	});
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
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
	
	
</body>
</html>