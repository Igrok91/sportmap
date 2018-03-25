package com.realsport.model.entityDao;

import java.util.List;
import java.util.Map;

public class User {
    private String userId;
    private String firstName;
    private String LastName;
    private boolean isAdmin;
    //Список id площадок
    private List<String> playgroundFootballList;
    private List<String> playgroundBasketList;
    private List<String> playgroundVoleyList;
    //Список id событий и значение проголосовал ли
    private Map<String, Boolean> eventListActive;
    //Список id событий
    private List<String> eventListPast;


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

    public Map<String, Boolean> getEventListActive() {
        return eventListActive;
    }

    public void setEventListActive(Map<String, Boolean> eventListActive) {
        this.eventListActive = eventListActive;
    }

    public List<String> getEventListPast() {
        return eventListPast;
    }

    public void setEventListPast(List<String> eventListPast) {
        this.eventListPast = eventListPast;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return LastName;
    }

    public void setLastName(String lastName) {
        LastName = lastName;
    }
}
