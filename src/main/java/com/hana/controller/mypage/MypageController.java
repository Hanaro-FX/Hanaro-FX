package com.hana.controller.mypage;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class MypageController {

    String dir = "mypage/";

    @RequestMapping
    public String mypage(Model model) {
        // 추후 변경 : 로그인한 사용자 받아오기
        String name = "하나로";
        model.addAttribute("name", name);

        model.addAttribute("center", dir + "mypage");
        return "index";
    }
}