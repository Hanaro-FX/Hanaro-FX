package com.hana.controller.mypage;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.service.PortfolioService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/mypage")
@RequiredArgsConstructor
public class MypageController {

    private final PortfolioService portfolioService;

    String dir = "mypage/";

    @RequestMapping
    public String mypage(Model model) throws Exception {
        // 로그인한 사용자 받아오기 - 수정 예정

        String name = "하나로"; // 임의 데이터 사용(이름)
        model.addAttribute("name", name);

        // 포트폴리오 목록 불러오기
        List<PortfolioDTO> portfolioList = portfolioService.getPortfolioList(1); // 임의 데이터 사용(사용자 아이디)
        model.addAttribute("portfolioList", portfolioList);

        model.addAttribute("center", dir + "mypage");
        return "index";
    }
}