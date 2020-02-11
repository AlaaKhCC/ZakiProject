<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="java.sql.*, java.util.*,com.hajar.zaki.dao.CityDAO, com.hajar.zaki.model.City,com.hajar.zaki.db.DBConnect, utils.Constatns" %>
<!DOCTYPE html>
<html lang="he" dir="rtl">
<head>
	<title>Taste Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="view/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="view/vendor/bootstrap/css/bootstrap.min.css">
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
	  
	  
	<div class="container-login100" style="background-image: url('view/images/cookies.jpg');">
		<div class="wrap-login100 p-l-55 p-r-55 p-t-80 p-b-30">
			<form id="form" name="form" class="login100-form validate-form"  method="post" 
			action="<%=request.getContextPath()%>/RegisterationServlet" onsubmit="return validate();" >
				<span dir="rtl" class="login100-form-title p-b-37">
					הירשם 
				</span>

				<div id="form-mail" class="wrap-input100 validate-input m-b-20" data-validate="הקליד כתובת האי-מייל">
					<input  dir="rtl" id="mail" class="input100" type="text" name="email" placeholder="הקליד כתובת האי-מייל " required>
					<span   dir="rtl" class="focus-input100"></span>
				</div>
				<div id="tmpmail"></div>
				
				<div  id="form-username" class="wrap-input100 validate-input m-b-20" data-validate="הקליד  שם פרטי">
					<input   class="input100" type="text" name="username" placeholder="שם פרטי" required>
					<span   class="focus-input100"></span>
				</div>
				
				<div  id="form-surname" class="wrap-input100 validate-input m-b-20" data-validate="הקליד שם משפחה">
					<input  dir="rtl" class="input100" type="text" name="surname" placeholder="שם משפחה" required>
					<span  dir="rtl" class="focus-input100"></span>
				</div>

				<div  id="form-pass" class="wrap-input100 validate-input m-b-25" data-validate = "הקליד הסיסמה">
					<input  dir="rtl" id="passwordID" class="input100" type="password" name="pass" placeholder="סיסמה" required>
					<span  dir="rtl" class="focus-input100"></span>
				</div>
				<div id="tmpPass"> </div>
				<div id="form-pass2" class="wrap-input100 validate-input m-b-25" data-validate = "הקליד הסיסמה מחדש">
					<input  dir="rtl" id="passwordID2" class="input100" type="password" name="pass2" placeholder="סיסמה מחדש" required>
					<span  dir="rtl" class="focus-input100"></span>
				</div>
				<div id="tmpPass2"> </div>
				
				<div  id="form-surname" class="wrap-input100 validate-input m-b-20" data-validate="הקליד שם משפחה">
					<input   class="input100" type="text" name="phoneNumber" placeholder="מספר טלפון" required>
					<span class="focus-input100"></span>
				</div>
				 <div align="center">
				<input type="checkbox" name="gender" id="fid" value="female" onclick="uncheckg(f);" checked>  נקבה 
				<input type="checkbox" name="gender" id="mid" value="male" onclick="uncheckg(m);"> זכר 			
				</div>
				<div align="center">
				<input type="checkbox" name="user" id="custid" value="customer" onclick="uncheck(1);" checked>  לקוח/ה 
				<input type="checkbox" name="user" id="suppid" value="supplier" onclick="uncheck(2);">  מוכר/ת 			
				</div>
						&nbsp
			<div  align="center">
			        <select name="city" > 
				     <option value="-1"> בחור/בחרי עיר</option> 
				    <%
				    Connection con = null;
					 Statement statement = null;
					 ResultSet resultSet = null;
					 
					City city=new City();
					ArrayList<City> cities=new ArrayList<City>();
					 ////////
					 try
					 {
						 con = (Connection) DBConnect.getInstance().createConnection(); //establishing connection
						 statement = (Statement) con.createStatement(); //Statement is used to write queries. Read more about it.
						 resultSet = statement.executeQuery(Constatns.SELECT_FROM_CITY); //Here table name is users and userName,password are columns. fetching all the records and storing in a resultSet.
						 
						while(resultSet.next()) // Until next row is present otherwise it return false
						 {
							
						   %>
						      <option value="<%=Integer.parseInt(resultSet.getString("cityID"))%>"><%=resultSet.getString("cityName")%></option>  
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
				    
				    
				     
	        </div>
	        &nbsp
				<div class="container-login100-form-btn">
					<button  class="login100-form-btn">הירשם</button>
						
				</div>
			<div class="text-center">  				  
					<a  dir="rtl" href="index.jsp" class="txt2 hov1 box1">						
						התחבר
					</a>
				</div>
				 
				
			</form>
			
		
							
		</div>
	</div>
	
	

	
	

	<script>
	function checkRefresh(value)
	{
	    document.form.submit();
	} 
	
	function uncheck(check)
	{
	    var female = document.getElementById("fid");
	    var male = document.getElementById("mid");
	    if (female.checked == true && male.checked == true)
	    {
	        if(check == f)
	        {
	            female.checked = false;
	            checkRefreshg();
	        }
	        else if(check == m)
	        {
	            male.checked = false;
	            checkRefreshg();
	        }
	    }

	}
	
	function checkRefreshg(value)
	{
	    document.form.submit();
	} 
	
	function uncheckg(check)
	{
	    var prim = document.getElementById("custid");
	    var secn = document.getElementById("suppid");
	    if (prim.checked == true && secn.checked == true)
	    {
	        if(check == f)
	        {
	            secn.checked = false;
	            checkRefreshg();
	        }
	        else if(check == m)
	        {
	            prim.checked = false;
	            checkRefreshg();
	        }
	    }

	}
	</script>				
	
<!--===============================================================================================-->
	<script src="view/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
	
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
	<script type="text/javascript">
	
	function validate(){
		 var email = document.forms["form"]["email"].value;
		 var userName=document.forms["form"]["username"].value;
		 var surname= document.forms["form"]["surname"].value;
		 var password = document.forms["form"]["pass"].value;
		 var conpassword=  document.forms["form"]["pass2"].value;
		
		 
		 if(ValidateEmail(email) && conpassword.length==9 && password.length==9 && 
				 conpassword==password && userName!="" && surname!=""){
			  document.getElementById("tmpmail").innerHTML ="";
			  document.getElementById("tmpPass").innerHTML ="";
			  document.getElementById("tmpPass2").innerHTML ="";
			  document.form.submit();

			  return true;
	
		  }
		  if(email=="" && userName=="" && surname=="" && password=="" && conpassword==""){
			  alert("מלא/י פרטים")
			  return false;
		  }
		  else{
			  if(!ValidateEmail(email)){
					//  alert("כתובת המייל אי אפשר תהיה ריקה!"); 
					  document.getElementById("tmpmail").innerHTML ="המייל צריך להיות בצורה זו aaaa@eeee.eee";
				  }
				  if(password.length!=9)
				 { 
					  document.getElementById("tmpPass").innerHTML ="הסיסמה בעלת 9 אותיות";
				 }
				  if( conpassword.length!=9 ){
					  document.getElementById("tmpPass2").innerHTML ="הסיסמה בעלת 9 אותיות";
				  }
				  if (password!=conpassword)
				 { 
					  document.getElementById("tmpPass2").innerHTML = "הסיסמאות צריכות להיות דומות ";
					  document.getElementById("tmpPass").innerHTML = "הסיסמאות צריכות להיות דומות ";
				 }
				  if(password.length==9){
					  document.getElementById("tmpPass").innerHTML ="";
				  }
				  if(conpassword.length==9){
					  document.getElementById("tmpPass2").innerHTML ="";
				  }
				 
				  return false; 
		  }
		  
	 }
	function ValidateEmail(mail) 
	{
	 if (/\S+@\S+\.\S+/.test(mail))
	  {
	    return (true)
	  }
	
	    return (false)
	}
	</script>

</body>
</html>