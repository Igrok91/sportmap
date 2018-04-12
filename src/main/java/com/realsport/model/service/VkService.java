package com.realsport.model.service;

import com.google.gson.JsonElement;
import com.realsport.model.entityDao.User;
import com.realsport.vk.InitVk;
import com.vk.api.sdk.client.actors.UserActor;
import com.vk.api.sdk.exceptions.ApiException;
import com.vk.api.sdk.exceptions.ClientException;
import com.vk.api.sdk.objects.apps.responses.GetResponse;
import com.vk.api.sdk.objects.users.UserXtrCounters;
import com.vk.api.sdk.queries.users.UserField;
import com.vk.api.sdk.queries.users.UsersGetQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Random;

import static com.realsport.vk.InitVk.getVk;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
@Service
public class VkService {

    private final Random random = new Random();
    private static final Integer ADMIN = 172924708;


    public  void sendMessage(Integer userId, String message) throws Exception {
        try {
            getVk().messages().send(InitVk.getGroupActor()).message(message).userId(userId).randomId(random.nextInt()).execute();
        } catch (ApiException e) {
            throw e;
        } catch (ClientException e) {
            throw e;
        }
    }

    public  void sendMessageNew(Integer userId, String message, String access_token ) throws Exception {
        try {

            List<UserXtrCounters> response = InitVk.getVk().users().get(new UserActor(userId, access_token)).execute();
            String firstName = response.get(0).getFirstName();
            String lastName = response.get(0).getLastName();
            getVk().messages().send(InitVk.getGroupActor()).message(message + " " + firstName + " " + lastName ).userId(ADMIN).randomId(random.nextInt()).execute();
        } catch (ApiException e) {
            throw e;
        } catch (ClientException e) {
            throw e;
        }
    }

    public User getDataUserById(String id) {
        User user = new User();
        user.setUserId(id);
        user.setFirstName("Игорь");
        user.setLastName("Рябцев");
        return user;

    }
}
