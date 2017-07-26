package com.keliangliu.crm.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Customer;
import com.keliangliu.crm.entity.Sales;
import com.keliangliu.crm.entity.SalesRecord;
import com.keliangliu.crm.mapper.CustomerMapper;
import com.keliangliu.crm.mapper.SalesMapper;
import com.keliangliu.crm.mapper.SalesRecordMapper;
import com.keliangliu.crm.service.SalesService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class SalesServiceImpl implements SalesService {

    @Value("#{'${sales.progress}'.split(',')}")
    private List<String> progressList;



    @Autowired
    private SalesMapper salesMapper;

    @Autowired
    private SalesRecordMapper salesRecordMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Override
    public List<String> findProgressList() {

        return progressList;
    }

    /**
     * 保存销售机会
     * @param sales
     * @param account
     */
    @Override
    @Transactional
    public void saveSales(Sales sales, Account account) {

        sales.setAccountId(account.getId());
        sales.setCreateTime(new Date());
        salesMapper.save(sales);

        if(StringUtils.isNotEmpty(sales.getRemark())) {

            SalesRecord salesRecord = new SalesRecord();

            salesRecord.setContent(sales.getRemark());
            salesRecord.setSalesId(sales.getId());
            salesRecord.setUpdateTime(new Date());

            sales.setLastContactTime(new Date());
            Customer customer = customerMapper.findById(sales.getCustomerId());
            customer.setLastContactTime(new Date());

            salesRecordMapper.saveSalesRecord(salesRecord);
            customerMapper.editCustomer(customer);
            salesMapper.editSales(sales);

        }

    }

    /**
     * 按照条件查询当前用户的销售机会
     * @param map
     */
    @Override
    public PageInfo<Sales> findByParams(Map<String, Object> map) {

        Integer pageNum = (Integer) map.get("pageNum");
        PageHelper.startPage(pageNum,10);
        List<Sales> salesList = salesMapper.findAllByParams(map);
        return new PageInfo<>(salesList);
    }

    @Override
    public Sales findById(Integer id) {

        return salesMapper.findById(id);
    }

    @Override
    public void delById(Integer id) {

        salesMapper.delById(id);

    }

    @Override
    public List<Sales> findByCustomerId(Integer id) {

        return salesMapper.findByCustomerId(id);
    }

    @Override
    @Transactional
    public void updateProgress(String progress, Integer salesId, Account account,Customer customer) {

        //首先把customer对象中的progress的进度修改，并且把最后联系时间和更新时间更改
        customer.setUpdateTime(new Date());
        customer.setLastContactTime(new Date());
        customerMapper.editCustomer(customer);

        //增加salesRecord记录
        SalesRecord salesRecord = new SalesRecord();
        salesRecord.setContent("将当前进度修改为[" + progress + "]");
        salesRecord.setSalesId(salesId);
        salesRecord.setUpdateTime(new Date());

        salesRecordMapper.saveSalesRecord(salesRecord);

        //修改sales对象的最后联系时间
        Sales sales = salesMapper.findById(salesId);
        sales.setLastContactTime(new Date());
        sales.setCurrentProgress(progress);
        salesMapper.editSales(sales);


    }


}
