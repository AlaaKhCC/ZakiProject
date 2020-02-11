

// Name can't be blank
$('#form-username').on('input', function() {
	var input=$(this);
	var is_name=input.val();
	if(is_name){input.removeClass("invalid").addClass("valid");}
	else{input.removeClass("valid").addClass("invalid");}
});

//Email must be an email
$('#form-mail').on('input', function() {
	var input=$(this);
	var re = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
	var is_email=re.test(input.val());
	if(is_email){input.removeClass("invalid").addClass("valid");}
	else{input.removeClass("valid").addClass("invalid");}
});

//password must be an email
$('#contact_pass').on('input', function() {
	var pswd=$(this).val();
	if ( pswd.length != 9 ) {
	    $('#length').removeClass('valid').addClass('invalid');
	} else {
	    $('#length').removeClass('invalid').addClass('valid');
	}
	//validate letter
	if ( pswd.match(/[A-z]/) ) {
	    $('#letter').removeClass('invalid').addClass('valid');
	} else {
	    $('#letter').removeClass('valid').addClass('invalid');
	}

	//validate capital letter
	if ( pswd.match(/[A-Z]/) ) {
	    $('#capital').removeClass('invalid').addClass('valid');
	} else {
	    $('#capital').removeClass('valid').addClass('invalid');
	}

	//validate number
	if ( pswd.match(/\d/) ) {
	    $('#number').removeClass('invalid').addClass('valid');
	} else {
	    $('#number').removeClass('valid').addClass('invalid');
	}
});

//password must be an email
$('#contact_pass2').on('input', function() {
	var input=$(this).val();
	if ( input.length != 9 ) {
	    $('#length').removeClass('valid').addClass('invalid');
	} else {
	    $('#length').removeClass('invalid').addClass('valid');
	}
	//validate letter
	if ( pswd.match(/[A-z]/) ) {
	    $('#letter').removeClass('invalid').addClass('valid');
	} else {
	    $('#letter').removeClass('valid').addClass('invalid');
	}

	//validate capital letter
	if ( pswd.match(/[A-Z]/) ) {
	    $('#capital').removeClass('invalid').addClass('valid');
	} else {
	    $('#capital').removeClass('valid').addClass('invalid');
	}

	//validate number
	if ( pswd.match(/\d/) ) {
	    $('#number').removeClass('invalid').addClass('valid');
	} else {
	    $('#number').removeClass('valid').addClass('invalid');
	}
});


/*(function ($){ 
	$('.validate-input .input100').each(function(){
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
		  
	 })
	function ValidateEmail(mail) 
	{
	 if (/\S+@\S+\.\S+/.test(mail))
	  {
	    return (true)
	  }
	
	    return (false)
	}
	
	
	
})(jQuery);
	*/