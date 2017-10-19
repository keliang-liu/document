package com.keliangliu.admin.serviceImpl;


import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

public class App {

    public static void main(String[] args) throws IOException {

        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("classpath:applicationContext*.xml");
        context.start();
        System.out.println("zookeeper已经启动");
        System.in.read();


    }

}
