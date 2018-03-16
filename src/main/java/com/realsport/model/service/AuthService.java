package com.realsport.model.service;

import com.realsport.model.entityDao.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class AuthService {
    public boolean isRegister(String id) {
        return true;
    }

    public User getUser(String id) {
        return getUserStub(id);
    }

    private User getUserStub(String id) {
        User user = new User();
        user.setUserId(id);
        List<String> listFootball = new ArrayList<>();
        listFootball.add("10");
        listFootball.add("15");

        List<String> listBasket = new ArrayList<>();
        listBasket.add("7");
        listBasket.add("8");

        List<String> listVoley = new ArrayList<>();
        listVoley.add("7");
        listVoley.add("8");
        user.setPlaygroundBasketList(listBasket);
        user.setPlaygroundFootballList(listFootball);
        user.setPlaygroundVoleyList(listVoley);
        return user;

    }

    public User registerUser(String id) {
        return null;
    }
}
