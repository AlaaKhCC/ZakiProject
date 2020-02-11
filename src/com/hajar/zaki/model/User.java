
/**
 * 
 */
package com.hajar.zaki.model;

import java.io.Serializable;
import java.sql.Date;
import java.util.Arrays;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.hajar.zaki.controller.MainMethods;

/**
 * @author Hajar Amara
 *
 */

@Entity
@Table(name= "User")
public class User  implements Serializable {
	/////////////////////////// Declare properties here 

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private String userMail;
	private String userName;
	private String userSurName;
	private String password;
	private String phoneNumber;
	private int cityid;
	private String cityName;
	private long addressID;
	private String gender;
	private byte [] image;
	public User(String userMail, String userName, String userSurName, String password, String phoneNumber, int cityid, String gender, byte[] image) {
		super();
		this.userMail = userMail;
		this.userName = userName;
		this.userSurName = userSurName;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.cityid = cityid;
		this.gender = gender;
		this.setImage(image);
	}

	public User(String userMail, String userName, String userSurName, String password, String phoneNumber, 
			long addressID) {
		super();
		this.userMail = userMail;
		this.userName = userName;
		this.userSurName = userSurName;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.addressID = addressID;
		this.setCity(MainMethods.getInstance().readCity(addressID));
	}

	//////////////////////////// Constructors
	///// full contsructor
	public User (String userName, String userSurName, String userMail, String password,String phoneNumber) {
		super();
		this.userName = userName;
		this.userSurName = userSurName;
		this.userMail = userMail;
		this.password = password;
		this.setPhoneNumber(phoneNumber);
	}
	

	
	//// A partial constructor
	public User(String userMail) {
		super();
		this.userMail=userMail;
	}
	
	/////// A partial constructor	
	public User( String mail, String userName) {
		super();
		this.userMail=mail;
		this.userName = userName;
	}
	/**
	 * 
	 */
	public User() {
		super();
	}

	/**
	 * @param mail
	 * @param name
	 * @param surName
	 * @param password2
	 * @param phone
	 * @param city2
	 * @param gender2
	 */
	public User(String mail, String name, String surName, String password2, 
			String phone, int cityid,String gender2) {
		super();
		this.userMail = mail;
		this.userName = name;
		this.userSurName = surName;
		this.password = password2;
		this.phoneNumber = phone;
		this.cityid = cityid;
		this.gender = gender2;
	}

	//////////////////////////// GETTERS && SETTERS /////////////////////
	@Id
    @Column(name = "email")
	public String getUserMail() {
		return userMail;
	}
	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserSurName() {
		return userSurName;
	}
	public void setUserSurName(String userSurName) {
		this.userSurName = userSurName;
	}

	public String getPassword() {
		return this.password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the phoneNumber
	 */
	public String getPhoneNumber() {
		return phoneNumber;
	}

	/**
	 * @param phoneNumber the phoneNumber to set
	 */
	public void setPhoneNumber(String phoneNumber) {
		if(phoneNumber==null || phoneNumber.equals(""))
			phoneNumber="0";
		this.phoneNumber = phoneNumber;
	}
	/**
	 * @return the city
	 */
	public int getCity() {
		return this.cityid;
	}

	/**
	 * @param city the city to set
	 */
	public void setCity(int cityid) {
		if(addressID > 0) {
			MainMethods.getInstance().readCityName(cityid);
		}
		this.cityid =0;
	}
	
	/**
	 * @return the addressID
	 */
	public long getAddressID() {
		
		return  addressID;
	}

	/**
	 * @param addressId2 the addressID to set
	 */
	public void setAddressID(long addressId2) {
		this.addressID = addressId2;
		if(addressID > 0) {
			setCity(MainMethods.getInstance().readCity(addressID));
		}
	}


	///////////////////////////////// Tostring 
	
	
	/**
	 * @return the gender
	 */
	public String getGender() {
		return gender;
	}

	

	/**
	 * @param gender the gender to set
	 */
	public void setGender(String gender) {
		this.gender = gender;
	}

	/**
	 * @return the image
	 */
	public byte [] getImage() {
		return image;
	}

	/**
	 * @param image the image to set
	 */
	public void setImage(byte [] image) {
		this.image = image;
	}
	
	
	@Override
	public String toString() {
		return "User [userMail=" + userMail + ", userName=" + userName + ", userSurName=" + userSurName + ", password="
				+ password + ", phoneNumber=" + phoneNumber + ", city=" + cityid + ", addressID=" + addressID
				+ ", gender=" + gender + ", image=" + Arrays.toString(image) + "]";
	}

	/**
	 * @return the cityName
	 */
	public String getCityName() {
		return MainMethods.getInstance().readCityName(cityid);
	}

	/**
	 * @param cityName the cityName to set
	 */
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}



}
