/**
 * 
 */
package com.hajar.zaki.model;

import java.io.Serializable;

/**
 * @author Hajar Amara
 *
 */
public class Supplier extends User implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*
	 * 
	 */
	private String foodDescription;
	public Supplier() {
		
	}
	
	public Supplier(String email) {
		super(email);
		User user = new User();
	}

	
	public Supplier(String email,String foodDescription) {
		super(email);
		this.foodDescription=foodDescription;
	}

	
	
	/////////////////////////// Getters and Setters
	
	

	/**
	 * @return the foodDescription
	 */
	public String getFoodDescription() {
		return foodDescription;
	}

	/**
	 * @param foodDescription the foodDescription to set
	 */
	public void setFoodDescription(String foodDescription) {
		this.foodDescription = foodDescription;
	}

	@Override
	public String toString() {
		return "Supplier [foodDescription=" + foodDescription + "]";
	}

	////////////////////////// tostring 
	
	

}
