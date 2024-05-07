package com.hana.app.common;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

import static org.springframework.http.HttpStatus.*;

@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Getter
public enum ErrorCode {

    INVALID_TOKEN(UNAUTHORIZED, "유효하지 않은 토큰"),
    USER_NOT_EXIST(NOT_FOUND, "존재하지 않는 회원"),

    PORTFOLIO_NOT_EXIST(NOT_FOUND, "존재하지 않는 포트폴리오"),
    USER_NOT_HAVE_PORTFOLIO(BAD_REQUEST, "회원이 가진 포트폴리오가 아닙니다."),
    ;

    private final HttpStatus httpStatus;
    private final String message;
}
