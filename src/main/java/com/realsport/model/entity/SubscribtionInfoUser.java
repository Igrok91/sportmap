package com.realsport.model.entity;

public class SubscribtionInfoUser {

    private String status;
    private Integer subscription_id;

    public SubscribtionInfoUser() {
    }

    public SubscribtionInfoUser(String status, Integer subscription_id) {
        this.status = status;
        this.subscription_id = subscription_id;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setSubscription_id(Integer subscription_id) {
        this.subscription_id = subscription_id;
    }

    public String getStatus() {
        return status;
    }

    public Integer getSubscription_id() {
        return subscription_id;
    }
}
