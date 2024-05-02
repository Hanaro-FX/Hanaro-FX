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
    @Value("${spring.kakao.url.login}")
    private String kakaoLoginUri;

    @Value("${spring.kakao.url.logout}")
    private String kakaoLogoutUri;

    @Value("${spring.kakao.client-id}")
    private String kakaoClientId;

    @Value("${spring.kakao.login-redirect}")
    private String kakaoLoginRedirectUri;

    @Value("${spring.kakao.logout-redirect}")
    private String kakaoLogoutRedirectUri;

    final KakaoService kakaoService;
    final UserService userService;

    @GetMapping("/login")
    @ResponseBody
    public String login(){ // (1) 인가 코드 발급 받기
        StringBuilder loginView = new StringBuilder()
                .append(kakaoLoginUri)
                .append("?response_type=code")
                .append("&client_id=").append(kakaoClientId)
                .append("&redirect_uri=").append("http://localhost:8080").append(kakaoLoginRedirectUri);

        log.info(String.valueOf(loginView));
        return loginView.toString();
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
        return "redirect:/";
    }

    @GetMapping("/logout")
    @ResponseBody
    public String logout(HttpSession httpSession) { // (1) 인가 코드 발급 받기
        StringBuilder logout = new StringBuilder() // 1-1. 카카오 api 로그아웃
                .append(kakaoLogoutUri)
                .append("?client_id=").append(kakaoClientId)
                .append("&logout_redirect_uri=").append("http://localhost:8080").append(kakaoLogoutRedirectUri);

        log.info(String.valueOf(logout));
        return logout.toString();
    }

    @RequestMapping("/logout/kakao")
    public String logoutImpl(HttpSession httpSession){
        httpSession.invalidate();
        return "redirect:/";
    }
}
