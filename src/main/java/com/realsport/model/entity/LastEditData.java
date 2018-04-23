package com.realsport.model.entity;

import java.io.Serializable;
import java.util.Date;

public class LastEditData implements Serializable {

    private Date date;
    private String idUserEdit;

    public LastEditData(Date date, String idUserEdit) {
        this.date = date;
        this.idUserEdit = idUserEdit;
    }

    public LastEditData() {
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
}
