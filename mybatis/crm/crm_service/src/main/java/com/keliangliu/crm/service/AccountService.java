package com.keliangliu.crm.service;

import com.keliangliu.crm.entity.Account;
import com.keliangliu.exception.ServiceException;

import java.util.List;

/**
 * Created by lkl on 2017/7/17.
 */
public interface AccountService {

    List<Account> findAll();

    void saveAccount(Account account, Integer[] deptId);

    Integer countByDeptId(Integer id);

    Integer countAll();

    List<Account> findByDeptId(Integer id);

    void delById(Integer id);

    Account login(String mobile, String password);

    void changePassword(String oldPassword, String password, Account account) throws ServiceException;

    Account findById(Integer accountId);
}
