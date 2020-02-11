/**
 * 
 */
package com.hajar.zaki.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author Hajar Amara
 *
 */
@Entity
@Table(name="orderDetails")
public class OrderDetails implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	///////////////////// Declare Properties
	private int numberOrder;
	private Date orderDate;
	private Date requireDate;
	private Double price;
	private String description;
	private Double discount;
	private String status;
	
	
	public OrderDetails() {
		
	}
	
	
	public OrderDetails(int numberOrder, Date orderDate, Date requireDate, Double price, String description,
			             Double discount, String status) {
		super();
		this.numberOrder = numberOrder;
		this.orderDate = orderDate;
		this.requireDate = requireDate;
		this.price = price;
		this.description = description;
		this.discount = discount;
		this.status = status;
	}


	public int getNumberOrder() {
		return numberOrder;
	}


	public void setNumberOrder(int numberOrder) {
		this.numberOrder = numberOrder;
	}


	public Date getOrderDate() {
		return orderDate;
	}


	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}


	public Date getRequireDate() {
		return requireDate;
	}


	public void setRequireDate(Date requireDate) {
		this.requireDate = requireDate;
	}


	public Double getPrice() {
		return price;
	}


	public void setPrice(Double price) {
		this.price = price;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Double getDiscount() {
		return discount;
	}


	public void setDiscount(Double discount) {
		this.discount = discount;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}

}