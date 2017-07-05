package com.keliangliu.test;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.keliangliu.entity.User;
import com.keliangliu.mapper.UserMapper;
import com.keliangliu.util.MybatisUtil;

public class MybatisTest {
	
	private SqlSession sqlSession;
	private UserMapper userMapper;
	
	
	@Before
	public void before(){
		 sqlSession = MybatisUtil.getSqlSession();
	     userMapper = sqlSession.getMapper(UserMapper.class);
	}
	
	@After
	public void After(){
		sqlSession.close();
	}
	
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
	
	@Test
	public void update(){
	   User user = new User();
	   user.setName("小红");
	   user.setPassword("987");
	   user.setId(5);
	   userMapper.update(user);
	   sqlSession.commit();
	}

	@Test
	public void delById(){
		userMapper.delById(5);
		sqlSession.commit();
	}



}
