package com.hana.controller.portfolio;

import com.hana.app.common.ErrorCode;
import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.exception.BusinessException;
import com.hana.app.service.KakaoService;
import com.hana.app.service.PortfolioService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        int id = (int) httpSession.getAttribute("userId");
        model.addAttribute("userId", id);

        model.addAttribute("center", dir + "create");
        return "index";
    }

    @RequestMapping("/createImpl")
    @ResponseBody
    public int portfolioCreate(Model model, PortfolioDTO portfolioDTO) throws Exception {
        portfolioService.insert(portfolioDTO);
        //model.addAttribute("center", "/");
        return portfolioDTO.getId();
    }

    // 프트폴리오 삭제
    @RequestMapping("/delete")
    public String deletePortfolio(@RequestParam("id") Integer id, HttpSession httpSession) throws Exception {
        try {
            PortfolioDTO portfolio = portfolioService.selectOne(id);
            if (portfolio.getUserId() != (Integer) httpSession.getAttribute("userId")) {
                throw new BusinessException(ErrorCode.USER_NOT_HAVE_PORTFOLIO);
            }
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.PORTFOLIO_NOT_EXIST);
        }

        portfolioService.delete(id);
        return "redirect:/mypage";
    }

    @RequestMapping("/result")
    public String resultView(@RequestParam("id") Integer id, Model model) throws Exception {
        model.addAttribute("center", dir + "result");
        model.addAttribute("id", id);
        model.addAttribute("share", 0);
        return "index";
    }

    // 포트폴리오 공유
    @RequestMapping("/result/share")
    public String resultShareView(@RequestParam("id") Integer id, Model model) throws Exception {
        model.addAttribute("center", dir + "result");
        model.addAttribute("id", id);
        model.addAttribute("share", 1);
        return "index";
    }

    // 포트폴리오 수정
    @RequestMapping("/update")
    public String updatePortfolioView(@RequestParam("id") Integer id, Model model, HttpSession httpSession) throws Exception {
        // 포트폴리오 데이터 불러오기
        try {
            PortfolioDTO portfolio = portfolioService.selectOne(id);
            if (portfolio.getUserId() != (Integer) httpSession.getAttribute("userId")) {
                throw new BusinessException(ErrorCode.USER_NOT_HAVE_PORTFOLIO);
            }
            model.addAttribute("portfolio", portfolio);
        } catch (Exception e) {
            throw new BusinessException(ErrorCode.PORTFOLIO_NOT_EXIST);
        }

        model.addAttribute("center", dir + "update");
        return "index";
    }

    @RequestMapping("/updateImpl")
    public String updatePortfolio(@RequestParam("id") Integer id, PortfolioDTO portfolioDTO) throws Exception {
        portfolioService.update(portfolioDTO);
        return "redirect:/portfolio/result?id=" + id;
    }
}