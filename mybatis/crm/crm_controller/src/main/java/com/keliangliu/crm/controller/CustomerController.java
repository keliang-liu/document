package com.keliangliu.crm.controller;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Maps;
import com.google.zxing.WriterException;
import com.keliangliu.crm.controller.exception.ForbiddenException;
import com.keliangliu.crm.controller.exception.NotFoundException;
import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Customer;
import com.keliangliu.crm.entity.Sales;
import com.keliangliu.crm.entity.Task;
import com.keliangliu.crm.service.AccountService;
import com.keliangliu.crm.service.CustomerService;
import com.keliangliu.crm.service.SalesService;
import com.keliangliu.crm.service.TaskService;
import com.keliangliu.util.IsoToUtf;
import com.keliangliu.util.QRCodeUtil;
import com.keliangliu.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

/**
 * Created by lkl on 2017/7/19.
 */
@Controller
@MultipartConfig
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private SalesService salesService;

    @Autowired
    private TaskService taskService;

    /**
     * 转向添加客户的页面
     * @return
     */
    @RequestMapping(value = "/manage/customer/add",method = RequestMethod.GET)
    public String custAdd() {
        return "manage/customerAdd";
    }

    /**
     * 添加客户
     * @param customer
     * @param session
     * @return
     */
    @RequestMapping(value="/manage/customer/add",method = RequestMethod.POST)
    @ResponseBody
    public Result add(Customer customer,HttpSession session) {
        Account account = (Account) session.getAttribute("currentAccount");
        customer.setAccountId(account.getId());
        customerService.save(customer);
        return Result.success();

    }

    /**
     * 校验输入的电话号码是否存在
     * @param tel
     * @return
     */
    @RequestMapping(value = "/manage/customer/validate/tel",method = RequestMethod.GET)
    @ResponseBody
    public String validateTel(String tel) {
        Customer customer = customerService.findByTel(tel);
        if(customer != null) {
            return "false";
        }else {
            return "true";
        }

    }

    /**
     * 显示我的客户列表
     * @param pageNum
     * @param keyword
     * @param session
     * @param model
     * @return
     */
    @RequestMapping(value="/customer/my",method = RequestMethod.GET)
    public String myCustomer(@RequestParam(required = false,defaultValue = "1" ,value="p") Integer pageNum,
                             @RequestParam(required = false,defaultValue = "") String keyword,
                             HttpSession session,
                             Model model){
        keyword = IsoToUtf.isoToUtf(keyword);
        Account account = (Account) session.getAttribute("currentAccount");
        Integer accountId = account.getId();


        Map<String,Object> queryParams = Maps.newHashMap();
        queryParams.put("keyword",keyword);
        queryParams.put("pageNum",pageNum);
        queryParams.put("accountId",accountId);

        PageInfo<Customer> pageInfo = customerService.findByParams(queryParams);
        model.addAttribute("page",pageInfo);
        model.addAttribute("keyword",keyword);
        return "customer/customer_my";
    }

    /**
     * 跳转到客户详细信息的页面
     * @return
     */
    @RequestMapping(value = "/customer/my/{id:\\d+}",method = RequestMethod.GET)
    public String showCustomerIfo(@PathVariable Integer id,HttpSession session,Model model)  {

        Customer customer = customerService.findById(id);
        List<Account> accountList = accountService.findAll();
        List<Sales> salesList = salesService.findByCustomerId(id);



        Account account = (Account) session.getAttribute("currentAccount");

        List<Task> taskList = taskService.findByParams(account.getId(),null);
        if(customer == null) {
            throw new NotFoundException();
        }
        if((!customer.getAccountId().equals(account.getId())) && (!new Integer(1).equals(customer.getAccountId()))){
            throw new ForbiddenException();
        }

        model.addAttribute("customer",customer);
        model.addAttribute("accountList",accountList);
        model.addAttribute("salesList",salesList);
        model.addAttribute("taskList",taskList);
        return "customer/customer_info";
    }

    /**
     *跳转到修改当前对象的客户界面
     * @return
     */
    @RequestMapping(value = "/customer/my/{id:\\d+}/edit",method = RequestMethod.GET)
    public String showEditCustomer(@PathVariable Integer id,HttpSession session,Model model) {

        Account account = (Account) session.getAttribute("currentAccount");
        Customer customer = customerService.findById(id);

        if(customer == null) {
            throw new NotFoundException();
        }

        if(!customer.getAccountId().equals(account.getId()) && (!new Integer(1).equals(customer.getAccountId()))) {
            throw new ForbiddenException();
        }

        List<String> tradeList = customerService.findTradeList();
        List<String> sourceList = customerService.findSourceList();

        model.addAttribute("tradeList",tradeList);
        model.addAttribute("sourceList",sourceList);
        model.addAttribute("customer",customer);

        return "customer/edit_my";

    }


    /**
     * 修改当前用户对象的客户信息
     * @param customer
     * @return
     */
    @RequestMapping(value = "/customer/my/{id:\\d+}/edit",method = RequestMethod.POST)
    public String editCustomer(Customer customer,HttpSession session) {

        Account account = (Account) session.getAttribute("currentAccount");

        if((!account.getId().equals(customer.getAccountId())) && (!new Integer(1).equals(customer.getAccountId()))) {
            throw new ForbiddenException();
        }
        customerService.editCustomer(customer);
        return "redirect:/customer/my";
    }



    /**
     * 把客户转交给其他人
     * @return
     */

    @RequestMapping(value = "/customer/my/{id:\\d+}/tran/{accountId:\\d+}",method=RequestMethod.GET)
    public String transferCustomerToOther(@PathVariable Integer id,
                                          @PathVariable Integer accountId,
                                          HttpSession session,
                                          RedirectAttributes redirectAttributes){

        Customer customer = customerService.findById(id);
        Account currentAccount = (Account) session.getAttribute("currentAccount");
        Account transferToAccount = accountService.findById(accountId);

        if(transferToAccount == null) {
            throw new NotFoundException();

        }

        if(customer == null) {
            throw new NotFoundException();
        }

        if(!customer.getAccountId().equals(currentAccount.getId())) {
            throw new ForbiddenException();
        }

        customerService.transferCustomerToOther(customer,currentAccount,transferToAccount);
        redirectAttributes.addFlashAttribute("message","转交成功");
        return "redirect:/customer/my";
    }


    /**
     * 把客户转交到公海中
     * @return
     */

    @RequestMapping(value = "/customer/my/{id:\\d+}/tran/public",method=RequestMethod.GET)
    public String transferCustomerToPublic(@PathVariable Integer id,
                                           HttpSession session,
                                           RedirectAttributes redirectAttributes){

        Account account = (Account) session.getAttribute("currentAccount");

        Customer customer = customerService.findById(id);

        if(customer == null) {
            throw new NotFoundException();
        }

        if(!customer.getAccountId().equals(account.getId())){
            throw new ForbiddenException();
        }

        customerService.transferCustomerToPublic(account,customer);
        redirectAttributes.addFlashAttribute("message","已转入到公海");

        return "redirect:/customer/my";

    }


    /**
     * 把客户信息到出到excel
     * @param response
     * @param session
     * @throws IOException
     */
    @RequestMapping(value="/customer/my/export",method = RequestMethod.GET)
    public void export(HttpServletResponse response,HttpSession session) throws IOException {

        Account account = (Account) session.getAttribute("currentAccount");
        OutputStream out = response.getOutputStream();

        response.setContentType("application/vnd.ms-excel,charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=\"customer.xlsx \"");

        customerService.exportExcel(account,out);
    }


    /**
     * 显示公海客户信息
     * @param pageNum
     * @param keyword
     * @param model
     * @return
     */
    @RequestMapping(value = "/customer/public",method=RequestMethod.GET)
    public String showCustomerPublic(@RequestParam(required = false,defaultValue = "1",value = "p")Integer pageNum,
                                     @RequestParam(required = false) String keyword,
                                     Model model){

        if(keyword != null) {
            keyword = IsoToUtf.isoToUtf(keyword);
        }
        Map<String,Object> queryParams = Maps.newHashMap();
        queryParams.put("keyword",keyword);
        queryParams.put("pageNum",pageNum);



       PageInfo<Customer> page =  customerService.findPublicByParams(queryParams);

       model.addAttribute("page",page);
       model.addAttribute("keyword",keyword);

       return "customer/customer_public";
    }


    /**
     * 显示公海客户的详细信息
     * @param id
     * @param model
     * @return
     */
    @GetMapping("/customer/public/{id:\\d+}")
    public String publicCustomerInfo(@PathVariable Integer id,Model model){

        Customer customer = customerService.findById(id);

        if(customer == null) {
            throw new NotFoundException();
        }
        model.addAttribute("customer",customer);
        return "redirect:/customer/my/" + id ;
    }

    /**
     * 把公海的客户变为我的客户
     *
     * @param id
     * @param attributes
     * @param session
     * @return
     */
    @GetMapping("/customer/public/{id:\\d+}/tran/my")
    public String transferPublicToMy(@PathVariable Integer id,RedirectAttributes attributes,HttpSession session){

        Account account = (Account) session.getAttribute("currentAccount");
        Customer customer = customerService.findById(id);


        if(customer == null) {
            throw new NotFoundException();
        }
        customerService.transferPublicToMy(customer,account);
        attributes.addFlashAttribute("message","已抢占成功");
        return "redirect:/customer/my";
    }


    /**
     *
     *单个添加公海客户
     *
     */

    @PostMapping("/customer/public/add")
    @ResponseBody
    public Result customerPublicAdd(Customer customer){
        customer.setAccountId(1);
        customerService.save(customer);
        return Result.success();

    }


    /**
     * 导出公海客户信息
     */
    @GetMapping("/customer/public/export")
    public void exportPublicCustomer(HttpServletResponse response) throws IOException{

        OutputStream out = response.getOutputStream();
        String fileName = "publicCustomer.xlsx";
        response.setContentType("application/vnd.ms-excel,charset=UTF-8");
        response.addHeader("Content-Disposition","attachment;filename=" + fileName);

        Account account = new Account();
        account.setId(1);

        customerService.exportExcel(account,out);

    }

    /**
     * 单个添加客户信息
     * @return
     */
    @GetMapping("/customer/public/import")
    public String showCustomerPublicImport(){
        return "customer/customer_public_import";
    }

    /**
     * 成批导入excel
     * @param doc form表单的name属性值
     * @param redirectAttributes
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/customer/public/import",method = RequestMethod.POST)
    public String publicImport(@RequestParam("doc") MultipartFile doc,
                               RedirectAttributes redirectAttributes,
                               HttpSession session) throws Exception {
        InputStream inputStream = doc.getInputStream();
        Account account = (Account) session.getAttribute("currentAccount");

        customerService.importExcel(inputStream,account);
        redirectAttributes.addFlashAttribute("message","导入成功");
        return "redirect:/customer/public/import";
    }


    /**
     * 生成二维码
     */
    @GetMapping("/customer/qrCode/{id:\\d+}")
    public void QRCode(@PathVariable Integer id, HttpServletResponse response){

        Customer customer = customerService.findById(id);
        response.setContentType("image/png");

        StringBuffer str = new StringBuffer();


            str.append("BEGIN:VCARD\r\n");
            str.append("VERSION:3.0\r\n");
            str.append("N:").append(customer.getName()).append("\r\n");
            str.append("TITLE:").append(customer.getPosition()).append("\r\n");
            str.append("TEL:").append(customer.getTel()).append("\r\n");
            str.append("ADR:").append(customer.getAddress()).append("\r\n");
            str.append("END:VCARD\r\n");


        try {
            OutputStream out = response.getOutputStream();

            QRCodeUtil.writeToStream(str.toString(),out,300,300);
            out.flush();
            out.close();

        } catch (IOException e) {
            throw new RuntimeException("生成二维码失败");
        }catch (WriterException e) {
            throw new RuntimeException("生成二维码失败");
        }


    }


}
