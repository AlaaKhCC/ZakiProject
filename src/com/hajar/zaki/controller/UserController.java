/**
 * 
 */
package com.hajar.zaki.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


/**
 * @author Hajar Amara
 *
 */
@CrossOrigin("*")
@RestController
@Controller
public class UserController {

//	@Autowired
//	private UserService userService;
//	
//	// Get all users
//	@GetMapping("/api/user")
//	public ResponseEntity<List<User>> listOfUsers(){
//		List<User> users=userService.listOfUsers();
//		return ResponseEntity.ok().body(users);
//	}
	
	@GetMapping("/")
	public String showUserLogIn() {
		return "index";
	}
}
