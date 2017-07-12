package com.realsport.model.utils;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
public class Users {

    private static Set<Integer> users = new HashSet<>();

    public static Set<Integer> getUsers() {
        return users;
    }
}
