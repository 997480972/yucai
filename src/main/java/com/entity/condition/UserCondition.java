package com.entity.condition;



/**
 * 用户查询条件模型
 * @author Administrator
 */
public class UserCondition {

	private String name;
	private String gender;
	
	private String minCreateTime;
	private String maxCreateTime;
	
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
	public String getMinCreateTime() {
		return minCreateTime;
	}
	public void setMinCreateTime(String minCreateTime) {
		this.minCreateTime = minCreateTime;
	}
	public String getMaxCreateTime() {
		return maxCreateTime;
	}
	public void setMaxCreateTime(String maxCreateTime) {
		this.maxCreateTime = maxCreateTime;
	}
	@Override
	public String toString() {
		return "UserCondition [name=" + name + ", gender=" + gender
				+ ", minCreateTime=" + minCreateTime + ", maxCreateTime="
				+ maxCreateTime + "]";
	}
	
}
