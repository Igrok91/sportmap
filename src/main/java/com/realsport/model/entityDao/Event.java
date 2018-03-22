package com.realsport.model.entityDao;

import java.util.Date;
import java.util.List;

public class Event {
    private String idEvent;
    private String userIdCreator;
    private String description;

    private List<String> listAnswer;
    private int countAnswer;
    private String duration;
    private String sport;
    private String playgroundId;
    private boolean active = true;
    private Date dateCreation;


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<String> getListAnswer() {
        return listAnswer;
    }

    public void setListAnswer(List<String> listAnswer) {
        this.listAnswer = listAnswer;
    }



    public int getCountAnswer() {
        return countAnswer;
    }

    public void setCountAnswer(int countAnswer) {
        this.countAnswer = countAnswer;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getIdEvent() {
        return idEvent;
    }

    public String getUserIdCreator() {
        return userIdCreator;
    }

    public void setUserIdCreator(String userIdCreator) {
        this.userIdCreator = userIdCreator;
    }

    public void setIdEvent(String idEvent) {
        this.idEvent = idEvent;

    }

    public String getSport() {
        return sport;
    }

    public void setSport(String sport) {
        this.sport = sport;
    }

    public String getPlaygroundId() {
        return playgroundId;
    }

    public void setPlaygroundId(String playgroundId) {
        this.playgroundId = playgroundId;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }
}
