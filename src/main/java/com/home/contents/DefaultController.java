package com.home.contents;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DefaultController {

    @RequestMapping(value = "/")
    public String index() {
        return "redirect:dashboard/main";
    }
}
