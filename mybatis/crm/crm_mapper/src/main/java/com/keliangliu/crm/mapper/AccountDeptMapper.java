package com.keliangliu.crm.mapper;

import com.keliangliu.crm.entity.AccountDept;

import java.util.List;

/**
 * Created by lkl on 2017/7/18.
 */
public interface AccountDeptMapper {
    void saveAccountDept(AccountDept accountDept);

    void delByAccountId(Integer id);

    List<Integer> findByDeptId(Integer id);
}
