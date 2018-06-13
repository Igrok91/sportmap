package com.realsport.model.utils;

public enum NotificationType {
        GET_ITEM("get_item_test"), ORDER_STATUS_CHANGE("order_status_change_test"), GET_SUBSCRIPTION("get_subscription_test"),
        SUBSCRIBTION_STATUS_CHANGE("subscription_status_change_test");

    private String name;
    NotificationType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
