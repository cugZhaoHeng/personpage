package com.cug.dao;

import org.apache.ibatis.annotations.Param;

import com.cug.entity.User;

public interface UserDao {
	public User getUserById(@Param("id")String id);

	public User getUserByName(@Param("username")String username);

	public Integer addUser(User user);

	public Integer usernameIsRegistered(@Param("username")String username);

	public Integer emailIsRegistered(@Param("email")String email);

	public Integer active(@Param("username")String username, @Param("activeCode")String activeCode);

	public Integer updateUserInfo(User user);

	public Integer passwordIsTrue(@Param("id") String id, @Param("password") String password);

	public Integer updatePassword(@Param("id") String id, @Param("password") String password);
}
