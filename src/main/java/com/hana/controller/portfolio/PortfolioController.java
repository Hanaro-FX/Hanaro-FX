package com.hana.controller.portfolio;

import com.hana.app.service.PortfolioService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/portfolio")
@RequiredArgsConstructor
public class PortfolioController {

    private final PortfolioService portfolioService;

    // 프트폴리오 삭제
    @RequestMapping("/delete")
    public String deletePortfolio(@RequestParam("id") Integer id) throws Exception {
        portfolioService.delete(id);

        return "redirect:/mypage";
    }
}
