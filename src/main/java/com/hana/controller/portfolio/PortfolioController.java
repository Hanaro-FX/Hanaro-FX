package com.hana.controller.portfolio;

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
}
