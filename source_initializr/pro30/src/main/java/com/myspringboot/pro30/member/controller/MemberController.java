package com.myspringboot.pro30.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {

    @GetMapping("/loginForm")
    public String loginForm() throws Exception{
        return "/member/loginForm";
    }
}
