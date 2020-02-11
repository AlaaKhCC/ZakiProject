/**
 * 
 */
package com.hajar.zaki.model;


import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import utils.Category;

/**
 * @author Hajar Amara
 *
 */
@Entity
@Table(name="Product")
public class Product implements Serializable {

   /////////////////////////// Declare properties here 
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String prodID;
	private String supID;
	private String name;/// add to db 
	private double piece_price;
	private Category category;
	private String description;
   /////////////////////////// Constructors
	/*
	 * full constructor
	 */
	 public Product(String prodID, String supID, String name, double piece_price,Category category,String Description) {
			super();
			this.prodID = prodID;
			this.supID = supID;
			this.name = name;
			this.piece_price = piece_price;
			this.setCategory(category);
			this.setDescription(Description);
			
			
		}
	
	
	/*
	 * partial constructor
	 */
	public Product(String prodID, String supID) {
		super();
		this.prodID = prodID;
		this.supID = supID;
		this.setSupID(supID);
	}

/**
	 * 
	 */
	public Product() {
		// TODO Auto-generated constructor stub
	}


	//////////////// GETTERS AND SETTERS
	@Id
    @Column(name = "Product_ID")
    @GeneratedValue
	public String getProdID() {
		return prodID;
	}

	public void setProdID(String prodID) {
		this.prodID = prodID;
	}

	public String getSupID() {
		return supID;
	}

	public void setSupID(String supID) {
		this.supID = supID;
	}

	public String getName() {
		return name;
	}

	

	public void setName(String name) {
		this.name = name;
	}
	

	public double getPiece_price() {
		return piece_price;
	}


	public void setPiece_price(double piece_price) {
		this.piece_price = piece_price;
	}

	/**
	 * @return the category
	 */
	public Category getCategory() {
		return category;
	}


	/**
	 * @param category the category to set
	 */
	public void setCategory(Category category) {
		this.category = category;
	}

	///////////////// Equals 


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((prodID == null) ? 0 : prodID.hashCode());
		result = prime * result + ((supID == null) ? 0 : supID.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Product other = (Product) obj;
		if (prodID == null) {
			if (other.prodID != null)
				return false;
		} else if (!prodID.equals(other.prodID))
			return false;
		if (supID == null) {
			if (other.supID != null)
				return false;
		} else if (!supID.equals(other.supID))
			return false;
		return true;
	}


	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}


	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		
		if(description!=null &&  description.equals("")) {
			description+=" "+this.getName()+" a tasty "+ this.getCategory();
		}
		if(description!=null ) {
			this.description = description;
		}
	}


	
	
	///////////////// Tostring 


	@Override
	public String toString() {
		return "Product [prodID=" + prodID + ", supID=" + supID + ", name=" + name + ", piece_price=" + piece_price
				+ ", category=" + category + ", description=" + description + "]";
	}

	
	
	

	

}
