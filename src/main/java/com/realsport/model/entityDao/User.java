package com.realsport.model.entityDao;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class User implements Serializable {
    private String userId;
    private String firstName;
    private String lastName;
    private String info;
    private boolean isAdmin = false;
    private boolean isFake = false;
    private int countFake;
    // Список id площадок
    private List<String> playgroundIdlList =  new ArrayList<>();
    // Список шаблонов пользователя
    private List<TemplateGame> templateGames =  new ArrayList<>();



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

    public List<String> getPlaygroundIdlList() {
        return playgroundIdlList;
    }

    public void setPlaygroundIdlList(List<String> playgroundIdlList) {
        this.playgroundIdlList = playgroundIdlList;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
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

    public List<TemplateGame> getTemplateGames() {
        return templateGames;
    }

    public void setTemplateGames(List<TemplateGame> templateGames) {
        this.templateGames = templateGames;
    }
    public void addTemplateGames(TemplateGame templateGames) {
        this.templateGames.add(templateGames);
    }

    @Override
    public String toString() {
        return "User{" +
                "userId='" + userId + '\'' +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                '}';
    }
}
