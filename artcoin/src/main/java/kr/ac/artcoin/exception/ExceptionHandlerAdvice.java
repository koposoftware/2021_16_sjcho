package kr.ac.artcoin.exception;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import kr.ac.artcoin.dto.Response;

@RestControllerAdvice
public class ExceptionHandlerAdvice {

    @ExceptionHandler(ArtChainException.class)
    public Response<?> artChainExceptionHandler(ArtChainException exception) {
        return Response.builder()
                .code(-1)
                .msg("fail")
                .data(exception.getMessage())
                .build();
    }
}
