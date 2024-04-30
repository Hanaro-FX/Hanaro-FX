package com.hana.controller.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.service.PortfolioService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.hana.app.service.PortfolioService;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/portfolio")
@Slf4j
public class PortfolioController {

    private final PortfolioService portfolioService;

    String dir = "portfolio/";

    @RequestMapping("/result")
    public String resultPage(@RequestParam("id") Integer id, Model model) throws Exception {
        // 포트폴리오 데이터 불러오기
        PortfolioDTO portfolio = portfolioService.selectOne(id);
        model.addAttribute("portfolio", portfolio);

        model.addAttribute("center", dir + "result");
        return "index";
    }

    @RequestMapping("/create")
    public String portfolioCreateView(Model model) {
        model.addAttribute("center", dir + "create");
        return "index";
    }

    // 프트폴리오 삭제
    @RequestMapping("/delete")
    public String deletePortfolio(@RequestParam("id") Integer id) throws Exception {
        portfolioService.delete(id);
        return "redirect:/mypage";
    }
}