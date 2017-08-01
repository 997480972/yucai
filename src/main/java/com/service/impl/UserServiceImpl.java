package com.service.impl;

import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.UserMapper;
import com.entity.User;
import com.entity.condition.UserCondition;
import com.entity.page.Page;
import com.service.UserService;

/**
 * 用户管理业务实现类
 * @author Administrator
 *
 */
@Transactional
@Service
public class UserServiceImpl implements UserService {
	
	private static Logger logger = Logger.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserMapper userMapper;

	@Override
	public User getUser(Integer id) {
		return userMapper.getById(id);
	}

	@Override
	public List<User> getUser(UserCondition userCondition, Page page) {
		Map<String, Object> map = new HashMap<>();
		if(userCondition != null){
			map.put("name", userCondition.getName());
			map.put("minCreateDateTime", userCondition.getMinCreateTime());
			map.put("maxCreateDateTime", userCondition.getMaxCreateTime());
		}
		map.put("page", page.getPage());
		map.put("rows", page.getRows());
		map.put("sort", page.getSort());
		map.put("order", page.getOrder());
		
		return userMapper.getList(map);
	}

	@Override
	public int getUserTotal(UserCondition userCondition) {
		return userMapper.getTotal(userCondition);
	}

	@Override
	public Integer addUser(User user) {
		userMapper.save(user);
		//获取插入返回的主键值
		logger.info("addSysUser key: " + user.getId());
		return  user.getId();
	}

	@Override
	public void removeUser(String[] ids) {
		userMapper.delete(ids);
	}

	@Override
	public void modifyUser(User user) {
		userMapper.update(user);
	}

	@Override
	public User getUserByName(String name) {
		return userMapper.getByName(name);
	}

}
