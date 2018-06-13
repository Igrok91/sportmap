package com.realsport.model.utils;




public class Utils {
    private static final String ACTIVE = "active";
    private static final String CANCELLED = "cancelled";
    private static final String RESUME = "resume";
    private static final String NOT = "not";

    public static String getSubstrictionStatusUser(String status) {
        switch (status) {
            case ACTIVE:
                return ACTIVE;
            case CANCELLED:
                return RESUME;
            default: return NOT;
        }
    }

}
