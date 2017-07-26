package com.keliangliu.crm.controller;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Maps;
import com.keliangliu.crm.controller.exception.ForbiddenException;
import com.keliangliu.crm.controller.exception.NotFoundException;
import com.keliangliu.crm.entity.*;
import com.keliangliu.crm.service.CustomerService;
import com.keliangliu.crm.service.SalesRecordService;
import com.keliangliu.crm.service.SalesService;
import com.keliangliu.crm.service.TaskService;
import com.keliangliu.util.IsoToUtf;
import com.keliangliu.util.Result;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class SalesController {

    @Autowired
    private SalesService salesService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private SalesRecordService salesRecordService;

    @Autowired
    private TaskService taskService;

    /**
     *
     * 显示增加销售机会的页面
     * @return
     */
    @GetMapping("/sales/my/new")
    public String showSalesNew(Model model, HttpSession session,@RequestParam(required = false) Integer custId){

        Account account = (Account) session.getAttribute("currentAccount");

        List<Customer> customerList = customerService.findMyAll(account);
        List<String> progressList = salesService.findProgressList();

        model.addAttribute("progressList",progressList);
        model.addAttribute("customerList",customerList);
        model.addAttribute("custId",custId);
        return "sales/my_new";
    }


    /**
     * 添加销售机会
     * @return
     */
    @PostMapping("/sales/my/new")
    @ResponseBody
    public Result salesNew(Sales sales,HttpSession session){

        Account account = (Account) session.getAttribute("currentAccount");
        Customer customer = customerService.findById(sales.getCustomerId());

        if(customer == null) {
            throw new NotFoundException();
        }
        if(!customer.getAccountId().equals(account.getId())) {
            throw new ForbiddenException();
        }
        salesService.saveSales(sales,account);
        return Result.success();

    }

    /**
     * 显示当前用户的销售机会
     * @param pageNum
     * @param keyword
     * @param model
     * @param session
     * @return
     */
    @GetMapping("/sales/my")
    public String showSalesMy(@RequestParam(required = false,defaultValue = "1",value = "p") Integer pageNum,
                              @RequestParam(required = false) String keyword,
                              Model model,
                              HttpSession session){

        keyword = IsoToUtf.isoToUtf(keyword);
        Account account = (Account) session.getAttribute("currentAccount");
        Map<String,Object> map = Maps.newHashMap();
        map.put("pageNum",pageNum);
        map.put("keyword",keyword);
        map.put("accountId",account.getId());

        PageInfo<Sales> pageInfo = salesService.findByParams(map);
        model.addAttribute("page",pageInfo);
        model.addAttribute("keyword",keyword);
        return "sales/my";
    }


    /**
     * 显示一个销售机会的详细信息
     * @param id
     * @param session
     * @param model
     * @return
     */
    @GetMapping("/sales/my/{id:\\d+}/info")
    public String mySalesInfo(@PathVariable("id") Integer id,HttpSession session,Model model){

        Account account = (Account) session.getAttribute("currentAccount");
        Sales sales = salesService.findById(id);
        List<String> progressList = salesService.findProgressList();
        List<Task> taskList = taskService.findByParams(account.getId(),null);

        if(sales == null) {
            throw new NotFoundException();
        }

        if(! account.getId().equals(sales.getAccountId())) {
            throw new ForbiddenException();
        }

        Customer customer = customerService.findById(sales.getCustomerId());

        List<SalesRecord> salesRecordList = salesRecordService.findBySalesId(id);

        model.addAttribute("sales",sales);
        model.addAttribute("customer",customer);
        model.addAttribute("salesRecordList",salesRecordList);
        model.addAttribute("progressList",progressList);
        model.addAttribute("taskList",taskList);

        return "sales/my_info";
    }


    /**
     * 修改进度进度
     * @param progress
     * @param salesId
     * @param session
     * @param customerId
     * @param attributes
     * @return
     */
    @RequestMapping(value = "/sales/my/progress/change",method = RequestMethod.POST)
    public String progressChange(String progress,
                                 Integer salesId,
                                 HttpSession session,
                                 Integer customerId,
                                 RedirectAttributes attributes){

        Account account = (Account) session.getAttribute("currentAccount");
        Customer customer = customerService.findById(customerId);

        if(!customer.getAccountId().equals(account.getId())) {
            throw new ForbiddenException();
        }

        salesService.updateProgress(progress,salesId,account,customer);
        attributes.addFlashAttribute("message","修改成功");

        return "redirect:/sales/my/"+ salesId + "/info";

    }


    @PostMapping("/sales/my/{salesId:\\d+}/content/change")
    public String recordChange(@PathVariable("salesId") Integer salesId,
                               String content,
                               Integer customerId,
                               HttpSession  session,
                               RedirectAttributes redirectAttributes){

        Customer customer = customerService.findById(customerId);
        Account account = (Account) session.getAttribute("currentAccount");
        Sales sales = salesService.findById(salesId);

        if(sales == null) {

            throw new NotFoundException();
        }

        if(!customer.getAccountId().equals(account.getId())) {
            throw new ForbiddenException();
        }

        salesRecordService.saveRecord(content,sales,customer);
        redirectAttributes.addFlashAttribute("message","添加纪录成功");

        return "redirect:/sales/my/"+ salesId + "/info";
    }


}
