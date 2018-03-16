package com.realsport.model.entityDao;

import java.util.List;

public class User {
    private String userId;
    private boolean isAdmin;
    private List<String> playgroundFootballList;
    private List<String> playgroundBasketList;
    private List<String> playgroundVoleyList;


    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public boolean isAdmin() {
        return isAdmin;
    }

    public void setAdmin(boolean admin) {
        isAdmin = admin;
    }

    public List<String> getPlaygroundFootballList() {
        return playgroundFootballList;
    }

    public void setPlaygroundFootballList(List<String> playgroundFootballList) {
        this.playgroundFootballList = playgroundFootballList;
    }

    public List<String> getPlaygroundBasketList() {
        return playgroundBasketList;
    }

    public void setPlaygroundBasketList(List<String> playgroundBasketList) {
        this.playgroundBasketList = playgroundBasketList;
    }

    public List<String> getPlaygroundVoleyList() {
        return playgroundVoleyList;
    }

    public void setPlaygroundVoleyList(List<String> playgroundVoleyList) {
        this.playgroundVoleyList = playgroundVoleyList;
    }
}
