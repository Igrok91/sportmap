package com.realsport.model.service;

import com.realsport.model.dao.DatastoreService;
import com.realsport.model.entityDao.MinUser;
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
        User user = databaseService.getUser(id);
        return user;
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

        //user.setEventListActive(map);
        user.setFirstName("Игорь");
        user.setLastName("Рябцев");
        //user.setInfo("Все бесят");
        return user;

    }

    public void registerUser(String userId, String first_name, String last_name, String photo_50, String photo_100) {

        databaseService.registerUser(userId, first_name, last_name, photo_50, photo_100);
    }

    public List<TemplateGame> getTemplatesUserById(String userId) { ;
        return databaseService.getTemplatesUserById(userId);
    }

    public void removeTemplateUser(String id) {
         databaseService.removeTemplateUser(id);
    }

    public String saveTemplateUser(TemplateGame template, String userId) {
       return databaseService.saveTemplateUser(template, userId);

    }

    public void editUserInfo(String userInfo, String userId) {
            databaseService.editUserInfo(userInfo, userId);
    }

    public void addPlaygroundToUser(String userId, String playgroundId) {
        databaseService.addPlaygroundToUser(userId, playgroundId);
    }

    public void deletePlaygroundFromUser(String userId, String playgroundId) {
        databaseService.deletePlaygroundFromUser(userId, playgroundId);
    }

    public void addPlaygroundToEventListActive(String playgroundId, String userId) {
        databaseService.addPlaygroundToEventListActive(playgroundId, userId);
    }


    public void addEventToUserParticipant(List<User> userList, Long eventId, String userId) {
        databaseService.addEventToUserParticipant(userList, eventId, userId);
    }
}
