package com.keliangliu.crm.service;

import com.keliangliu.crm.entity.Customer;
import com.keliangliu.crm.entity.Sales;
import com.keliangliu.crm.entity.SalesRecord;

import java.util.List;

public interface SalesRecordService {


    List<SalesRecord> findBySalesId(Integer id);

    void saveRecord(String content, Sales sales, Customer customer);
}
