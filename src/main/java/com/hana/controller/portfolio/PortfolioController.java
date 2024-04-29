package com.hana.controller.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/portfolio")
@Slf4j
public class PortfolioController {

    String dir = "portfolio/";

    @RequestMapping("/create")
    public String portfolioCreateView(Model model) {
        model.addAttribute("center", dir + "create");
        return "index";
    }

    @RequestMapping("/createImpl")
    public String portfolioCreate(Model model, PortfolioDTO portfolioDTO) {
        return "index";
    }
}
