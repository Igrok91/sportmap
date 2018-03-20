package com.realsport.model.entity;

import java.io.Serializable;
import java.util.List;

public class Template implements Serializable{
    private String description;
    private String answer;
    private String sel2;
    private String sel1;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getSel2() {
        return sel2;
    }

    public void setSel2(String sel2) {
        this.sel2 = sel2;
    }

    public String getSel1() {
        return sel1;
    }

    public void setSel1(String sel1) {
        this.sel1 = sel1;
    }
}
