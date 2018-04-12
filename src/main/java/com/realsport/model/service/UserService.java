package com.realsport.model.service;

import com.realsport.model.dao.DatastoreService;
import com.realsport.model.entityDao.TemplateGame;
import com.realsport.model.entityDao.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    @Autowired
    private DatastoreService databaseService;

    @Autowired
    private VkService vkService;

    public boolean isRegister(String id) {
        return true;
    }

    public User getUser(String id) {
        return databaseService.getUser(id);
    }

    private User getUserStub(String id) {
        User user = new User();
        user.setUserId(id);
        List<String> listFootball = new ArrayList<>();
        listFootball.add("15");

        List<String> listBasket = new ArrayList<>();
        listBasket.add("7");


        List<String> listVoley = new ArrayList<>();
        listVoley.add("7");
        listVoley.add("8");
        Map<String, Boolean> map = new HashMap<>();
        map.put("172924708", Boolean.TRUE);
        map.put("12345", Boolean.FALSE);

        user.setEventListActive(map);
        user.setFirstName("Игорь");
        user.setLastName("Рябцев");
        //user.setInfo("Все бесят");
        return user;

    }

    public User registerUser(String id) {
        User user = vkService.getDataUserById(id);
        databaseService.registerUser(user);
        return user;
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

    public void editUserInfo(String userInfo) {


    }

    public void addPlaygroundToUser(String userId, String playgroundId) {
        databaseService.addPlaygroundToUser(userId, playgroundId);
    }

    public void deletePlaygroundFromUser(String userId, String playgroundId) {
        databaseService.deletePlaygroundFromUser(userId, playgroundId);
    }
}
