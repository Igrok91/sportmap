package com.realsport.utils;


import com.google.cloud.Timestamp;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

public class Utils {
    public static final String ACTIVE = "active";
    public static final String CANCELLED = "cancelled";
    public static final String TEMP = "temp";
    public static final String RESUME = "resume";
    public static final String NOT = "not";
    private static final String API_SECRET = "mAA69jjqE2uP5w6nDINz";
    public static final Long DURATION = 86400000L;
    public static final Integer DURATION_SUBSCRIBE = 90;

    public static String getSubstrictionStatusUser(String status) {
        if (status == null) {
            return NOT;
        } else if (status.equals(ACTIVE)) {
            return ACTIVE;
        } else if (status.equals(CANCELLED)) {
            return RESUME;
        }
        return NOT;
    }

    public static boolean isActiveSubscriptionsTemp(Timestamp subscriptionsTemp) {
        if (subscriptionsTemp == null) {
            return false;
        }
        java.sql.Timestamp timestampValue = subscriptionsTemp.toSqlTimestamp();
        Long durationSubscribe = DURATION * DURATION_SUBSCRIBE;
        Date dateUserEnd = new Date(timestampValue.getTime() + durationSubscribe);
        Date now = new Date();
        return now.before(dateUserEnd);
    }

    public static int getCountDaytoEndSubscribe(Timestamp subscriptionsTemp) {
        java.sql.Timestamp timestampValue = subscriptionsTemp.toSqlTimestamp();
        Long durationSubscribe = DURATION * DURATION_SUBSCRIBE;
        Long dateUserEnd = timestampValue.getTime() + durationSubscribe;
        Long now = new Date().getTime();
        double end = (dateUserEnd - now) / DURATION;

        return (int) Math.ceil(end);
    }

    public static String getSortParam(String notification_type,
                                      Integer app_id, Integer user_id, Integer receiver_id, String item,
                                      Integer order_id, String cancel_reason, String item_id, String status,
                                      Integer item_price, Integer pending_cancel, Integer subscription_id,
                                      String lang) {
        List<String> list = new ArrayList<>();
        if (notification_type != null) {
            list.add("notification_type=" + notification_type);
        }
        if (app_id != null) {
            list.add("app_id=" + String.valueOf(app_id));
        }

        if (user_id != null) {
            list.add("user_id=" + String.valueOf(user_id));
        }
        if (receiver_id != null) {
            list.add("receiver_id=" + String.valueOf(receiver_id));
        }
        if (item != null) {
            list.add("item=" + item);
        }
        if (order_id != null) {
            list.add("order_id=" + String.valueOf(order_id));
        }
        if (cancel_reason != null) {
            list.add("cancel_reason=" + cancel_reason);
        }
        if (item_id != null) {
            list.add("item_id=" + item_id);
        }
        if (status != null) {
            list.add("status=" + status);
        }
        if (item_price != null) {
            list.add("item_price=" + String.valueOf(item_price));
        }
        if (pending_cancel != null) {
            list.add("pending_cancel=" + String.valueOf(pending_cancel));
        }
        if (subscription_id != null) {
            list.add("subscription_id=" + String.valueOf(subscription_id));
        }
        if (lang != null) {
            list.add("lang=" + lang);
        }

        Collections.sort(list);
        StringBuilder stringBuilder = new StringBuilder();
        for (String s : list) {
            stringBuilder.append(s);
        }
        stringBuilder.append(API_SECRET);
        return stringBuilder.toString();
    }
}
