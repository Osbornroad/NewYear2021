package com.gmail.osbornroad.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Favicon {

    @RequestMapping("favicon.ico")
    @ResponseBody
    void favicon() {
//        System.out.println("favicon");
    }
}
