package com.hana.controller.portfolio;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.service.KakaoService;
import com.hana.app.service.PortfolioService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
@RequestMapping("/portfolio")
@Slf4j
public class PortfolioController {

    private final KakaoService kakaoService;
    private final PortfolioService portfolioService;

    String dir = "portfolio/";

    @RequestMapping("/create")
    public String portfolioCreateView(
            Model model,
            HttpSession httpSession
    ) {
        // 사용자의 로그인 여부 확인
        Object accessToken = httpSession.getAttribute("accessToken");
        if(accessToken == null){
            String loginRedirectUrl = kakaoService.getLoginRedirectUrl();
            return "redirect:" + loginRedirectUrl;
        }
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

    // 포트폴리오 수정
    @RequestMapping("/update")
    public String updatePortfolioView(@RequestParam("id") Integer id, Model model) throws Exception {
        // 포트폴리오 데이터 불러오기
        PortfolioDTO portfolio = portfolioService.selectOne(id);
        model.addAttribute("portfolio", portfolio);

        model.addAttribute("center", dir + "update");
        return "index";
    }

    @RequestMapping("/updateImpl")
    public String updatePortfolio(@RequestParam("id") Integer id, PortfolioDTO portfolioDTO) throws Exception {
        portfolioService.update(portfolioDTO);
        return "redirect:/portfolio/result?id=" + id;
    }
}