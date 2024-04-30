package com.hana.app.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.hana.app.data.dto.UserDTO;
import com.hana.app.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@Slf4j
@Service
@RequiredArgsConstructor
public class KakaoService{
    @Value("${spring.kakao.client-id}")
    private String kakaoClientId;

    @Value("${spring.kakao.login-redirect}")
    private String kakaoRedirectUri;

    @Value("${spring.kakao.url.token}")
    private String kakaoTokenUri;

    @Value("${spring.kakao.url.profile}")
    private String kakaoProfileUri;

    private final HttpSession httpSession;
    final UserRepository userRepository;

    public String getAccessToken (String code) {
        String accessToken = "";

        try {
            URL url = new URL(kakaoTokenUri);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // 파라미터 Form 맞추기
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=").append(kakaoClientId);
            sb.append("&redirect_uri=http://localhost:8080").append(kakaoRedirectUri);
            sb.append("&code=").append(code);
            bw.write(sb.toString());
            bw.flush();

            // JSON 형태의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";
            while ((line = br.readLine()) != null) {
                result += line;
            }

            // Gson 라이브러리에 포함된 클래스로 JSON 파싱 객체 생성 및 accessToken 추출
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);
            accessToken = element.getAsJsonObject().get("access_token").getAsString();
            log.info("accessToken : " + accessToken);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return accessToken;
    }

    public UserDTO getUserInfo(String accessToken){
        UserDTO userDTO = new UserDTO();

        try {
            URL url = new URL(kakaoProfileUri);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            StringBuilder result = new StringBuilder();

            while ((line = br.readLine()) != null) {
                result.append(line);
            }

            JsonElement element = JsonParser.parseString(result.toString());
            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakaoAccount = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakaoAccount.getAsJsonObject().get("email").getAsString();
            userDTO.setName(nickname);
            userDTO.setEmail(email);
            log.info("userInfo : " + userDTO);

        } catch (IOException exception) {
            exception.printStackTrace();
        }

        return userDTO;
    }
}
