package com.realsport.model.entityDao;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class User implements Serializable {
    private String userId;
    private String firstName;
    private String LastName;
    private String info;
    private boolean isAdmin;
    private boolean isFake = false;
    private int countFake;
    //Список id площадок
    private List<String> playgroundFootballList;
    private List<String> playgroundBasketList;
    private List<String> playgroundVoleyList;
    //Список id событий и значение проголосовал ли
    private Map<String, Boolean> eventListActive = new HashMap<>();
    //Список id событий и количества игроков от пользователя
    private Map<String, Integer> count = new HashMap<>();
    //Список id событий
    private List<String> eventListPast = new ArrayList<>();


    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }

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

    public Map<String, Integer> getCount() {
        return count;
    }

    public void setCount(Map<String, Integer> count) {
        this.count = count;
    }

    public boolean isFake() {
        return isFake;
    }

    public void setFake(boolean fake) {
        isFake = fake;
    }

    public int getCountFake() {
        return countFake;
    }

    public void setCountFake(int countFake) {
        this.countFake = countFake;
    }
}
