package com.cug.test;


import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.cug.entity.User;

public class Main {
	public static <T> void main(String[] args) {
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		User user = (User)context.getBean(User.class);
		user.setUsername("zhangsan");
		System.out.println(user.getUsername());
		JdbcTemplate jdbc = context.getBean(JdbcTemplate.class);
		String sql="select * from user where id=?";
		
		RowMapper<User> rowMapper=new BeanPropertyRowMapper<User>(User.class);
		User user1= jdbc.queryForObject(sql, rowMapper,1);
		System.out.println(user1.getPassword());

	}
}
