package com.keliangliu.crm.serviceImpl;

import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Dept;
import com.keliangliu.crm.mapper.AccountDeptMapper;
import com.keliangliu.crm.mapper.AccountMapper;
import com.keliangliu.crm.mapper.DeptMapper;
import com.keliangliu.crm.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by lkl on 2017/7/17.
 */
@Service
public class DeptServiceImpl implements DeptService {

    @Autowired
    private DeptMapper deptMapper;
    @Autowired
    private AccountDeptMapper accountDeptMapper;

    @Override
    public List<Dept> findAll() {
        return deptMapper.findAll();

    }

    @Override
    public void save(Dept dept) {
        deptMapper.save(dept);
    }

    @Override
    public void delDeptBytId(Integer id) {
        //首先判断部门有没有人
        List<Integer> accountIdList = accountDeptMapper.findByDeptId(id);

        if(accountIdList.size() >0) {
            //如果有人
            throw new RuntimeException("部门里面还有人，不能删除");
        }else {
            //如果没有人了
            deptMapper.delDeptById(id);
        }



    }
}
