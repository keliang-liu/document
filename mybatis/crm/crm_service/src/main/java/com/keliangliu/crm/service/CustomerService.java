package com.keliangliu.crm.service;

import com.github.pagehelper.PageInfo;
import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Customer;

import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

/**
 * Created by lkl on 2017/7/19.
 */
public interface CustomerService {
    void save(Customer customer);

    Customer findByTel(String tel);

    PageInfo<Customer> findByParams(Map<String, Object> queryParams);

    Customer findById(Integer id);

    List<String> findTradeList();

    List<String> findSourceList();

    void editCustomer(Customer customer);


    void transferCustomerToOther(Customer customer, Account currentAccount, Account transfeToAccount);

    void transferCustomerToPublic(Account account, Customer customer);

    void exportExcel(Account account, OutputStream out);

    PageInfo<Customer> findPublicByParams(Map<String, Object> queryParams);

    void transferPublicToMy(Customer customer, Account account);

    void importExcel( InputStream in,Account account);

    List<Customer> findMyAll(Account account);

}
