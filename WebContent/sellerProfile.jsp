<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=utf-8" %>

<%@ page import=" java.io.UnsupportedEncodingException,com.hajar.zaki.dao.UserDAO, com.hajar.zaki.dao.UserDAOImpl,
 				  com.hajar.zaki.model.User, com.hajar.zaki.model.Supplier , utils.*, java.sql.*, java.util.*,
				  com.hajar.zaki.dao.ProductDAO, com.hajar.zaki.model.Product,  com.hajar.zaki.dao.ProductCustomerDAO,
				  com.hajar.zaki.model.ProductCustomer, com.hajar.zaki.db.DBConnect, com.hajar.zaki.model.ProductPicture, 
				  com.hajar.zaki.dao.PicturesDao, java.io.*, java.util.Base64,com.hajar.zaki.model.Customer,
				  com.hajar.zaki.model.Order, com.hajar.zaki.dao.SupplierDAO,com.hajar.zaki.dao.OrderDAO, com.hajar.zaki.model.City,
				  com.hajar.zaki.dao.CustomerDAO, com.hajar.zaki.model.Supplier , java.text.DecimalFormat " %>
 				  
 				  
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
 
<title><%= session.getAttribute("userName") %></title>
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
	
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">
	.column {
  width:20%;
  }
  .img1 {
   border-radius: 50%;
  }
  
   #productManage, #addProd, #deleteProd, #orders ,#ratingDiv, #statistcs, #profileupdateDiv{
    display : none;
  }
  .content{
    
  	height:70%;
  }
 tr:nth-child(even) {
  background-color: #68D9B4;
  /*color : white;*/
}
tr:nth-child(odd) {
  background-color: white;
  /*color : #68D9B4;*/
}
	.btn{
	   background-color: #68D9B4;
	}
