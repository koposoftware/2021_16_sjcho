package kr.ac.bank.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import kr.ac.bank.dto.Response;

@RestControllerAdvice
public class ExceptionHandlerAdvice {

    @ExceptionHandler(BankException.class)
    public Response<?> artChainExceptionHandler(BankException exception) {
        return Response.builder()
                .code(-1)
                .msg("fail")
                .data(exception.getMessage())
                .build();
    }
}
