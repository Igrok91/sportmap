package com.realsport.model.entity;

import java.io.Serializable;

public class CheckPlaygroundData implements Serializable {

    private Double lat;
    private Double lng;
    private String sport;
    private String userIdCreator;

    public CheckPlaygroundData(Double lat, Double lng, String sport, String userIdCreator) {
        this.lat = lat;
        this.lng = lng;
        this.sport = sport;
        this.userIdCreator = userIdCreator;
    }

    public CheckPlaygroundData() {
    }

    public Double getLat() {
        return lat;
    }

    public void setLat(Double lat) {
        this.lat = lat;
    }

    public Double getLng() {
        return lng;
    }

    public void setLng(Double lng) {
        this.lng = lng;
    }

    public String getSport() {
        return sport;
    }

    public void setSport(String sport) {
        this.sport = sport;
    }

    public String getUserIdCreator() {
        return userIdCreator;
    }

    public void setUserIdCreator(String userIdCreator) {
        this.userIdCreator = userIdCreator;
    }
}
