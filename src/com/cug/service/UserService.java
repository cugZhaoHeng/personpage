package com.cug.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cug.dao.UserDao;
import com.cug.entity.User;

@Service
public class UserService {
	@Resource
	UserDao userDao;
	public User getUserById(String id) {
		// TODO Auto-generated method stub
		return userDao.getUserById(id);
	}
	public User getUserByName(String username) {
		// TODO Auto-generated method stub
		return userDao.getUserByName(username);
	}
	public Integer addUser(User user) {
		// TODO Auto-generated method stub
		return userDao.addUser(user);
	}
	public boolean usernameIsRegistered(String username) {
		// TODO Auto-generated method stub
		return userDao.usernameIsRegistered(username) > 0;
	}
	public boolean emailIsRegistered(String email) {
		// TODO Auto-generated method stub
		return userDao.emailIsRegistered(email) > 0;
	}
	public boolean active(String username, String activeCode) {
		// TODO Auto-generated method stub
		return userDao.active(username, activeCode) > 0;
	}
	public boolean updateUserInfo(User user) {
		// TODO Auto-generated method stub
		return userDao.updateUserInfo(user) > 0;
	}
	public boolean passwordIsTrue(String id, String password) {
		// TODO Auto-generated method stub
		return userDao.passwordIsTrue(id, password) > 0;
	}
	public boolean updatePassword(String id, String password) {
		// TODO Auto-generated method stub
		return userDao.updatePassword(id, password) > 0;
	}

}
