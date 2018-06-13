package com.realsport.model.entity;

import java.io.Serializable;

public class StatusSubscribe implements Serializable {

    private Integer subscription_id;
    private Integer app_order_id ;

    public StatusSubscribe(Integer subscription_id, Integer app_order_id) {
        this.subscription_id = subscription_id;
        this.app_order_id = app_order_id;
    }

    public Integer getSubscription_id() {
        return subscription_id;
    }

    public void setSubscription_id(Integer subscription_id) {
        this.subscription_id = subscription_id;
    }

    public Integer getApp_order_id() {
        return app_order_id;
    }

    public void setApp_order_id(Integer app_order_id) {
        this.app_order_id = app_order_id;
    }
}
