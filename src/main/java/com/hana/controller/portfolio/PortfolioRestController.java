package com.hana.controller.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.service.PortfolioService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/portfolio")
public class PortfolioRestController {
    final PortfolioService portfolioService;

    @RequestMapping("/createImpl")
    public String portfolioCreate(Model model, PortfolioDTO portfolioDTO) throws Exception {
        log.info(portfolioDTO.toString());
        portfolioService.insert(portfolioDTO);
        model.addAttribute("center", "/");
        return "index";
    }
}
