package com.realsport.model.vo;

import java.util.ArrayList;

public class PlaygroundInfo {
    ArrayList<String> footLocationList = new ArrayList<>();
    ArrayList<String> basketLocationList = new ArrayList<>();
    ArrayList<String> voleyLocationList = new ArrayList<>();

    ArrayList<String> footInfoList = new ArrayList<>();
    ArrayList<String> basketInfoList = new ArrayList<>();
    ArrayList<String> voleyballInfoList = new ArrayList<>();

    public ArrayList<String> getFootLocationList() {
        return footLocationList;
    }

    public void setFootLocationList(ArrayList<String> footLocationList) {
        this.footLocationList = footLocationList;
    }

    public ArrayList<String> getBasketLocationList() {
        return basketLocationList;
    }

    public void setBasketLocationList(ArrayList<String> basketLocationList) {
        this.basketLocationList = basketLocationList;
    }

    public ArrayList<String> getVoleyLocationList() {
        return voleyLocationList;
    }

    public void setVoleyLocationList(ArrayList<String> voleyLocationList) {
        this.voleyLocationList = voleyLocationList;
    }

    public ArrayList<String> getFootInfoList() {
        return footInfoList;
    }

    public void setFootInfoList(ArrayList<String> footInfoList) {
        this.footInfoList = footInfoList;
    }

    public ArrayList<String> getBasketInfoList() {
        return basketInfoList;
    }

    public void setBasketInfoList(ArrayList<String> basketInfoList) {
        this.basketInfoList = basketInfoList;
    }

    public ArrayList<String> getVoleyballInfoList() {
        return voleyballInfoList;
    }

    public void setVoleyballInfoList(ArrayList<String> voleyballInfoList) {
        this.voleyballInfoList = voleyballInfoList;
    }
}
