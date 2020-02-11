/**
 * 
 */
package com.hajar.zaki.model;

import javax.persistence.Entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
 

/**
 * @author Hajar Amara
 *
 */

@Entity
@Table(name = "Address")
public class AddressClass implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/////////////////////////// Declare properties here 
	private int addressId;
	private int cityId;
	private String postalcode;
	
	//////Constructors
	public AddressClass() {
		super();
	}
	
	public AddressClass(int addressId, int cityId, String postalcode) {
		super();
		this.addressId = addressId;
		this.cityId = cityId;
		this.postalcode = postalcode;
	}
	
	////// 
	@Id
    @Column(name = "Address_ID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public int getCityId() {
		return cityId;
	}

	public void setCityId(int cityId) {
		this.cityId = cityId;
	}

	public String getPostalcode() {
		return postalcode;
	}

	public void setPostalcode(String postalcode) {
		this.postalcode = postalcode;
	}
	

	
}
