package com.entity;


public class User {
	private Integer id;
	private String account; //帐号
	private String password; //密码
	private String name; //名字
	private String gender; //性别   M：男，F：女
	private String createTime; //创建时间
	private String modifyTime; //最后修改时间
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", account=" + account + ", password="
				+ password + ", name=" + name + ", gender=" + gender
				+ ", createTime=" + createTime + ", modifyTime=" + modifyTime
				+ "]";
	}
}
