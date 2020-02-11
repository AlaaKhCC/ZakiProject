
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
<meta charset="ISO-8859-1">
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

<title>Customer Details</title>
</head>
<body>

	
			 <%

				String userName = "Vistor";
				String password = "";
				String email = "";
				String msg="";
				/* Get below data from HttpSession. */
	
				Object userNameObj = session.getAttribute("userName");
				Object emailObj = session.getAttribute("email");
				
			    System.out.println(" alaa boma test      > "+ userNameObj);
				if(userNameObj!=null){
					userName = (String)userNameObj;
				}
				
				if(emailObj!=null){
					email = (String)emailObj;
				}
			
			%>

	<!-- Billing -->
	              <div class="col-lg-6">
	              	<div style="color:'#000000'; size: 28px;" class="checkout_title ">פרטי מקבל המשלוח</div>
	              </div>
					<div class="col-lg-6">
						<div class="billing">
							<div class="checkout_form_container">
								<form action="#" id="checkout_form" class="checkout_form">
									 <div >
											<!-- Name -->
									  <p>שם פרטי  : <%= session.getAttribute("userName")%> </p>
									 </div>
									 <!-- Last Name -->
									 <div> 
									 <p > שם משפחה : <%= session.getAttribute("surName")%></p>
									</div>
									<div>
										<!-- Phone no -->
										<p> מספר טלפון סוללרי: <%= session.getAttribute("phone")%> </p>
									</div>
									<div>
										<!-- Email -->
										<p> email : <%= session.getAttribute("email")%> </p>
									</div>
									<div>
										<!-- City / Town -->
								    	<p> עיר מגורים : <%= session.getAttribute("city")%></p>
										
									</div>
								
								</form>
							</div>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
					
</body>
</html>