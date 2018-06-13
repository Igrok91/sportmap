package com.realsport.model.entity;

import java.io.Serializable;

public class ErrorInfo implements Serializable {

    private Integer error_code;
    private String error_msg;
    private boolean critical;

    public ErrorInfo() {
    }

    public ErrorInfo(Integer error_code, String error_msg, boolean critical) {
        this.error_code = error_code;
        this.error_msg = error_msg;
        this.critical = critical;
    }

    public Integer getError_code() {
        return error_code;
    }

    public void setError_code(Integer error_code) {
        this.error_code = error_code;
    }

    public String getError_msg() {
        return error_msg;
    }

    public void setError_msg(String error_msg) {
        this.error_msg = error_msg;
    }

    public boolean isCritical() {
        return critical;
    }

    public void setCritical(boolean critical) {
        this.critical = critical;
    }
}
