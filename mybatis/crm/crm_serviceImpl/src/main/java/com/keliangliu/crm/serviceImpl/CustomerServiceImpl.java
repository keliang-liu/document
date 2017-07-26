package com.keliangliu.crm.serviceImpl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Customer;
import com.keliangliu.crm.mapper.CustomerMapper;
import com.keliangliu.crm.service.CustomerService;
import com.keliangliu.exception.ServiceException;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by lkl on 2017/7/19.
 */
@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerMapper customerMapper;

    @Value("#{'${customer.trade}'.split(',')}")
    private List<String> tradeList;

    @Value("#{'${customer.source}'.split(',')}")
    private List<String> sourceList;


    @Override
    public void save(Customer customer) {
        customer.setCreateTime(new Date());
        customerMapper.save(customer);

    }

    @Override
    public Customer findByTel(String tel) {

        return customerMapper.findByTel(tel);
    }

    @Override
    public PageInfo<Customer> findByParams(Map<String, Object> queryParams) {

        Integer pageNum = (Integer) queryParams.get("pageNum");
        PageHelper.startPage(pageNum,10);
        List<Customer> customerList = customerMapper.findByParams(queryParams);
        return  new PageInfo<>(customerList);

    }

    @Override
    public Customer findById(Integer id) {
        return customerMapper.findById(id);
    }


    @Override
    public List<String> findTradeList() {
        return tradeList;
    }

    @Override
    public List<String> findSourceList() {
        return sourceList;
    }

    @Override
    public void editCustomer(Customer customer) {
        customer.setUpdateTime(new Date());
        customerMapper.editCustomer(customer);
    }

    /**
     *
     * 转交用客户信息
     * @param customer 需要被转交的客户对象
     * @param account  当前用户对象
     * @param transferToAccount 需要转交到的用户对象
     */
    @Override
    public void transferCustomerToOther(Customer customer, Account account,Account transferToAccount) {
        //首先给设置修改信息
        customer.setReminder(account.getUserName() + "转交到" + transferToAccount.getUserName());
        //设置更新的时间
        customer.setUpdateTime(new Date());
        //把客户对应的用户进行修改
        customer.setAccountId(transferToAccount.getId());

        customerMapper.editCustomer(customer);

    }

    /**
     * 转交到公海
     * @param account 转交的客户的用户对象
     * @param customer 被转入到公海的客户对象
     */
    @Override
    public void transferCustomerToPublic(Account account, Customer customer) {

        customer.setReminder(account.getUserName() + "转入到公海");
        customer.setUpdateTime(new Date());
        customer.setAccountId(1);

        customerMapper.editCustomer(customer);

    }

    /**
     * 把客户的信息导成excel
     *
     * @param account
     * @param out
     */
    @Override
    public void exportExcel(Account account, OutputStream out) {

        List<Customer> customerList = customerMapper.findByAccountId(account.getId());
        Workbook book = new HSSFWorkbook();
        Sheet sheet = book.createSheet("客户信息");
        Row row = sheet.createRow(0);
        row.createCell(0).setCellValue("客户姓名");
        row.createCell(1).setCellValue("客户职位");
        row.createCell(2).setCellValue("客户级别");
        row.createCell(3).setCellValue("客户联系方式");
        row.createCell(4).setCellValue("更新日期");
        row.createCell(5).setCellValue("最后的联系日期");

        for(int i = 0; i< customerList.size(); i++) {
            Row r = sheet.createRow(i+1);
            r.createCell(0).setCellValue(customerList.get(i).getName());
            r.createCell(1).setCellValue(customerList.get(i).getPosition());
            r.createCell(2).setCellValue(customerList.get(i).getLevel());
            r.createCell(3).setCellValue(customerList.get(i).getTel());
            if(customerList.get(i).getUpdateTime() == null) {
                r.createCell(4).setCellValue("");
            }else {
                r.createCell(4).setCellValue(customerList.get(i).getUpdateTime());
            }

            if(customerList.get(i).getLastContactTime() == null) {
                r.createCell(5).setCellValue("");
            }else {
                r.createCell(5).setCellValue(customerList.get(i).getLastContactTime());
            }

        }

        try {
            book.write(out);
            out.flush();
            out.close();
        } catch (Exception e) {
            throw new ServiceException("导出excel失败");
        }


    }

    /**
     *
     * 查询公海客户
     * @param queryParams
     * @return
     */
    @Override
    public PageInfo<Customer> findPublicByParams(Map<String, Object> queryParams) {

        Integer pageNum = (Integer) queryParams.get("pageNum");

        PageHelper.startPage(pageNum,10);

        List<Customer> customerList = customerMapper.findPublicByParams(queryParams);

        return new PageInfo<>(customerList);

    }

    /**
     * 把公海客户变为当前对象的的客户
     * @param customer
     * @param account
     */
    @Override
    public void transferPublicToMy(Customer customer, Account account) {
        //首先把设置更新时间
        customer.setUpdateTime(new Date());
        //把里面的accountId变为当前用户的id
        customer.setAccountId(account.getId());
        //添加更改信息
        customer.setReminder(account.getUserName() +"从公海得到的客户");
        customerMapper.editCustomer(customer);
    }

    /**
     * 导入excel文件
     *
     * @param in
     */
    @Override
    public void importExcel(InputStream in,Account account) {

        List<Customer>  customerList = new ArrayList<>();

        try {
            Workbook workbook = new HSSFWorkbook(in);
            Sheet sheet = workbook.getSheetAt(0);

            int rows = sheet.getPhysicalNumberOfRows();
            for(int i = 2; i < rows ; i++) {
                Row row = sheet.getRow(i);
                Customer customer = new Customer();
                customer.setName(row.getCell(0).getStringCellValue());
                customer.setPosition(row.getCell(1).getStringCellValue());
                customer.setLevel(row.getCell(2).getStringCellValue());
                customer.setTel(row.getCell(3).getStringCellValue());
                customer.setAddress(row.getCell(4).getStringCellValue());
                customer.setAccountId(1);
                customer.setReminder("公海来源：" + account.getUserName());
                customerList.add(customer);
            }
            customerMapper.saveList(customerList);

        } catch (IOException e) {
           throw new ServiceException("导入Excel失败");
        }

    }

    @Override
    public List<Customer> findMyAll(Account account) {

        List<Customer> customerList =customerMapper.findByAccountId(account.getId());
        return customerList;
    }


}
