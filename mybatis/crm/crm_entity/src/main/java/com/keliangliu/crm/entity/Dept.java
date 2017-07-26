package com.keliangliu.crm.entity;

import java.io.Serializable;

/**
 * Created by lkl on 2017/7/17.
 */
public class Dept implements Serializable{

    private static final long serialVersionUID = 8784242554624592209L;
    private Integer id;
    private String deptName;
    private Integer pId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public Integer getpId() {
        return pId;
    }

    public void setpId(Integer pId) {
        this.pId = pId;
    }
}
