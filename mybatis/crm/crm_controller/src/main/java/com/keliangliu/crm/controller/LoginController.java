package com.keliangliu.crm.controller;

import com.keliangliu.crm.entity.Account;
import com.keliangliu.crm.service.AccountService;
import com.keliangliu.exception.ServiceException;
import com.keliangliu.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

/**
 * Created by lkl on 2017/7/19.
 */

@Controller
public class LoginController {

    @Autowired
    private AccountService accountService;


    @RequestMapping(value="/",method = RequestMethod.GET)
    public String loginShow(String callback,Model model){
        model.addAttribute("callback",callback);
        return "login";
    }

    @RequestMapping(value="/",method = RequestMethod.POST)
    @ResponseBody
    public Result login(String mobile,String password,HttpSession session){
        try{
            Account account =  accountService.login(mobile,password);
            session.setAttribute("currentAccount",account);
            return Result.success();
        }catch (ServiceException e) {
            return Result.error(e.getMessage());
        }
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(RedirectAttributes redirectAttributes,HttpSession session){
        session.invalidate();
        redirectAttributes.addFlashAttribute("message","已经安全退出");
        return "redirect:/";
    }

    @RequestMapping(value="/profile",method=RequestMethod.GET)
    public String profile(HttpSession session,Model model){
        return "profile";
    }


    @RequestMapping(value = "/profile",method=RequestMethod.POST)
    @ResponseBody
    public Result modifyPassword(String oldPassword,String password,HttpSession session){

        Account account = (Account) session.getAttribute("currentAccount");

        try{
            accountService.changePassword(oldPassword,password,account);
            session.invalidate();
            return Result.success();
        }catch (ServiceException e) {
            return Result.error(e.getMessage());
        }

    }


}
