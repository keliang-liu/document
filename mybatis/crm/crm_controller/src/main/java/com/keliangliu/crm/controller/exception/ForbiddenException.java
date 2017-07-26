package com.keliangliu.crm.controller.exception;


import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN,reason = "forbidden")
public class ForbiddenException extends RuntimeException {

}
