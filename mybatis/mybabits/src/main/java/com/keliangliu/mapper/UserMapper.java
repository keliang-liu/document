package com.keliangliu.mapper;

import java.util.List;

import com.keliangliu.entity.User;

public interface UserMapper {
	List<User> findList();
	User findById(Integer id);
	void save(User user);
}
