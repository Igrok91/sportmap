package com.realsport.model.dao.entityDao;

import java.io.Serializable;

public class EventUser implements Serializable {

    private Long eventId;
    private boolean isOrganize = false;


    public EventUser() {
    }

    public EventUser(Long eventId, boolean isOrganize) {
        this.eventId = eventId;
        this.isOrganize = isOrganize;
    }


    public Long getEventId() {
        return eventId;
    }

    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }

    public boolean isOrganize() {
        return isOrganize;
    }

    public void setOrganize(boolean organize) {
        isOrganize = organize;
    }
}
