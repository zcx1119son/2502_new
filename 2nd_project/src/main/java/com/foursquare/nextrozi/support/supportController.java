package com.foursquare.nextrozi.support;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/support")
public class supportController {

    // 고객센터로 이동
    @GetMapping("/support.do")
    public String showsupportPage() {
        return "support";
    }
    @GetMapping("/main")
    public String test(){
        return "index";
    }
}