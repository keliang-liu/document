package com.keliangliu.crm.service;

import com.github.pagehelper.PageInfo;
import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Customer;
import com.keliangliu.crm.entity.Sales;

import java.util.List;
import java.util.Map;

public interface SalesService {
    List<String> findProgressList();

    void saveSales(Sales sales, Account account);

    PageInfo<Sales> findByParams(Map<String, Object> map);

    Sales findById(Integer id);

    void delById(Integer id);

    List<Sales> findByCustomerId(Integer id);

    void updateProgress(String progress,Integer salesId,Account account,Customer customer);
}
