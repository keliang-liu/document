package com.keliangliu.test;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import com.keliangliu.entity.User;
import com.keliangliu.mapper.UserMapper;
import com.keliangliu.util.MybatisUtil;

public class MybatisTest {
	
	
	@Test
	public void start() throws Exception{
		
		SqlSession sqlSession = MybatisUtil.getSqlSession();
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		
		List<User> users = userMapper.findList();
		for(User user : users){
			System.out.println(user.getName());
		}
		
		
		
	}
	
	@Test
	public void save(){
 		SqlSession sqlSession = MybatisUtil.getSqlSession();
		UserMapper userMapper = sqlSession.getMapper(UserMapper.class);
		
		User user = new User();
		user.setName("tom");
		user.setPassword("123");
		//user.setId(10);
		userMapper.save(user);
		
		sqlSession.commit();
		sqlSession.close();
		
	}
	
}
