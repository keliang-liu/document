package com.keliangliu.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import com.keliangliu.entity.User;
import com.keliangliu.mapper.UserMapper;
import com.keliangliu.util.MybatisUtil;

public class MybatisTest {

	@Test
	public void findLoadCompany(){
		
		SqlSession sqlSession = MybatisUtil.getSqlSession();
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		
		List<User> users = userMapper.findLoadCompany();
		for(User user : users) {
			System.out.println(user.getCom().getName());
		}
	
		sqlSession.close();
		
	}
	
	@Test
	public void save(){
		
		SqlSession sqlSession = MybatisUtil.getSqlSession();
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		User user = new User();
		user.setName("小明");
		user.setPassword("5554");
		user.setComId(2);
		
		userMapper.save(user);
		
		sqlSession.commit();
		sqlSession.close();
	}
	
	
 
}
