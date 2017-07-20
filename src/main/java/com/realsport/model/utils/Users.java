package com.realsport.model.utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
public class Users {

    private static Map<Integer, User> users = new HashMap<>();

    public static Map<Integer, User> getUsers() {
        return users;
    }
}
