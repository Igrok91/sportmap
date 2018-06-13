package com.realsport.model.entity;

import java.io.Serializable;

public class Response implements Serializable {

    private Object response;

    public Response(Object response) {
        this.response = response;
    }

    public Object getResponse() {
        return response;
    }

    public void setResponse(Object response) {
        this.response = response;
    }
}
