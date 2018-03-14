package com.realsport.model.entityDao;

import java.util.List;

public class User {
    private String userId;
    private boolean isAdmin;
    private List<String> playgroundFootballList;
    private List<String> playgrounBasketList;
    private List<String> playgrounVoleyList;


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

    public List<String> getPlaygrounBasketList() {
        return playgrounBasketList;
    }

    public void setPlaygrounBasketList(List<String> playgrounBasketList) {
        this.playgrounBasketList = playgrounBasketList;
    }

    public List<String> getPlaygrounVoleyList() {
        return playgrounVoleyList;
    }

    public void setPlaygrounVoleyList(List<String> playgrounVoleyList) {
        this.playgrounVoleyList = playgrounVoleyList;
    }
}
