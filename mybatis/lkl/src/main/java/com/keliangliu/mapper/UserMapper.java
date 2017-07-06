package com.keliangliu.mapper;

import java.util.List;

import com.keliangliu.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {

	List<User> findLoadCompany();
	void save(User user);
	void update(User user);
	void delById(Integer id);
	List<User> findByUserNameAndPassword(@Param("userName") String userName,@Param("pas") String password);
    void deleteByIds(List<Integer> idList);
}
