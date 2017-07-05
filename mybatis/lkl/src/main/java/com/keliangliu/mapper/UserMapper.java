package com.keliangliu.mapper;

import java.util.List;

import com.keliangliu.entity.User;

public interface UserMapper {

	List<User> findLoadCompany();
	void save(User user);
}
