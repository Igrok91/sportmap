package com.realsport.service;

import com.realsport.model.dao.DatastoreService;
import com.realsport.model.vo.SubscribtionInfoUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SubscriptionsService {

    @Autowired
    private DatastoreService databaseService;

    public SubscribtionInfoUser getSubscriptionStatusUser(String userId) {
        return databaseService.getSubscriptionStatusUser(userId);
    }

    public Long addSubscriptionToUser(Integer user_id, Integer subscription_id, String item_id, Integer item_price) {
        return databaseService.addSubscriptionToUser(user_id, subscription_id, item_id, item_price);
    }

    public Long setSubscriptionStatusUser(Integer user_id,  String cancel_reason, String status) {
        return databaseService.setSubscriptionStatusUser(user_id, cancel_reason, status);
    }

    public boolean isPremiumUser(String userId) {
        return databaseService.isPremiumUser(userId);
    }

}
