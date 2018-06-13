package com.realsport.model.entity;

import java.io.Serializable;

public class SubscribeInfo implements Serializable {

    private String title;
    private String photo_url;
    private Integer item_id ;
    private Integer price;
    private Integer period;

    public SubscribeInfo(String title, String photo_url, Integer item_id, Integer price, Integer period) {
        this.title = title;
        this.photo_url = photo_url;
        this.item_id = item_id;
        this.price = price;
        this.period = period;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPhoto_url() {
        return photo_url;
    }

    public void setPhoto_url(String photo_url) {
        this.photo_url = photo_url;
    }

    public Integer getItem_id() {
        return item_id;
    }

    public void setItem_id(Integer item_id) {
        this.item_id = item_id;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public Integer getPeriod() {
        return period;
    }

    public void setPeriod(Integer period) {
        this.period = period;
    }
}
