package com.keliangliu.util;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {

	private static SqlSessionFactory sqlSessionFactory = builderFactory();

	private static SqlSessionFactory builderFactory() {
		Reader reader;
		try {
			reader = Resources.getResourceAsReader("mybatis.xml");
			SqlSessionFactoryBuilder sqlSessionFactoryBuilder = new SqlSessionFactoryBuilder();
			return sqlSessionFactoryBuilder.build(reader);
		} catch (IOException e) {
			throw new RuntimeException("配置文件有问题",e);
		}
	}
	
	public static SqlSessionFactory getSqlSessionFactory(){
		
		return sqlSessionFactory;
	}
	
	public static SqlSession getSqlSession(){
		return getSqlSessionFactory().openSession();
	}
	
}
