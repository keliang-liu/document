package com.keliangliu.crm.serviceImpl;

import com.keliangliu.crm.entity.Customer;
import com.keliangliu.crm.entity.Sales;
import com.keliangliu.crm.entity.SalesRecord;
import com.keliangliu.crm.mapper.CustomerMapper;
import com.keliangliu.crm.mapper.SalesMapper;
import com.keliangliu.crm.mapper.SalesRecordMapper;
import com.keliangliu.crm.service.SalesRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
public class SalesRecordServiceImpl implements SalesRecordService {

    @Autowired
    private SalesRecordMapper salesRecordMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private SalesMapper salesMapper;

    @Override
    public List<SalesRecord> findBySalesId(Integer id) {
        return salesRecordMapper.findBySalesId(id);
    }

    @Override
    @Transactional
    public void saveRecord(String content, Sales sales, Customer customer) {


        //添加record记录表
        SalesRecord salesRecord = new SalesRecord();
        salesRecord.setSalesId(sales.getId());
        salesRecord.setUpdateTime(new Date());
        salesRecord.setContent(content);

        //更改客户的最近联系日期,和销售机会的最近联系方式
        sales.setLastContactTime(new Date());


        customer.setUpdateTime(new Date());
        customer.setLastContactTime(new Date());


        salesRecordMapper.saveSalesRecord(salesRecord);
        salesMapper.editSales(sales);
        customerMapper.editCustomer(customer);
    }
}
