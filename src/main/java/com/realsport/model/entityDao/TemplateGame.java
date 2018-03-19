package com.realsport.model.entityDao;

import java.util.ArrayList;
import java.util.List;

public class TemplateGame {
    private String description;
    private String templateId;
    private List<String> listAnswer;
    private int countAnswer;
    private String duration;

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

    public String getTemplateId() {
        return templateId;
    }

    public void setTemplateId(String templateId) {
        this.templateId = templateId;
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
}
