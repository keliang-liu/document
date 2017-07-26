package com.keliangliu.crm.mapper;

import com.keliangliu.crm.entity.Sales;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SalesMapper {

    void save(Sales sales);

    List<Sales> findAllByParams(Map<String, Object> map);

    Sales findById(@Param("id") Integer id);

    void delById(Integer id);

    void editSales(Sales sales);

    List<Sales> findByCustomerId(Integer customerId);
}
