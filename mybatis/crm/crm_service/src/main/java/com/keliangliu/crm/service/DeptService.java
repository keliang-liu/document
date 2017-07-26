package com.keliangliu.crm.service;

import com.keliangliu.crm.entity.Dept;

import java.util.List;

/**
 * Created by lkl on 2017/7/17.
 */
public interface DeptService {

    List<Dept> findAll();

    void save(Dept dept);

    void delDeptBytId(Integer id);
}
