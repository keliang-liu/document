package com.keliangliu.crm.entity;

import java.io.Serializable;

/**
 * Created by lkl on 2017/7/18.
 */
public class AccountDept implements Serializable{

    private static final long serialVersionUID = -8260317386304365183L;

    private Integer accountId;

    private Integer deptId;

    public Integer getAccountId() {
        return accountId;
    }

    public void setAccountId(Integer accountId) {
        this.accountId = accountId;
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }
}
