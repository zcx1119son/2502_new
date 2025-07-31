package com.myspringboot.pro30;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

    @GetMapping("/")
    public ModelAndView index(){
        ModelAndView mav = new ModelAndView("index");
        mav.addObject("message", "Hello Spring Boot");
        return mav;
    }

    @GetMapping("/test")
    public ModelAndView test(){
        ModelAndView mav = new ModelAndView("test");
        mav.addObject("message", "Hello Test Page");
        return mav;
    }

    @GetMapping("/main")
    public String main(){
        return "main";
    }

}