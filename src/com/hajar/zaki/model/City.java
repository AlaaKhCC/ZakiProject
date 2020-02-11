/**
 * 
 */
package com.hajar.zaki.model;

import java.io.Serializable;

/**
 * @author Hajar Amara
 *
 */
public class City implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int cityID;
	private int country_id;
	private String cityName;
//	private String stateRegion;
	
	public City(int cityID, int country_id, String cityName) {
		super();
		this.cityID = cityID;
		this.country_id = country_id;
		this.cityName = cityName;
	}

	/**
	 * 
	 */
	public City() {
		// TODO Auto-generated constructor stub
	}

	public int getCityID() {
		return cityID;
	}

	public void setCityID(int cityID) {
		this.cityID = cityID;
	}

	public int getCountry_id() {
		return country_id;
	}

	public void setCountry_id(int country_id) {
		this.country_id = country_id;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	
	
	
	

}
