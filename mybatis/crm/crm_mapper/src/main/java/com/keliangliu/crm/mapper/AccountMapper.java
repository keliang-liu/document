package com.keliangliu.crm.mapper;

import com.keliangliu.crm.entity.Account;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by lkl on 2017/7/17.
 */
public interface AccountMapper {

    List<Account> findAll();

    void saveAccount(Account account);

    Integer countByDeptId(@Param("id")Integer id);

    Integer countAll();

    List<Account> findByDeptId(@Param("id") Integer id);

    void delById(Integer id);

    Account findByMobile(String mobile);

    void update(Account account);


    Account findById(Integer accountId);
}
