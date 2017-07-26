package com.keliangliu.crm.serviceImpl;

import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.AccountDept;
import com.keliangliu.crm.mapper.AccountDeptMapper;
import com.keliangliu.crm.mapper.AccountMapper;
import com.keliangliu.crm.service.AccountService;
import com.keliangliu.exception.ServiceException;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * Created by lkl on 2017/7/17.
 */
@Service
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountMapper accountMapper;
    @Autowired
    private AccountDeptMapper accountDeptMapper;

    @Value("${password.salt}")
    private String salt;


    @Override
    public List<Account> findAll() {
        return accountMapper.findAll();
    }

    @Override
    @Transactional
    public void saveAccount(Account account, Integer[] deptId) {
        account.setCreateTime(new Date());
        account.setPassword(DigestUtils.md5Hex(account.getPassword() + salt));
        accountMapper.saveAccount(account);
        AccountDept accountDept = new AccountDept();
        for(Integer id : deptId ) {
            accountDept.setAccountId(account.getId());
            accountDept.setDeptId(id);
            accountDeptMapper.saveAccountDept(accountDept);
        }

    }

    @Override
    public Integer countByDeptId(Integer id) {
        if(new Integer(1000).equals(id)) {
            id = null;
        }
        return  accountMapper.countByDeptId(id);
    }

    @Override
    public Integer countAll() {
        return accountMapper.countAll();
    }

    @Override
    public List<Account> findByDeptId(Integer id) {

        if(new Integer(1000).equals(id)) {
            id = null;
        }

        return accountMapper.findByDeptId(id);

    }

    @Override
    @Transactional
    public void delById(Integer id) {
        //首先删除account表的值
        accountMapper.delById(id);
        //删除account_dept表的值
        accountDeptMapper.delByAccountId(id);

    }

    @Override
    public Account login(String mobile, String password) {
        Account account = accountMapper.findByMobile(mobile);
        if(account != null) {
            if(DigestUtils.md5Hex(password + salt ).equals(account.getPassword())) {
                return account;
            }else{
                throw new ServiceException("账号密码错误");
            }
        }else {
            throw new ServiceException("账号或者密码错误");
        }

    }

    /**
     * 修改员工的密码
     *
     * @param oldPassword 原始密码
     * @param password 新密码
     * @param account 员工的对象
     * @throws ServiceException 如果原始密码错误抛出该异常
     */
    @Override
    public void changePassword(String oldPassword, String password, Account account) throws ServiceException  {

        if(account != null) {
            String currentPassword = account.getPassword();

            if(DigestUtils.md5Hex(oldPassword + salt).equals(currentPassword)) {
                account.setPassword(DigestUtils.md5Hex(password + salt));
                accountMapper.update(account);
            }else {
                throw new ServiceException("原始密码输入错误");
            }
        }else {
            throw new ServiceException("账户过期请重新登录");
        }


    }

    @Override
    public Account findById(Integer accountId) {
        return accountMapper.findById(accountId);
    }

}
