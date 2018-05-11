package com.realsport.model.service;


import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.MinUser;
import com.realsport.model.entityDao.User;
import com.realsport.vk.InitVk;
import com.realsport.vk.InitVkMain;
import com.vk.api.sdk.client.VkApiClient;
import com.vk.api.sdk.client.actors.GroupActor;
import com.vk.api.sdk.client.actors.UserActor;
import com.vk.api.sdk.exceptions.ApiException;
import com.vk.api.sdk.exceptions.ClientException;

import com.vk.api.sdk.objects.base.BoolInt;
import com.vk.api.sdk.objects.users.UserXtrCounters;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.Random;

import static com.realsport.vk.InitVkMain.getVkApiClient;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
@Service
public class VkService {
    private Log logger = LogFactory.getLog(VkService.class);
    private final Random random = new Random();
    private static final Integer ADMIN = 172924708;
    private static final String LINK_EVENT = "https://vk.com/app6437488_-148660655#";


    public  void sendMessage(Integer userId, String message) throws Exception {
        try {
            logger.info(" Отправляем сообщение " + message + " пользователю " + userId);
            getVkApiClient().messages().send(InitVkMain.getGroupActor()).message(message).userId(userId).randomId(random.nextInt()).execute();
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        }
    }
    public  boolean isAllowSendMessages(Integer userId){
        BoolInt allowedQuery = null;
        try {
            allowedQuery = getVkApiClient().messages().isMessagesFromGroupAllowed(InitVkMain.getGroupActor(), userId).execute().getIsAllowed();
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        }
        logger.info("isAllowSendMessages " + allowedQuery);
        return allowedQuery != null && allowedQuery.getValue() == 1;
    }


    public  void sendMessageNew(Integer userId, String message, String access_token ) throws Exception {
        try {

            List<UserXtrCounters> response = InitVkMain.getVkApiClient().users().get(new UserActor(userId, access_token)).execute();
            String firstName = response.get(0).getFirstName();
            String lastName = response.get(0).getLastName();
            getVkApiClient().messages().send(InitVkMain.getGroupActor()).message(message + " " + firstName + " " + lastName ).userId(ADMIN).randomId(random.nextInt()).execute();
        } catch (ApiException e) {
            throw e;
        } catch (ClientException e) {
            throw e;
        }
    }

    public User getDataUserById(String userId, String access_token) {
        try {
            List<UserXtrCounters> response = getVkApiClient().users().get(new UserActor(Integer.valueOf(userId), access_token)).execute();
            String firstName = response.get(0).getFirstName();
            String lastName = response.get(0).getLastName();
            sendMessage(Integer.valueOf(userId), "firstName " + firstName + ", lastName " + lastName );
        } catch (ApiException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        User user = new User();
        user.setUserId(userId);
        user.setFirstName("Игорь");
        user.setLastName("Рябцев");
        return user;

    }

    public void sendMessagePublishEventToUsersGroup(List<MinUser> players, User userCreator, String descr, String idEvent, String namePlayground) {
        try {
            logger.info("Отправляем уведомление о созданни игры " + descr + ", id: " + idEvent);
            if (players.size() > 0) {
                VkApiClient vkApiClient = getVkApiClient();
                GroupActor groupActor = InitVkMain.getGroupActor();
                Integer userIdCreator = Integer.valueOf(userCreator.getUserId());
                int countSend = 0;
                for (MinUser user : players) {
                    Integer userId = Integer.valueOf(user.getUserId());
                    if (!Objects.equals(userId, userIdCreator)) {
                        if (isAllowSendMessages(userId) ) {
                            vkApiClient.messages().send(groupActor).message(" Открыт опрос в группе " + "\""
                                    + namePlayground + "\", " + userCreator.getFirstName() + " " + userCreator.getLastName() + ": \n"
                                    + descr + "\n" + LINK_EVENT + idEvent).userId(userId).randomId(random.nextInt()).execute();
                            countSend++;
                        }
                    }
                }
                if (isAllowSendMessages(userIdCreator)) {
                        vkApiClient.messages().send(groupActor)
                                .message("Вы успешно создали событие в группе " + "\"" + namePlayground + "\": \n"
                                        + LINK_EVENT +  idEvent)
                                .userId(userIdCreator).randomId(random.nextInt()).execute();

                }
                logger.info("Уведомление отправлено " + countSend + " участникам группы " + namePlayground);

            }
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        }
    }

    public void notifyDeleteUsersEvent(Event event, String idCreator) {
        try {
            List<User> userList = event.getUserList();
            if (userList.size() > 0) {
                logger.info("Отправляем уведомление о удалении игры ");
                VkApiClient vkApiClient = getVkApiClient();
                GroupActor groupActor = InitVkMain.getGroupActor();
                Integer userIdCreator = Integer.valueOf(idCreator);
                for (User user : userList) {
                    Integer userId = Integer.valueOf(user.getUserId());
                    if (!Objects.equals(userId, userIdCreator)) {
                        if (isAllowSendMessages(userId) && !user.isFake()) {
                            vkApiClient.messages().send(groupActor).message(event.getUserFirtsNameCreator() + " " + event.getUserLastNameCreator()
                                    + " удалил(а) опрос в группе " + "\"" + event.getPlaygroundName() + "\": \n"
                                    + event.getDescription()).userId(userId).randomId(random.nextInt()).execute();
                        }
                    }
                }

            }
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        }
    }

    public void notifyEndUsersEvent(Event event, String idCreator) {
        try {
            List<User> userList = event.getUserList();
            if (userList.size() > 0) {
                logger.info("Отправляем уведомление о завершении игры ");
                VkApiClient vkApiClient = getVkApiClient();
                GroupActor groupActor = InitVkMain.getGroupActor();
                Integer userIdCreator = Integer.valueOf(idCreator);
                for (User user : userList) {
                    Integer userId = Integer.valueOf(user.getUserId());
                    if (!Objects.equals(userId, userIdCreator)) {
                        if (isAllowSendMessages(userId) && !user.isFake()) {
                            vkApiClient.messages().send(groupActor).message(event.getUserFirtsNameCreator() + " " + event.getUserLastNameCreator()
                                    + " завершил(а) опрос в группе " + "\"" + event.getPlaygroundName() + "\": \n"
                                    + event.getDescription()  + "\n" + LINK_EVENT + event.getIdEvent()).userId(userId).randomId(random.nextInt()).execute();
                        }
                    }
                }
            }
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        }
    }
}
