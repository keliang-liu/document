package com.keliangliu.crm.controller;

import com.google.common.base.Function;
import com.google.common.collect.Collections2;
import com.google.common.collect.Lists;
import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.entity.Dept;
import com.keliangliu.crm.service.AccountService;
import com.keliangliu.crm.service.DeptService;
import com.keliangliu.util.DataTableResult;
import com.keliangliu.util.Result;
import com.keliangliu.util.Tree;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import javax.annotation.Nullable;
import javax.servlet.http.HttpServletRequest;
import java.util.List;


/**
 * Created by lkl on 2017/7/17.
 */
@Controller
@RequestMapping("/manage/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private DeptService deptService;


    /*@RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public List<Account> findAll(){

        return accountService.findAll();

    }*/

   @RequestMapping(method=RequestMethod.GET)
   public String accountShow(Model model){
       return "manage/account";
   }

   @RequestMapping(value="/dept.json",method=RequestMethod.POST)
   @ResponseBody
   public List<Tree> showDept(){
       List<Dept> deptList = deptService.findAll();
       List<Tree> treeList = Lists.newArrayList(Collections2.transform(deptList, new Function<Dept, Tree>() {
           @Nullable
           @Override
           public Tree apply(@Nullable Dept dept) {
               Tree tree = new Tree();
               tree.setId(dept.getId());
               tree.setName(dept.getDeptName());
               tree.setpId(dept.getpId());
               return tree;
           }
       }));

       return treeList;
   }

   @RequestMapping(value="/dept/new",method=RequestMethod.POST)
   @ResponseBody
   public Result deptNew(Dept dept){
       deptService.save(dept);
       return Result.success();

   }

    @RequestMapping(value="/get/depts",method = RequestMethod.GET)
    @ResponseBody
    public Result getDeptList(){
       return Result.success(deptService.findAll());
   }


// @RequestMapping(value="/new",method=RequestMethod.POST)
   @PostMapping("/new")
   @ResponseBody
   public Result saveAccount(Account account,Integer[] deptId){
        accountService.saveAccount(account,deptId);
        return Result.success();

   }


   @RequestMapping(value="/load.json" ,method= RequestMethod.GET)
   @ResponseBody
   public DataTableResult accountLoadDept(HttpServletRequest request){

       String draw = request.getParameter("draw");
       String deptId = request.getParameter("deptId");

       Integer id = null;
       if(StringUtils.isNotEmpty(deptId)){
            id = Integer.valueOf(deptId);
       }

       //按条件查询用户的数量
       Integer recordsTotal = accountService.countAll();
       //按条件查询用户查询总数量
       Integer recordsFiltered = accountService.countByDeptId(id);
       //按客户端给定的值进行查找Account对象
       List<Account> accountList = accountService.findByDeptId(id);
       return new DataTableResult(draw,recordsTotal,recordsFiltered,accountList);
   }



    @RequestMapping(value="/del/{id:\\d+}",method=RequestMethod.GET)
    @ResponseBody
   public Result delById(@PathVariable Integer id){
       accountService.delById(id);
       return Result.success();
   }


   @RequestMapping(value="/dept/del/{id:\\d+}",method=RequestMethod.GET)
   @ResponseBody
   public Result delDeptById(@PathVariable Integer id) {
       try{
           deptService.delDeptBytId(id);
           return Result.success();
       }catch (RuntimeException e) {
           return Result.error(e.getMessage());
       }

   }

}
