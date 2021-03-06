package com.realsport.model.entityDao;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class TemplateGame implements Serializable{
    private String templateId;
    private String description;
    private int countAnswer;
    private String duration;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    @Override
    public String toString() {
        return "TemplateGame{" +
                "description='" + description + '\'' +
                ", countAnswer=" + countAnswer +
                ", duration='" + duration + '\'' +
                '}';
    }
}
