package com.realsport.model.vo;

import java.io.Serializable;

public class Error implements Serializable {

    private ErrorInfo error;

    public Error() {
    }

    public Error(ErrorInfo errorInfo) {
        this.error = errorInfo;
    }

    public ErrorInfo getError() {
        return error;
    }

    public void setError(ErrorInfo error) {
        this.error = error;
    }
}
