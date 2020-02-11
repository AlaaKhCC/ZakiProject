/**
 * 
 */
package com.hajar.zaki.model;

import java.io.Serializable;

/**
 * @author Hajar Amara
 *
 */
public class UserImage implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mail;
	private int picNum;
	private byte[] image;
	
	
	public UserImage() {
		super();
	}
	
	public UserImage(String mail, byte[] image) {
		super();
		this.mail = mail;
		this.image = image;
	}

	public UserImage(String mail, int picNum, byte[] image) {
		super();
		this.mail = mail;
		this.picNum = picNum;
		this.image = image;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public int getPicNum() {
		return picNum;
	}

	public void setPicNum(int picNum) {
		this.picNum = picNum;
	}

	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}
	
	

}
