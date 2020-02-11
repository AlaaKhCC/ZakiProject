/**
 * 
 */
package com.hajar.zaki.model;

/**
 * @author Hajar Amara
 *
 */
public class ProductCustomer {
	
	private String prodId;
	private String mail_Customer;
	private int like;
	private int rate;
	private String comment;
	

	public ProductCustomer(String prodId, String mail_Customer, int like, int rate, String comment) {
		super();
		this.prodId = prodId;
		this.mail_Customer = mail_Customer;
		this.like = like;
		this.rate = rate;
		this.comment= comment;
	}

	public ProductCustomer(String prodId, String mail_Customer, int like) {
		super();
		this.prodId = prodId;
		this.mail_Customer = mail_Customer;
		setLike(like);
	}
	
	public ProductCustomer() {
		super();
	}

	@Override
	public String toString() {
		return "ProductCustomer [prodId=" + prodId + ", mail_Customer=" + mail_Customer + ", like=" + like + "]";
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getMail_Customer() {
		return mail_Customer;
	}

	public void setMail_Customer(String mail_Customer) {
		this.mail_Customer = mail_Customer;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		if(like >0)
		this.like = like;
		like=0;
	}
	
	public int getRate() {
		return rate;
	}

	public void setRate(int rate) {
		this.rate = rate;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}


	

}
