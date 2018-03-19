package com.realsport.model.entityDao;

import java.util.ArrayList;
import java.util.List;

public class TemplateGame {
    private String description;
    private String templateId;
    private List<String> listAnswer;

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
}
