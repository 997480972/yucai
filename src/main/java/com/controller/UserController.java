package com.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.SysMenu;
import com.entity.User;
import com.entity.condition.UserCondition;
import com.entity.page.DataGrid;
import com.entity.page.Json;
import com.entity.page.Page;
import com.service.SysMenuService;
import com.service.UserService;
import com.util.CaptchaUtil;
import com.util.DateUtil;

/**
 * <ul>
 * <li>系统用户 Controller</li>
 * <li>使用 RESTful 风格请求映射</li>
 * <li>POST   /user    添加用户</li>
 * <li>PUT    /user    查询所有用户</li>
 * <li>GET    /user/id 查询单个用户</li>
 * <li>DELETE /user/id 删除用户</li>
 * <ul>
 */
@RequestMapping("/sys")
@Controller
public class UserController {
	
	private static Logger logger = Logger.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private SysMenuService sysMenuService;
	/**
	 * 系统首页
	 * @return
	 */
	@RequestMapping("/toindex")
	public String toMain(){
		return "layout/main";
	}

	/**
	 * 用户管理页面
	 * @return
	 */
	@RequestMapping("/toUser")
	public String toUser(){
		return "sys/sysUser";
	}
	
	/**
	 * 新增用户页面
	 * @return
	 */
	@RequestMapping("/toAddUser")
	public String toAddUser(){
		return "sys/sysUser_add_dialog";
	}
	
	/**
	 * 编辑用户页面
	 * @return
	 */
	@RequestMapping("/toEditUser")
	public String toEditUser(){
		return "sys/sysUser_edit_dialog";
	}
	
	/**
	 * 获取登陆验证码
	 * @param response
	 * @param session
	 */
	@RequestMapping("/verify")
	public void verify(HttpServletResponse response, HttpSession session){
		logger.info("获取验证码..." + session.getAttribute("captcha"));
		try {
			CaptchaUtil.create(response);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 注销
	 */
	@ResponseBody
	@RequestMapping("/logout")
	public Json logout(HttpSession session){
		if(session != null){
			session.invalidate();
		}
		
		Json json = new Json();
		json.setSuccess(true);
		json.setContent("注销成功！");
		return json;
	}
	
	/**
	 * 登录
	 * @param user
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/login")
	public Json login(User loginUser, HttpSession session, 
			@RequestParam("captcha") String captcha){
		Json json = new Json();
		if(CaptchaUtil.verify(captcha)){
			loginUser.setPassword(DigestUtils.md5DigestAsHex(loginUser.getPassword().getBytes()));
			User user = userService.getUserByName(loginUser.getName());
			if(user != null && user.getPassword().equals(loginUser.getPassword())){
				logger.info(user.getName() + " 登陆系统.");
				json.setContent("登录成功!");
				json.setSuccess(true);
				//登陆成功,将用户加入Session.
				session.setAttribute("user", user);
			}else{
				json.setContent("登陆失败: 用户名或密码错误!");
				json.setSuccess(false);
			}
		}else{
			json.setContent("登陆失败: 验证码错误!");
			json.setSuccess(false);
		}
		return json;
	}
	
	/**
	 * 获取系统功能菜单
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/menus")
	public List<SysMenu> getSysMenus(){
		logger.info("加载系统菜单...");
		
		List<SysMenu> menus = new ArrayList<>();
		List<SysMenu> sysMenus = sysMenuService.getSysMenus();
		for(SysMenu sysMenu : sysMenus){
			SysMenu menu = new SysMenu();
			BeanUtils.copyProperties(sysMenu, menu);
			menus.add(menu);
		}
		return menus;
	}
	
	@RequestMapping(value="/user/{id}", method=RequestMethod.GET)
	public String getSysUserProfile(@PathVariable("id") Integer id){
		logger.info("查看个人资料: " + id);
		return "sys/sysUser_profile";
	}
	
	/**
	 * 查询系统所有用户
	 * @param page
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user", method=RequestMethod.GET)
	public DataGrid<User> getSysUsers(UserCondition userCondition, Page page){
		logger.info("查询系统用户..." + userCondition);
		
		DataGrid<User> dataGrid = new DataGrid<>();
		dataGrid.setRows(userService.getUser(userCondition, page));
		dataGrid.setTotal(userService.getUserTotal(userCondition));
		return dataGrid;
	}
	
	/**
	 * 添加系统用户
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user", method=RequestMethod.POST)
	public Json addSysUser(User user){
		logger.info("新增用户: " + user);
		
		//对密码进行MD5加密
		String md5Pwd = DigestUtils.md5DigestAsHex(user.getPassword().getBytes());
		user.setPassword(md5Pwd);
		user.setCreateTime(DateUtil.getCurrentDate("yyyy-MM-dd hh:mm:ss"));
		Integer key = userService.addUser(user);
		
		Json json = new Json();
		json.setSuccess(true);
		json.setContent("添加用户成功!");
		user.setId(key);
		user.setModifyTime(DateUtil.getCurrentDate("yyyy-MM-dd hh:mm:ss"));
		json.setObject(user);
		
		return json;
	}
	
	/**
	 * 修改用户
	 * @param sysUser
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user", method=RequestMethod.PUT)
	public Json modifyUser(User user){
		logger.info("修改用户: " + user);
		userService.modifyUser(user);
		
		Json json = new Json();
		json.setSuccess(true);
		json.setContent("修改用户成功!");
		return json;
	}
	
	/**
	 * 删除用户
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/user/{ids}", method=RequestMethod.DELETE)
	public Json removeSysUser(@PathVariable("ids") String ids){
		logger.info("删除用户: " + ids);
		userService.removeUser(ids.split(","));
		
		Json json = new Json();
		json.setSuccess(true);
		json.setContent("删除用户成功!");
		return json;
	}
}
