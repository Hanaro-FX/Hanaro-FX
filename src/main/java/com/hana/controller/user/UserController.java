package com.hana.controller.user;

import com.hana.app.data.dto.UserDTO;
import com.hana.app.service.KakaoService;
import com.hana.app.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {
    final KakaoService kakaoService;
    final UserService userService;

    @GetMapping("/login")
    @ResponseBody
    public String login(){ // (1) 인가 코드 발급 받기
        return kakaoService.getLoginRedirectUrl();
    }

    @RequestMapping("/oauth/kakao")
    public String loginImpl(
            @RequestParam("code") String code,
            HttpSession httpSession
    ) throws Exception {
        String accessToken = kakaoService.getAccessToken(code); // (2) 발급 받은 인가 코드를 통해 AccessToken 반환 받기
        UserDTO userInfo = kakaoService.getUserInfo(accessToken); // (3) AccessToken을 통해 userInfo 추출하기
        Integer userId = userService.getUserId(userInfo); // (4) DB에서 해당 회원의 ID 추출하기
        log.info(String.valueOf(userId));

        httpSession.setAttribute("accessToken", accessToken);
        httpSession.setAttribute("userId", userId);
        httpSession.setAttribute("userName", userInfo.getName());
        return "redirect:/";
    }

    @GetMapping("/logout")
    @ResponseBody
    public String logout() { // (1) 인가 코드 발급 받기
        return kakaoService.getLogoutRedirectUrl();
    }

    @RequestMapping("/logout/kakao")
    public String logoutImpl(HttpSession httpSession){
        httpSession.invalidate();
        return "redirect:/";
    }
}
