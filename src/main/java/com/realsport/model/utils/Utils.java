package com.realsport.model.utils;




public class Utils {
    private static final String ACTIVE = "active";
    private static final String CANCELLED = "cancelled";
    private static final String RESUME = "resume";
    private static final String NOT = "not";

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
