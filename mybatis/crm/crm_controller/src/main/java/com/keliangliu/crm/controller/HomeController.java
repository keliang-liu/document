package com.keliangliu.crm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by lkl on 2017/7/19.
 */
@Controller
public class HomeController {

    @RequestMapping(value = "/home",method = RequestMethod.GET)
    public String home(){
        return "home";
    }


}
