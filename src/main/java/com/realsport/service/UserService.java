package com.realsport.service;

import com.realsport.model.dao.DatastoreService;

import com.realsport.model.dao.entityDao.TemplateGame;
import com.realsport.model.dao.entityDao.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private DatastoreService databaseService;

    public User getUser(String id) {
        User user = databaseService.getUser(id);
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

    public void addEventToUserParticipant(List<User> userList, Long eventId, String userId) {
        databaseService.addEventToUserParticipant(userList, eventId, userId);
    }

    public void addSubscriptionsTemp(String userId) {
        databaseService.addSubscriptionsTemp(userId);
    }
}
