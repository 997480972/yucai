package yucai;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.dao.UserMapper;
import com.entity.User;
import com.util.MD5;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class UserMapperTest {
	
	private Logger logger = Logger.getLogger(UserMapperTest.class);
	
	@Autowired
	private UserMapper userMapper;

	@Test
	public void testGetUser() {
		User user = userMapper.getById(1);
		logger.info(user);
	}
	@Test
	public void testGetUserByName() {
		User user = userMapper.getByName("test");
		logger.info(user);
	}
	@Test
	public void testGetList() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", "t");
		map.put("minCreateDateTime", "2017-05-22 15:55:00");
		List<User> list = userMapper.getList(map);
		logger.info(list);
	}
	@Test
	public void testSave() {
		User user = new User();
		user.setName("test");
		user.setPassword(MD5.hashToHexString("123"));
		userMapper.save(user);
		logger.info(user);
	}
}

