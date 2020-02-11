/**
 * 
 */
package com.hajar.zaki.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.hajar.zaki.dao.UserDAO;
import com.hajar.zaki.model.User;

/**
 * @author Hajar Amara
 *
 */
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDAO userDao;

	/* (non-Javadoc)
	 * @see com.hajar.zaki.service.UserService#addUser(com.hajar.zaki.model.User)
	 */
	 @Override
	 @Transactional
	public void addUser(User user) {
		userDao.addUser(user);
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.service.UserService#getUser(long)
	 */
	@Override
	public User getUser(long id) {
		return userDao.getUser(id);
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.service.UserService#getAllOfUsers()
	 */
	@Override
	public List<User> getAllOfUsers() {
		return userDao.getAllOfUsers();
	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.service.UserService#deleteUser(long)
	 */
	@Override
	public void deleteUser(long id) {
		userDao.deleteUser(id);

	}

	/* (non-Javadoc)
	 * @see com.hajar.zaki.service.UserService#updateUser(com.hajar.zaki.model.User)
	 */
	@Override
	public User updateUser(User user) {
		return userDao.updateUser(user);
	}

}
