/**
 * 
 */
package com.hajar.zaki.model;

import java.io.Serializable;
import java.sql.Date;

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
@Table(name="Order")
public class Order  implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	///////////////////// Declare Properties
	private int orderNum;
	private String customerId;
	private String prodId;
	private Double quantity;
	
	////////////////////Constructors
	public Order(int orderNum, String customerId, String prodId, Double quantity) {
		super();
		this.orderNum = orderNum;
		this.customerId = customerId;
		this.prodId = prodId;
		this.quantity=quantity;
	}
	
	public Order( String customerId, String prodId,Double quantity) {
		super();
		this.customerId = customerId;
		this.prodId = prodId;
		this.quantity=quantity;
	}
	
	public Order() {
		super();
	}

	//////////////////// 	GETTERS AND SETERS 

	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getProdId() {
		return prodId;
	}
	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	/**
	 * @return the quantity
	 */
	public Double getQuantity() {
		return quantity;
	}

	/**
	 * @param quantity the quantity to set
	 */
	public void setQuantity(Double quantity) {
		if(quantity == null) {
			this.quantity=1.0;
		}else {
			this.quantity = quantity;
		}
	}
	
	

}