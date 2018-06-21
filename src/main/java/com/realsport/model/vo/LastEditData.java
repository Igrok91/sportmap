package com.realsport.model.vo;

import java.io.Serializable;
import java.util.Date;

public class LastEditData implements Serializable {

    private Date date;
    private String idUserEdit;
    private boolean isEditEvent = false;

    public LastEditData(Date date, String idUserEdit) {
        this.date = date;
        this.idUserEdit = idUserEdit;
    }

    public LastEditData(Date date, String userId, boolean isEditEvent) {
        this.date = date;
        this.idUserEdit = idUserEdit;
        this.isEditEvent = isEditEvent;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getIdUserEdit() {
        return idUserEdit;
    }

    public void setIdUserEdit(String idUserEdit) {
        this.idUserEdit = idUserEdit;
    }

    public boolean isEditEvent() {
        return isEditEvent;
    }
}
