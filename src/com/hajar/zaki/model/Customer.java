/**
 * 
 */
package com.hajar.zaki.model;

import java.io.Serializable;

/**
 * @author Hajar Amara
 *
 */
public class Customer extends User implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;



	/**
	 * @param email
	 */
	public Customer(String email) {
		super(email);
		// TODO Auto-generated constructor stub
	}

	
	
	///////////////////////////// Getters and Setters
	
	//////////////////////////// tostring 
	
	@Override
	public String toString() {
		return "Customer [getUserName()=" + getUserName() + ", getUserSurName()="
				+ getUserSurName() + ", getUserMail()=" + getUserMail() + ", getPassword()=" + getPassword()
				+ ", toString()=" + super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ "]";
	}
	

}
