package com.keliangliu.util;

/**
 * Created by lkl on 2017/7/17.
 */
public class Result {

    private String state;
    private String message;
    private Object data;

    public static Result success(){
        Result result = new Result();
        result.setState("success");
        return result;
    }

    public static Result success(Object data) {
        Result result = new Result();
        result.setState("success");
        result.setData(data);
        return result;
    }

    public static Result error(){
        Result result = new Result();
        result.setState("error");
        return result;
    }

    public static Result error(String message) {
        Result result = new Result();
        result.setState("error");
        result.setMessage(message);
        return result;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
