<%@ page language="java" contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>

<html lang="he"  >
<head>
	<title>زاكي-זאכי-zakki</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link  rel="stylesheet" type="text/css" href="view/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="view/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="view/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="view/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="view/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="view/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="view/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="view/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="view/css/util.css">
	<link rel="stylesheet" type="text/css" href="view/css/main.css">
<!--===============================================================================================-->
<link rel="stylesheet" type="text/css" href="view/styles/global.css">
<link href="https://fonts.googleapis.com/css?family=Alef&display=swap" rel="stylesheet">
</head>
<body>


  <script>
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else {
      // The person is not logged into your app or we are unable to tell.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }

  window.fbAsyncInit = function() {
    FB.init({
      appId      : '318625492413691',
      cookie     : true,  // enable cookies to allow the server to access 
                          // the session
      xfbml      : true,  // parse social plugins on this page
      version    : 'v2.8' // The Graph API version to use for the call
    });

    // Now that we've initialized the JavaScript SDK, we call 
    // FB.getLoginStatus().  This function gets the state of the
    // person visiting this page and can return one of three states to
    // the callback you provide.  They can be:
    //
    // 1. Logged into your app ('connected')
    // 2. Logged into Facebook, but not your app ('not_authorized')
    // 3. Not logged into Facebook and can't tell if they are logged into
    //    your app or not.
    //
    // These three cases are handled in the callback function.

    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "https://connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
      document.getElementById('status').innerHTML =
        'Thanks for logging in, ' + response.name + '!';
    });
  }
</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->
  
	
	
	<div class="container-login100" style="background-image:url(view/images/home1.jpeg);">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
			<form name="form" class="login100-form validate-form"  method="post" 
			  action="<%=request.getContextPath()%>/UserServlet" >
				<span dir="rtl" class="login100-form-title p-b-37">
					התחבר למערכת
				</span>

				<div dir="rtl" class="wrap-input100 validate-input m-b-20" data-validate=" הקליד שם משתמש שלך">
					<input dir="rtl" class="input100" id="mailID" type="text" name="email" placeholder=" הקליד שם משתמש שלך">
					<span dir="rtl" class="focus-input100"></span>
				</div>

				<div dir="rtl" class="wrap-input100 validate-input m-b-25" data-validate = "הקליד הסיסמה שלך">
					<input dir="rtl" class="input100" id="passwordID" type="password" name="pass" placeholder="הקליד הסיסמה שלך">
					<span  dir="rtl" class="focus-input100"></span>
				</div>

				<div class="container-login100-form-btn">
					<button class="login100-form-btn" >
						התחבר
					</button>
				</div>

				<div class="text-center p-t-57">
					<span  class="txt1">
						התחבר באמצעות 
					</span>
					
					<div class="flex-c ">
					<a href="#" class="login100-social-item fa fa-facebook"  onclick="checkLoginState();">
						
					</a>

					<a href="#" class="login100-social-item">
						<img src="view/images/icons/icon-google.png" alt="Google">
					</a>
				</div>
				</div>
				<div class="text-center">
					<a dir="rtl" href="register.jsp" class="txt2 hov1">
					 הירשם
					</a>
			    </div>
			</form>
			
			

			
		</div>
	</div>
	
	

	<div id="dropDownSelect1"></div>
	
	
	
<!--===============================================================================================-->
	<script src="view/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="view/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="view/vendor/bootstrap/js/popper.js"></script>
	<script src="view/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="view/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="view/vendor/daterangepicker/moment.min.js"></script>
	<script src="view/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="view/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="view/js/main.js"></script>
<!--===============================================================================================-->

   <!-- script type="text/javascript">
    
	   function validate(form)
	   { 
	   	 var password = document.getElementById(passwordID);

	   	  
	   	  if(password.value.length==9){ 
	   		 $(password).parent().addClass('btn-hide-validate');
             
	   		  return CheckPassword();
	   	 }else{
	   		 return false;
	   	 }
	   }
	   	 function CheckPassword() { 
	   	   
           if(document.getElementById(passwordID).value.length!=9){
           	return false;
           }
	   	}
	   
	  
   
   </script-->
   

</body>
</html>