</style>
</head>
<body>

			 <%
				 Connection con = null;
					 Statement statement = null;
					 ResultSet resultSet = null;

				String userName = "";
				String password = "";
				String email = "";
				String sellerEmail="";
				String jspName  = "sellerProfile.jsp" ;

				/* Get below data from HttpSession. */
	
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				boolean sup = false;
				User user = new User ();
				UserDAOImpl userdao = new UserDAOImpl();
				SupplierDAO supdao = new SupplierDAO();
				CustomerDAO customerdao = new CustomerDAO();
				ArrayList<Supplier> suppliers = supdao.getAllSuppliers();
				ArrayList<Customer> customers = (ArrayList<Customer>) customerdao.getAllOfObjects();
				UserDAOImpl userDao = new UserDAOImpl();
				Supplier sup1 = new Supplier();
				OrderDAO orderdao = new OrderDAO();
				ArrayList<Order>  orders = new ArrayList<Order> ();
				if(userNameObj!=null){
					userName = (String)userNameObj;
				}
				
				if(emailObj!=null){
					email = (String)emailObj;
					email = email.replaceAll(" ","");
					orders = orderdao.getOrderdPerSupplier(email);
					for(Supplier s : suppliers){
						if(s.getUserMail().equals(email)){
							sup = true;
							user = userDao.getUserByEmail(email);
							sup1 = s;
							System.out.println(" email : "+email+" supplier s : "+ s.getUserMail()+ " description : "+ s.getFoodDescription() );

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
			 %>
			
<!-- Menu -->
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

		<!-- Home -->
	<div class="content" style="height: 75%;">
	<div class="super_container_inner ">
		<div class="home  text-center" style="background:#68D9B4;">		
			<div class="">
				 <br>
					<div class="container text-right " >
			  	  <table >
			  	    <tbody>
			  	    <tr style="background-color: #68D9B4;" > 
			  	    		<td style="padding:0 0 0 0;"> 
			  	    		  <div  class=""  align="center">
								<button type="button" id="profileId"
									class="btn btn-lg  text-dark btn-block waves-effect" >
									<span ><small> פרופיל </small></span>
								</button>
							</div>
			  	    		</td> 
			  	    		<td style="padding:0 25px 0 25px;"> 
			  	    		  <div class="" align="center" >
								<button type="button" id="prodManageId"
									class="btn btn-lg  text-dark btn-block waves-effect" >
									<span> <small> ניהול מוצרים</small> </span>
								</button>
							</div>
			  	    		</td>
			  	    		<td style="padding:0 25px 0 25px;">
			  	    		<div id="b3" class="" align="center">
								<button type="button" id="ordersId"
									class="btn btn-lg text-dark btn-block waves-effec"  >
									<small> הזמנות להכנה </small> <span class="badge badge-success badge-pill" style="font-size: 14px;"><%= orders.size() %></span>
								</button>
							</div>
			  	    		</td>
			  	    	 <td  style="padding:0 25px 0 25px;" align="center">
								<button type="button" id="ratingId"
									class="btn btn-lg  text-dark btn-block waves-effect" >
									<span > <small><i class="far fa-star"> דירוג</i></small>
									</span>
								</button>
							</td>
			  	    	  <td style="padding:0 25px 0 0;" align="center">
								<button type="button" id="statisicsId"
									class="btn btn-lg  text-dark btn-block waves-effect" >
									<span> <small><i class="far fa-chart-bar"> סטטסטיקות</i></small>
									</span>
								</button>
							</td>
			  	    	</tr>
			  	    </tbody>
			  	  </table>
				
			  	</div>
			</div>	
						
		</div>
	</div>
		
			  </div>
	

		<!-- profile -->
			<div  class="container">
			 
			<div id="profileDiv"  style="font-size: 20px; ">
			<br>
			   <table>
		       <tbody>
				 <tr> 
				   <th style="padding:0 0 0 15px;"> 
				     <div class="" align="center" >
								<button type="button" id="profilebtnId"
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
				         <%
										  
										  String imageBase64="";
										  if( user != null && user.getImage() != null ){
											   imageBase64 = new String(Base64.getEncoder().encode(( user.getImage())));
											   
										  }	 if(imageBase64 !=null ){%>
											  <img src="data:image/jpeg;base64,<%=imageBase64%>"  style="border-radius:30%; border: none; height: 200px; width :240px;" />
											  <%} else{
												%>
											    <img  alt="" src="view/images/none.jpg" style=" border-radius:30%; border: none; height: 200px; width :240px;"> 
											  <%}%>
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
										<td  style="font-size: 18px;" >מחלקה</td>
										<td style="font-size: 16px;"  > <%= sup1.getFoodDescription() %> </td>
									</tr>
									
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
			
			<div id="profileupdateDiv" class="container">
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
							<input type="hidden" value="yes" name="is_supplier" >	
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
								      <td > מחלקה  </td>
								      <td> 
								        <input style=" width: 50%" type="text" value=" <%= sup1.getFoodDescription() %>" name="description">
								       </td> 
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
									<td ></td>
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
				
			  <div id="productManage" >
			    <br> <br>
			      <table>
			        <tbody>
			             <tr> 
					  	    		<td style="padding:0 15px 0 15px;"> 
					  	    			<div id="b1" class="" >
											<button type="button" id="addbtn"
												class="btn btn-sm btn-dark text-ligth btn-block waves-effect" >
												<span> הוספה</span>
											</button>
										</div>
					  	    		</td>
					  	    		<td style="padding:0 15px 0 15px;"> 
					  	    			<div id="b2" class="">
											<button type="button" id="updatebtn"
												class="btn btn-sm btn-dark text-light btn-block waves-effect">
												<span> עדכון</span>
											</button>
										</div>
					  	    		</td>
					  	    		<td style="padding:0 15px 0 15px;"> 
					  	    		  <div id="b3" class="" >
										<button type="button"  id="deletebtn"
											class="btn btn-sm btn-dark text-light btn-block waves-effect" >
											<span>מחיקה</span>
										</button>
									</div>
					  	    		</td>
					  	    		</tr>
			      </tbody>
			    </table>
				<div id="addProd"  class="container" style="font-size: 18px;">
						<div class="panel panel-body text-right">
						  <form action="<%=request.getContextPath()%>/AddProductServlet" method="post">
						    <table  class="table table-striped" style=" width: 100%; height: 100%;  bgcolor:blue; ">
								<tbody>
									<tr>
									</tr>
									<tr>
										<td>מספר מוצר</td>
										<td> <input name="id" style="width: 50%; height: 120%; " type="text"> </td>
									</tr>
									<tr>
										<td>שם מוצר</td>
										<td> <input name="prodName" style="width: 50%; height: 120%; " type="text"> </td>
									</tr>
									<tr>
										<td>דואר אלקטרוני</td>
										<td> <input name = "email"  style="width:50%;" type="text" value=" <%= user.getUserMail()%>">
										 </td>
									</tr>
									<tr>
										<td>מחיר</td>
										<td> <input name = "price" style="width: 50%;" type="number" min="1"> </td>
									</tr>
									
									<tr>
										<td>קטגוריה</td>
										<td>
										     <select style="width: 50%;" name="category">
										     	   <option  value="" > קטגוריה </option>
									                <option value="1" > סלט </option>
									                <option value="2" > קינוח </option>
									                <option value="3" >מנה ראשונה  </option>
									                <option value="4" > מנה עיקרית </option>
									        </select>
										 </td>
									</tr>
									<tr>
										<td>תיאור</td>
										<td> <input name = "" style="width: 50%;" type="text"> </td>
									</tr>
									<tr>
									  <td> </td>
									  <td> <div  class="" style="width: 50%; align: center;">
											<input  type="submit" id="addprodFun"
												class="btn btn-lg btn-dark btn-block waves-effect" value="הוספה" >
												<span style="width: 150 px;"><strong>  </strong></span>
											
								          </div>
									</td>
									</tr>
								</tbody>
							</table>
							
						  </form>
						</div>
					</div>
					
					<div id="updateProd" class="container" style="font-size: 22px; ">
						<div class="panel panel-body text-right">
						  <form action="<%=request.getContextPath()%>/UpdateProductServlet" method="post">
						    <table class="table table-light table-striped" style=" width: 100%; height: 100%;">
								<tbody>
									<tr>
									 <td> מוצר</td>
										<td>  
										   <select style="width: 50%;" name="id_prod">
										     	   <option  value="" > 
					 					     	      <% Product product = new Product();
				    
					 
					 try
					 {
						 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
						 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
						 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT); //Here table name is users and userName,password are columns. fetching all the records and storing in a resultSet.
						 
						while(resultSet.next()) // Until next row is present otherwise it return false
						 {  
							/*product.setProdID(resultSet.getString("productId"));
							product.setSupID(resultSet.getString("prodName"));
							product.setName(resultSet.getString("emailSupplier"));
							product.setPiece_price(resultSet.getFloat("priceOfPiece"));
							if(resultSet.getString("category") != null )
							product.setCategory( Enum.valueOf(Category.class, resultSet.getString("category").toUpperCase()));
							product.setDescription(resultSet.getString("description"));*/
							
						   %>
						      <option value="<%=(resultSet.getString("productId"))%>"> <%=(resultSet.getString("productId"))%> </option>  
						  <%
						 }
						con.close();
					 }catch(SQLException e){
					    e.printStackTrace();
					   } catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					 %>
					 </select>
					 </td>
					</tr>
					<% System.out.println(" test div update "+request.getParameter("id_prod")); %>
					
									<tr>
										<td>שם מוצר</td>
										<td> <input style="width: 50%;" type="text" name="productName" value="<%= product.getName()%>">  </td>
									</tr>
									<tr>
										<td>דואר אלקטרוני</td>
										<td>
										 <input style="width: 50%;" type="text" value=" <%= user.getUserMail()%>" name="mailSup">
										 </td>
									</tr>
									<tr>
										<td>מחיר</td>
										<td> <input style="width: 50%;" type="number" min="1" name="new_price" 
										  value="<%=product.getPiece_price()%>" > </td>
									</tr>
									
									<tr>
										<td>קטגוריה</td>
										 <td> 
										     <select style="width: 50%;" name="new_category">
										     	   <option  value="" > קטגוריה </option>
									                <option value="1" > סלט </option>
									                <option value="2" > קינוח </option>
									                <option value="3" >מנה ראשונה  </option>
									                <option value="4" > מנה עיקרית </option>
									        </select>
										 </td>
									</tr>
									<tr>
										<td>תיאור</td>
										<td> <input style="width: 50%;" type="text" name="new_description" value="product.getDescription()"> </td>
									</tr>
									<tr>
									  <td> </td>
									  <td> <div  class="" style="width: 50%; align: center;">
											<input  type="submit" id="addprodFun"
												class="btn btn-lg btn-dark btn-block waves-effect" value="עדכן" >
												<span style="width: 150 px;"><strong>  </strong></span>
											
								          </div>
									</td>
									</tr>
								</tbody>
							</table>
							
						
						  </form>
						</div>
					</div>
					
					<div id="deleteProd" class="container" style="font-size: 22px;">
						<div class="panel panel-body text-right">
						  <form action="<%=request.getContextPath()%>/DeleteProductServlet" method="post">
						    <table class="table table-light table-striped" style=" width: 100%; height: 100%;">
								<tbody>
									<tr>
									</tr>
									<tr>
										<td> מוצר</td>
										<td>  
										   <select style="width: 50%;" name="prodId_">
										     	   <option  value="" > 
				  <%
				    String prodName_ ="";
					 try
					 {
						 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
						 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
						 resultSet = statement.executeQuery(Constatns.SELECT_FROM_PRODUCT); //Here table name is users and userName,password are columns. fetching all the records and storing in a resultSet.
						 
						while(resultSet.next()) // Until next row is present otherwise it return false
						 {
						   %>
						      <option value="<%=(resultSet.getString("productId"))%>"> <%=(resultSet.getString("productId"))%>  <%=(resultSet.getString("prodName"))%></option>  
						  <%
						 }
						con.close();
					 }catch(SQLException e){
					    e.printStackTrace();
					   } catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					 %>
						  <% 
							 String idProd = request.getParameter("prodId_");
							 ProductDAO proddao = new ProductDAO();
							 Product produ = proddao.getProductPerId(idProd);
							%>	
					</select>
					 </td>
					</tr>
									<tr>
									 <td> </td>
									<td> <div  class="" style="width: 50%; align: center;">
											<input  type="submit" id="addprodFun"
												class="btn btn-lg btn-dark btn-block waves-effect" value="מחיקה" >
												<span style="width: 150 px;"><strong>  </strong></span>
											
								          </div>
									</td>
									</tr>									
								</tbody>
							</table>
							
						  </form>
						</div>
					</div>
			</div>
			<div id="orders"  >
			  	<div  style="height: 400px; width:100%; overflow:scroll;">
				<div id="profileInfo" class="">
						<div class="panel panel-body ">
							<table class="table table-light table-striped text-right">
								 <thead>
								   <tr> <!--  create a dynamic td tr  -->
										<th >לקוח/ה</th>
										<th >תיאור ההזמנה </th>
										<th > הכמות</th>
										<th > Status</th>
									    <% int N=orders.size(); 
                                         
										%> <!-- length the orders after the join and inner queries -->
										<% for(int row=0; row < N; row++) {
						                   ProductDAO pdao = new ProductDAO();
										   Product tmp_p = pdao.getProductPerId(orders.get(row).getProdId());
										 %>
									</tr> 
								 </thead>
									
									<tbody>
								     <tr >
										    <td ><%= orders.get(row).getCustomerId()%> </td>
										     <%
												DecimalFormat format = new DecimalFormat("0.#");
												 %>
											<td > <% out.println(tmp_p.getName()); %> </td>
											<td> <%= (format.format(orders.get(row).getQuantity())) %></td>
											<td>
											<form action="<%=request.getContextPath()%>/DeleteOrderServlet" method="post">
											<input type="text" name="rowOrder" style="visibility: hidden;" value="<%= row%>">
							            	<input type="hidden" name="o_num"  value="<%=  orders.get(row).getOrderNum()%>">
							             	<input type="hidden" value=<%= jspName %> name="jspPage" >	
										    <input type="submit" style="width:48px" class="btn btn-sm btn-outline-dark  btn-block waves-effect" value="מחק">
											</form>
											<form action="<%=request.getContextPath()%>/UpdateOrderStatus" method="post">
											<input type="text" name="rowOrder" style="visibility: hidden;" value="<%= row%>">
							            	<input type="text" name="orderNum" style="visibility: hidden;" value="<%=  orders.get(row).getOrderNum()%>">
										    <input type="submit" style="width:48px" class="btn btn-sm btn-outline-dark  btn-block waves-effect" value="Done">
											</form>
											<form action="<%=request.getContextPath()%>/OrderConfirmationServlet" method="post">
											<input type="text" name="rowOrder" style="visibility: hidden;" value="<%= row%>">
							            	<input type="hidden" name="o_num"  value="<%=  orders.get(row).getOrderNum()%>">
										    <input type="submit" style="width:48px" class="btn btn-lg btn-outline-dark  btn-block waves-effect" value=" הוסיף הזמנה להכנה">
											</form>
											</td>
										    <% } %>	
									 </tr>
																		
								</tbody>
							</table>
							
						</div>
				</div>
				</div>
			</div>
			
			<div id="ratingDiv"  style="font-size: 16px; ">
			<div class="container" >
			  		 <br> <br>
						<div class="panel panel-body text-right" >
							<table class="table  table-striped" style=" width: 100%; height: 100%;">
			<tr > 
			  <th>  מוצר </th>
			  <th>  ממוצע הדירוג </th>
			  <th> מס המעריכים </th>
			</tr>
			 <%
               ProductCustomerDAO pcdao = new ProductCustomerDAO();
				ProductDAO prodDao=new ProductDAO();

			   ArrayList<String> list_productscust = new ArrayList<>();
				int count =0, sum=0; String prodId =""; double avg = 0;
				 list_productscust =  pcdao.getListProducts_rate(email);
				if(list_productscust != null){
					for(String val : list_productscust){
					  if(val != null ){
						System.out.println(" val is "+val);
					    String [] arr = val.split(",");
						count=Integer.parseInt(arr[1]);
						sum = Integer.parseInt(arr[3]);
						prodId = arr[4];
						avg = (double) (sum / count);
						Product prod= prodDao.getProductPerId(prodId);
						if(prod != null ) { %>
						
						<tr>
						  <td> <%= prod.getProdID() %> <%= prod.getName() %></td> 
						  <td> <%= avg %></td> 
						  <td> <%= count%></td> 
						</tr>
						
				<%     }
			    	}
				  }
			   } %>
			   
			 </table>
			 </div>
			 </div>
			</div>
			<div id="statistcs" class="column" style="font-size: 22px; ">
			statistics
			</div>
			</div>
		
	  </div>
	  <br> <br>
		
			<!-- Footer -->

		<footer class="footer" style="height: 15%;">
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

    <script>
	   
   
   
		
		
		$(document).ready(function() {
		    $('#profileId').click( function() {
		    	$('#profileDiv').show();
		    	$('#profileDetails').show();
		    	$('#profileupdateDiv').hide();
		    	$('#addProd').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#productManage').hide();
		    	$('#profileId').css("color", "black");
		        $('#profileDetails').css("color", "black");
		    	});
		 });
		$(document).ready(function() {
		    $('#profilebtnId').click( function() {
		    	$('#profileDiv').show();
		    	$('#profileDetails').show();
		    	$('#profileupdateDiv').hide();
		    	$('#addProd').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#productManage').hide();
		    	});
		 });		
		$(document).ready(function() {
		    $('#updatebtnId').click( function() {
		    	$('#profileDiv').show();
		    	$('#profileupdateDiv').show();
		    	$('#profileDetails').hide();
		    	$('#addProd').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#productManage').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#prodManageId').click( function() {
		    	$('#productManage').show();
		    	$('#addProd').show();
		    	$('#profileDetails').hide();
		    	$('#profileupdateDiv').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#profileDiv').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#addbtn').click( function() {
		    	$('#productManage').show();
		    	$('#addProd').show();
		    	$('#profileupdateDiv').hide();
		    	$('#profileDetails').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#profileDiv').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#deletebtn').click( function() {
		    	$('#productManage').show();
		    	$('#profileupdateDiv').hide();
		    	$('#profileDetails').hide();
		    	$('#addProd').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').show();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#profileDiv').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#updatebtn').click( function() {
		    	$('#productManage').show();
		    	$('#addProd').hide();
		    	$('#profileupdateDiv').hide();
		    	$('#profileDetails').hide();
		    	$('#updateProd').show();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#profileDiv').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#ordersId').click( function() {
		    	$('#orders').show();
		    	$('#addProd').hide();
		    	$('#profileupdateDiv').hide();
		    	$('#profileDetails').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#ratingDiv').hide();
		    	$('#profileDiv').hide();
		    	$('#productManage').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#statisicsId').click( function() {
		    	$('#statistcs').show();
		    	$('#profileupdateDiv').hide();
		    	$('#profileDetails').hide();
		    	$('#addProd').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#orders').hide();
		    	$('#ratingDiv').hide();
		    	$('#profileDiv').hide();
		    	$('#productManage').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#ratingId').click( function() {
		    	$('#ratingDiv').show();
		    	$('#profileupdateDiv').hide();
		    	$('#profileDetails').hide();
		    	$('#addProd').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#profileDiv').hide();
		    	$('#productManage').hide();
		    	});
		 });
		
		$(document).ready(function() {
		    $('#ratingId').click( function() {
		    	$('#ratingDiv').show();
		    	$('#profileupdateDiv').hide();
		    	$('#profileDetails').hide();
		    	$('#addProd').hide();
		    	$('#updateProd').hide();
		    	$('#deleteProd').hide();
		    	$('#statistcs').hide();
		    	$('#orders').hide();
		    	$('#profileDiv').hide();
		    	$('#productManage').hide();
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
