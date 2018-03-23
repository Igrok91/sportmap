package com.realsport.model.entityDao;

import java.util.Date;
import java.util.List;

public class Event {
    private String idEvent;
    private String userIdCreator;
    private String userFirtsNameCreator;
    private String userLastNameCreator;
    private String description;

    private String answer;
    private int maxCountAnswer;
    private String duration;
    private String sport;
    private String playgroundId;
    private String playgroundName;
    private boolean active = true;
    private Date dateCreation;
    private String date;
    private List<User> userList;
    private List<Comment> commentsList;
    private List<HistoryEvent> historyEvent;



    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }





    public int getMaxCountAnswer() {
        return maxCountAnswer;
    }

    public void setMaxCountAnswer(int maxCountAnswer) {
        this.maxCountAnswer = maxCountAnswer;
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

    public String getPlaygroundName() {
        return playgroundName;
    }

    public void setPlaygroundName(String playgroundName) {
        this.playgroundName = playgroundName;
    }

    public String getUserFirtsNameCreator() {
        return userFirtsNameCreator;
    }

    public void setUserFirtsNameCreator(String userFirtsNameCreator) {
        this.userFirtsNameCreator = userFirtsNameCreator;
    }

    public String getUserLastNameCreator() {
        return userLastNameCreator;
    }

    public void setUserLastNameCreator(String userLastNameCreator) {
        this.userLastNameCreator = userLastNameCreator;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

    public List<Comment> getCommentsList() {
        return commentsList;
    }

    public void setCommentsList(List<Comment> commentsList) {
        this.commentsList = commentsList;
    }

    public List<HistoryEvent> getHistoryEvent() {
        return historyEvent;
    }

    public void setHistoryEvent(List<HistoryEvent> historyEvent) {
        this.historyEvent = historyEvent;
    }
}
