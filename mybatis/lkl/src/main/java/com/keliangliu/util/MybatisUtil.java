package com.keliangliu.util;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {

	private static SqlSessionFactory sqlSessionFactory = buildFactory();

	private static SqlSessionFactory buildFactory() {
		
		try {
			Reader reader = Resources.getResourceAsReader("mybatis.xml");
			SqlSessionFactoryBuilder sqlSessionFactoryBuilder = new  SqlSessionFactoryBuilder();
			sqlSessionFactory = sqlSessionFactoryBuilder.build(reader);
			return sqlSessionFactory;
			
		} catch (IOException e) {
			throw new RuntimeException("文件不存在",e);
		}
		
	}
	
	public static SqlSessionFactory getSqlSessionFactory(){
		return sqlSessionFactory;
	}
	
	
	public static SqlSession getSqlSession(){
		return sqlSessionFactory.openSession();
	}
	
}
