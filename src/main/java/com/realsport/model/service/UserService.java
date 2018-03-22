package com.realsport.model.service;

import com.realsport.model.entityDao.TemplateGame;
import com.realsport.model.entityDao.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService {
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

    public List<TemplateGame> getTemplatesUserById(String userId) {
        List<TemplateGame> list = new ArrayList<>();
        List<String> listAnswer = new ArrayList<>();
        listAnswer.add("+");

        TemplateGame game = new TemplateGame();
        game.setTemplateId("1");
        game.setDescription("Го на игру в 7?");
        game.setListAnswer(listAnswer);
        TemplateGame game2 = new TemplateGame();
        game2.setTemplateId("2");
        game2.setDescription("Го на игру в 8?");
        game2.setListAnswer(listAnswer);
        list.add(game);
        list.add(game2);
        return list;
    }

    public void removeTemplateUser(String id, String templateId) {

    }

    public int saveTemplateUser(TemplateGame templateId, String userId) {

        return 3;
    }
}
