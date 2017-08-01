package com.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.entity.User;
import com.entity.condition.UserCondition;

public interface UserMapper {

	@Insert("insert into user(account,password,name,gender,modify_time) values(#{account},#{password},#{name},#{gender},#{modifyTime})")
	//@Options(useGeneratedKeys = true)
	public void save(User user);
	
	public void delete(String[] ids);
	
	@Update("update user set name = #{name}, password = #{password}, modify_time = #{modifyTime} where id = #{id}")
	public void update(User user);
	
	@Select("select * from user where id = #{id}")
	@Results(@Result(property="createTime", column="create_time"))
	public User getById(Integer id);
	
	@Select("select * from user where name = #{name}")
	@Results(@Result(property="createTime", column="create_time"))
	public User getByName(String name);
	
	public List<User> getList(Map<String, Object> map);
	
	public Integer getTotal(UserCondition userCondition);
	
}
