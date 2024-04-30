package com.hana.controller.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.data.dto.PortfolioQueryDTO;
import com.hana.app.service.PortfolioService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/portfolio")
@Slf4j
public class PortfolioController {

    private final PortfolioService portfolioService;

    String dir = "portfolio/";

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

    @RequestMapping("/result")
    public String resultView(@RequestParam("id") Integer id, Model model) throws Exception {
        model.addAttribute("center", dir + "result");
        model.addAttribute("id", id);
        return "index";
    }

}