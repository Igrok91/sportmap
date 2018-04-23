package com.realsport.model.utils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Observer {

    private transient static List<Date> dateList = new ArrayList<>();

    public static List<Date> getDateList() {
        return dateList;
    }

    public static synchronized void addDateList(Date date) {
        if (dateList.size() > 1000) {
            dateList.clear();
        }
        Observer.dateList.add(date);
    }
}
