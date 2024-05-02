package com.hana.controller.mypage;

import com.hana.app.data.dto.PortfolioDTO;
import com.hana.app.service.KakaoService;
import com.hana.app.service.PortfolioService;
import jakarta.servlet.http.HttpSession;
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

    private final KakaoService kakaoService;
    private final PortfolioService portfolioService;

    String dir = "mypage/";

    @RequestMapping
    public String mypage(
            Model model,
            HttpSession httpSession
    ) throws Exception {
        // 사용자의 로그인 여부 확인
        Object accessToken = httpSession.getAttribute("accessToken");
        if(accessToken == null){
            String loginRedirectUrl = kakaoService.getLoginRedirectUrl();
            return "redirect:" + loginRedirectUrl;
        }

        // 로그인한 사용자 받아오기 - 수정 예정
        String name = (String) httpSession.getAttribute("userName");
        model.addAttribute("name", name);

        // 포트폴리오 목록 불러오기
        List<PortfolioDTO> portfolioList = portfolioService.getPortfolioList(2); // 임의 데이터 사용(사용자 아이디)
        model.addAttribute("portfolioList", portfolioList);

        model.addAttribute("center", dir + "mypage");
        return "index";
    }
}