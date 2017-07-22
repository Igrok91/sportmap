package com.realsport.model.service;

import com.realsport.vk.initVk;
import com.vk.api.sdk.exceptions.ApiException;
import com.vk.api.sdk.exceptions.ClientException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
@Service
public class VkMessageService {

    private final Random random = new Random();

    @Autowired
    private initVk initVk;

    public void sendMessage(Integer userId, String message) throws Exception {
        try {
            initVk.getVk().messages().send(initVk.getGroupActor()).message(message).userId(userId).randomId(random.nextInt()).execute();
        } catch (ApiException e) {
            throw e;
        } catch (ClientException e) {
            throw e;
        }
    }
}
