package com.keliangliu.crm.mapper;

import com.keliangliu.crm.entity.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by lkl on 2017/7/19.
 */
public interface CustomerMapper {
    void save(Customer customer);

    Customer findByTel(String tel);

    List<Customer> findByParams(Map<String, Object> queryParams);


    Customer findById(Integer id);

    void editCustomer(Customer customer);

    List<Customer> findByAccountId(Integer id);

    List<Customer> findPublicByParams(Map<String, Object> queryParams);

    void saveList(@Param("customerList") List<Customer> customerList);
}
