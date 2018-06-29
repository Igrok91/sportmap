package com.realsport.utils;

public enum KindSport {
    FOOTBALL("Футбол"), BASKETBALL("Баскетбол"), VOLEYBALL("Волейбол");

    private String sport;

    KindSport(String sport) {
        this.sport = sport;
    }

    public String getSport() {
        return sport;
    }
}
