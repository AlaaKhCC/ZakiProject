/**
 * 
 */
package com.hajar.zaki.servlets;

import java.io.IOException;
import java.io.Serializable;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.hajar.zaki.dao.CityDAO;
import com.hajar.zaki.model.City;

/**
 * @author Hajar Amara
 *
 */
/// @SuppressWarnings("serial")
/// @WebServlet("/list")

@SuppressWarnings("serial")
public class AddressServlet extends HttpServlet {
	
	public AddressServlet() {
		System.out.println("constructor into address servlet ");
	}

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			  throws ServletException, IOException {
		System.out.println("test from get request ");
		listCity(request, response);		
		System.out.println("test after  get request ");

    }
    
    private void listCity(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	   CityDAO dao = new CityDAO();
   		   System.out.println("test test address test ");
           List<City> listCity ;
   		try {
   				listCity = dao.getAllOfObjects();
   				request.setAttribute("listCity", listCity);				
   		        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
   		        dispatcher.forward(request, response);
   		} catch (SQLException e) {
   			// TODO Auto-generated catch block
   			e.printStackTrace();
   		}
    	
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int cityId = Integer.parseInt(request.getParameter("city"));
     
        request.setAttribute("selectedCatId", cityId);
     
        listCity(request, response);
    }
	
}
