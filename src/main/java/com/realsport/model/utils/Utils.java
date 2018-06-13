package com.realsport.model.utils;




public class Utils {
    public static final String ACTIVE = "active";
    public static final String CANCELLED = "cancelled";
    public static final String RESUME = "resume";
    public static final String NOT = "not";

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

}
