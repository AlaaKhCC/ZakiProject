/**
 * 
 */
package com.hajar.zaki.model;

import java.util.Date;
import java.io.Serializable;
import java.sql.Timestamp;

/**
 * @author Hajar Amara
 *
 */
public class Message  implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int msgNum;
	private String mail1;
	private String mail2;
	private String content;
	private Timestamp time;
	
	public Message() {
		
	}
	public Message(int msgNum, String mail1, String mail2, String content, Timestamp time) {
		super();
		this.msgNum = msgNum;
		this.mail1 = mail1;
		this.mail2 = mail2;
		this.content = content;
		this.setTime(time);
	}
	
	public Message( String mail1, String mail2, String content, Timestamp time) {
		super();
		this.mail1 = mail1;
		this.mail2 = mail2;
		this.content = content;
		this.setTime(time);
	}
	
	public int getMsgNum() {
		return msgNum;
	}
	public void setMsgNum(int msgNum) {
		this.msgNum = msgNum;
	}
	public String getMail1() {
		return mail1;
	}
	public void setMail1(String mail1) {
		this.mail1 = mail1;
	}
	public String getMail2() {
		return mail2;
	}
	public void setMail2(String mail2) {
		this.mail2 = mail2;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		Date date = new Date();
		time = new Timestamp(date.getTime());
		this.time = time;
	}
	
	
	
}
