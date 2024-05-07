package com.hana.app.common.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
@AllArgsConstructor
public class ErrorResponse {
    private HttpStatus status;
    private String message;

    public static ErrorResponse of(HttpStatus status, String message) {
        return new ErrorResponse(status, message);
    }
}