/**
 * 
 */
package com.hajar.zaki.controller;


import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;

/**
 * @author Hajar Amara
 *
 */
public class WhatsupMsgRequest {

	    public static final String ACCOUNT_SID = "AC33788bb97d051a4c53499e60dfa1e163";
	    public static final String AUTH_TOKEN = "your_auth_token";

	    public static void main(String[] args) {
	        Twilio.init(ACCOUNT_SID, AUTH_TOKEN);
	        Message message = Message.creator(
	                new com.twilio.type.PhoneNumber("whatsapp:+15005550006"),
	                new com.twilio.type.PhoneNumber("whatsapp:+14155238886"),
	                "Hello there!")
	            .create();

	        System.out.println(message.getSid());
	    }

}
