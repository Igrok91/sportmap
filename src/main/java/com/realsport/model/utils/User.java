package com.realsport.model.utils;

import java.util.Date;

/**
 * Created by IgorR on 20.07.2017.
 */
public class User {
    private int id;
    private int countSendMessage;
    private boolean messageDisabled;
    private Date date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCountSendMessage() {
        return countSendMessage;
    }

    public void setCountSendMessage(int countSendMessage) {
        this.countSendMessage = countSendMessage;
    }

    public boolean isMessageDisabled() {
        return messageDisabled;
    }

    public void setMessageDisabled(boolean messageDisabled) {
        this.messageDisabled = messageDisabled;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }
}


