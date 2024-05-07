package com.hana.app.common;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Getter
public enum SuccessMessage {

    USER_LOGIN_SUCCESS(OK, "로그인 성공"),
    USER_SIGNUP_SUCCESS(CREATED, "회원 가입 성공"),

    PORTFOLIO_SAVE_SUCCESS(CREATED, "포트폴리오 생성 성공"),
    PORTFOLIO_FETCH_SUCCESS(OK, "포트폴리오 조회 성공"),
    PORTFOLIO_LIST_FETCH_SUCCESS(OK, "포트폴리오 리스트 조회 성공"),
    PORTFOLIO_UPDATE_SUCCESS(OK, "포트폴리오 수정 성공"),
    PORTFOLIO_DELETE_SUCCESS(OK, "포트폴리오 삭제 성공"),
    ;

    private final HttpStatus httpStatus;
    private final String message;
}
