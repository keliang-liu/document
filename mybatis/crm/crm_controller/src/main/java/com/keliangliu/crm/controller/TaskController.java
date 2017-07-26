package com.keliangliu.crm.controller;


import com.keliangliu.crm.controller.exception.ForbiddenException;
import com.keliangliu.crm.controller.exception.NotFoundException;
import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Task;
import com.keliangliu.crm.mapper.CustomerMapper;
import com.keliangliu.crm.service.TaskService;
import com.keliangliu.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class TaskController {

    @Autowired
    private TaskService taskService;

    @Autowired
    private CustomerMapper customerMapper;


    @RequestMapping(value = "/task/new",method = RequestMethod.GET)
    public String taskNew(@RequestParam(required = false) Integer customerId,
                          Model model,
                          @RequestParam(required = false) Integer salesId){
        model.addAttribute("customerId",customerId);
        model.addAttribute("salesId",salesId);
        return "task/new";

    }


    @PostMapping("/task/new")
    public String taskNew(Task task) {
        taskService.saveTask(task);
        Integer customerId = task.getCustomerId();
        if(task.getSalesId() != null) {
            Integer salesId = task.getSalesId();
            return "redirect:/sales/my/" + salesId + "/info";
        }else if(customerId != null) {
            return "redirect:/customer/my/" + customerId;
        }else {
            return "redirect:/task/search";
        }

    }


    @GetMapping("/task/search")
    public String show(@RequestParam(required = false) String showAll,
                       HttpSession session,
                       Model model) {

        if(showAll != null && !showAll.equals("all") ) {
            throw new NotFoundException();
        }

        Account account = (Account) session.getAttribute("currentAccount");
        List<Task> taskList = taskService.findByParams(account.getId(),showAll);
        model.addAttribute("taskList",taskList);
        model.addAttribute("showAll",showAll);
        return "/task/search";
    }

    @GetMapping("/task/edit/{id:\\d+}")
    public String editTaskToDone(@PathVariable("id") Integer id,
                                 HttpSession session,
                                 @RequestParam(required = false) String showAll,
                                 @RequestParam(required = false) Integer custId,
                                 @RequestParam(required = false) Integer salesId) {

        Account account = (Account) session.getAttribute("currentAccount");
        Task task = taskService.findById(id);

        if(task == null) {
            throw new NotFoundException();
        }

        if(!task.getAccountId().equals(account.getId())) {
            throw new ForbiddenException();
        }

        if(task.getState().equals(new Integer(1))) {
            task.setState(0);
            taskService.editTask(task);
        }else {
            task.setState(1);
            taskService.editTask(task);
        }

        if(StringUtils.isEmpty(showAll)) {
            if(custId != null) {
                return "redirect:/customer/my/" + custId;
            }else if(salesId != null) {
                return "redirect:/sales/my/" + salesId + "/info";
            }else {
                return "redirect:/task/search";
            }

        }else {
            return "redirect:/task/search?showAll=" + showAll;
        }

    }

    @GetMapping("/task/del/{id:\\d+}")
    @ResponseBody
    public Result delById(@PathVariable Integer id,
                          HttpSession session
                          ) {

        Account account = (Account) session.getAttribute("currentAccount");
        Task task = taskService.findById(id);
        if(task == null) {
            throw new NotFoundException();
        }

        if(!task.getAccountId().equals(account.getId())) {
            throw new ForbiddenException();
        }

        taskService.delById(id);

        return Result.success();
    }


}
