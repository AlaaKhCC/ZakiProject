/**
 * 
 */
package com.hajar.zaki.controller;

import com.hajar.zaki.dao.InsertImageDao;
import com.hajar.zaki.dao.ProductDAO;
import com.hajar.zaki.model.Product;

import utils.Category;

/**
 * @author Hajar Amara
 *
 */
public class MainTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
		Product prod= new Product("22","עוגות חג" ,"supplier@gmail.com",new Double(40),Category.SWEET,"עוגות חג ממולאות בתמרים");

		ProductDAO dao=new ProductDAO();
			dao.addObj(prod);
		System.out.println("test here "+ prod.getName());
		
		
				

	}

}
