package com.realsport.model.service;

import com.realsport.model.dao.DatastoreService;
import com.realsport.model.entityDao.TemplateGame;
import com.realsport.model.entityDao.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SubscriptionsService {

    @Autowired
    private DatastoreService databaseService;

    public String getSubscriptionStatusUser(String userId) {
        return databaseService.getSubscriptionStatusUser(userId);
    }

    public Integer addSubscriptionToUser(Integer user_id, Integer subscription_id, String item_id, Integer item_price) {
        return databaseService.addSubscriptionToUser(user_id, subscription_id, item_id, item_price);
    }

    public Integer setSubscriptionStatusUser(Integer user_id, Integer subscription_id, String item_id, String cancel_reason, String status) {
        return databaseService.setSubscriptionStatusUser(user_id, subscription_id, item_id, cancel_reason, status);
    }
}
