package com.service;

import java.util.List;

import com.entity.User;
import com.entity.condition.UserCondition;
import com.entity.page.Page;

/**
 * 用户管理业务接口
 * @author Administrator
 *
 */
public interface UserService {

	public User getUser(Integer id);
	
	public List<User> getUser(UserCondition userCondition, Page page);
	
	public int getUserTotal(UserCondition userCondition);
	
	public Integer addUser(User user);
	
	public void removeUser(String[] ids);
	
	public void modifyUser(User user);
	
	public User getUserByName(String name);
}
