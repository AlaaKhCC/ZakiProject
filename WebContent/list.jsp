<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*, com.hajar.zaki.dao.UserDAOImpl,com.hajar.zaki.dao.ProductDAO"%>

 <%
  
     
	   ArrayList<String> listofnames=new ArrayList<String>();
	   ProductDAO proddao= new  ProductDAO();
	   listofnames.addAll(proddao.getNamesOfProducts());		
		  

    //jQuery related start
       String query = (String)request.getParameter("q");

       int cnt=1;
       for(String str : listofnames){
    	   System.out.print(str+" into list jsp ");
    	   
    	   if(str.toUpperCase().startsWith(query.toUpperCase()))
           {
              out.print(str+"\n");
              if(cnt>=5)// 5=How many results have to show while we are typing(auto suggestions)
              break;
              cnt++;
            }
       }
   

%>