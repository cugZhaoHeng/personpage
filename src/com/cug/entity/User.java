package com.cug.entity;

public class User {
	private Integer id;
	private String username;
	private String password;
	private String sex;
	private String birthday;
	private String email;
	private String tel;
	private String headImage;
	private String address;
	private String activeCode;
	private Integer activeState;
	private Integer removeState;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getHeadImage() {
		return headImage;
	}
	public void setHeadImage(String headImage) {
		this.headImage = headImage;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getActiveCode() {
		return activeCode;
	}
	public void setActiveCode(String activeCode) {
		this.activeCode = activeCode;
	}
	public Integer getActiveState() {
		return activeState;
	}
	public void setActiveState(Integer activeState) {
		this.activeState = activeState;
	}
	public Integer getRemoveState() {
		return removeState;
	}
	public void setRemoveState(Integer removeState) {
		this.removeState = removeState;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", sex=" + sex + ", birthday="
				+ birthday + ", email=" + email + ", tel=" + tel + ", headImage=" + headImage + ", address=" + address
				+ ", activeCode=" + activeCode + ", activeState=" + activeState + ", removeState=" + removeState + "]";
	}
	
	
	
}
