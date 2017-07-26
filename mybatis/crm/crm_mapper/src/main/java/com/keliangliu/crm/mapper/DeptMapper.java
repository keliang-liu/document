package com.keliangliu.crm.mapper;

import com.keliangliu.crm.entity.Dept;

import java.util.List;

/**
 * Created by lkl on 2017/7/17.
 */
public interface DeptMapper {

    List<Dept> findAll();

    void save(Dept dept);


    void delDeptById(Integer id);


}
