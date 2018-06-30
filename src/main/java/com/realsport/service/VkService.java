package com.realsport.service;


import com.realsport.dao.vo.Event;
import com.realsport.model.vo.MinUser;
import com.realsport.dao.vo.User;
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
import org.springframework.scheduling.annotation.Async;
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
    private static final String LINK_APPLICATION = "https://vk.com/app6437488_-148660655";
    private static final String LINK_PLAYGROUND = "https://vk.com/app6437488_-148660655#pid=";
    private static final Integer APP_ID = 6437488;
    private static final String ACCESS_TOKEN = "d65021c0d65021c0d65021c019d634973ddd650d65021c08d4ae151d8bec8618a7565f0";


    @Async
    public void sendMessage(Integer userId, String message) throws Exception {
        try {
            logger.info(" Отправляем сообщение " + message + " пользователю " + userId);
            getVkApiClient().messages().send(InitVkMain.getGroupActor()).message(message).userId(userId).randomId(random.nextInt()).execute();
            Thread.sleep(1000);
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        }
    }

    public boolean isAllowSendMessages(Integer userId) {
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


    public void sendMessageNew(Integer userId, String message, String access_token) throws Exception {
        try {

            List<UserXtrCounters> response = InitVkMain.getVkApiClient().users().get(new UserActor(userId, access_token)).execute();
            String firstName = response.get(0).getFirstName();
            String lastName = response.get(0).getLastName();
            getVkApiClient().messages().send(InitVkMain.getGroupActor()).message(message + " " + firstName + " " + lastName).userId(ADMIN).randomId(random.nextInt()).execute();
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
            sendMessage(Integer.valueOf(userId), "firstName " + firstName + ", lastName " + lastName);
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

    @Async
    public void sendMessagePublishEventToUsersGroup(List<MinUser> players, User userCreator, String descr, String idEvent, String namePlayground) {
        try {
            logger.info("Отправляем уведомление о созданни игры " + descr + ", id: " + idEvent);
            logger.info("user size: " + players.size());
            if (players.size() > 0) {
                VkApiClient vkApiClient = getVkApiClient();
                GroupActor groupActor = InitVkMain.getGroupActor();
                Integer userIdCreator = Integer.valueOf(userCreator.getUserId());
                int countSend = 0;
                    for (MinUser user : players) {
                        Integer userId = Integer.valueOf(user.getUserId());
                        if (!Objects.equals(userId, userIdCreator)) {
                            try {
                                if (isAllowSendMessages(userId)) {
                                    Thread.sleep(1000);
                                    vkApiClient.messages().send(groupActor).message("Открыт опрос в группе " + "\""
                                            + namePlayground + "\", " + userCreator.getFirstName() + " " + userCreator.getLastName() + ": \n"
                                            + getMinText(descr) + "\n" + LINK_APPLICATION).userId(userId).randomId(random.nextInt()).execute();
                                    countSend++;
                                }
                            } catch (Exception e) {
                                logger.warn(e);
                            }
                            Thread.sleep(3000);
                        }
                    }
                Thread.sleep(3000);

                if (isAllowSendMessages(userIdCreator)) {
                    Thread.sleep(1000);
                    vkApiClient.messages().send(groupActor)
                            .message("Вы успешно открыли опрос в группе " + "\"" + namePlayground + "\": \n"
                                    + LINK_APPLICATION + "#" + idEvent)
                            .userId(userIdCreator).randomId(random.nextInt()).execute();

                }
                logger.info("Уведомление отправлено " + countSend + " участникам группы " + namePlayground);
            }
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        } catch (InterruptedException e) {
            logger.error(e);
        }
    }

    @Async
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
                            Thread.sleep(1000);
                            vkApiClient.messages().send(groupActor).message(event.getUserFirtsNameCreator() + " " + event.getUserLastNameCreator()
                                    + " удалил(а) опрос в группе " + "\"" + event.getPlaygroundName() + "\": \n"
                                    + getMinText(event.getDescription())).userId(userId).randomId(random.nextInt()).execute();
                        }
                        Thread.sleep(1000);
                    }
                }

            }
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        } catch (InterruptedException e) {
            logger.error(e);
        }
    }

    @Async
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
                            Thread.sleep(1000);
                            vkApiClient.messages().send(groupActor).message(event.getUserFirtsNameCreator() + " " + event.getUserLastNameCreator()
                                    + " завершил(а) опрос в группе " + "\"" + event.getPlaygroundName() + "\": \n"
                                    + getMinText(event.getDescription()) + "\n" + LINK_APPLICATION + "#" + event.getIdEvent()).userId(userId).randomId(random.nextInt()).execute();
                        }
                        Thread.sleep(1000);
                    }

                }
            }
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        } catch (InterruptedException e) {
            logger.error(e);
        }
    }

    @Async
    public void notifyOrganisatorUserAnswer(String id, String idCreator, String eventId) {
        try {
            logger.info("Отправляем уведомление организатору игры, что пользователь отменил голос");
            VkApiClient vkApiClient = getVkApiClient();
            GroupActor groupActor = InitVkMain.getGroupActor();
            Integer userIdCreator = Integer.valueOf(idCreator);
            Integer userId = Integer.valueOf(id);
            if (!Objects.equals(userId, userIdCreator)) {
                if (isAllowSendMessages(userIdCreator)) {
                    Thread.sleep(1000);
                    vkApiClient.messages().send(groupActor).message("Пользователь https://vk.com/id" + userId
                            + " отменил голос: \n"
                            + LINK_APPLICATION).userId(userIdCreator).randomId(random.nextInt()).execute();
                }
            }
        } catch (ApiException e) {
            logger.error(e);
        } catch (ClientException e) {
            logger.error(e);
        } catch (InterruptedException e) {
            logger.error(e);
        }
    }

    private String getMinText(String description) {
        String minText = description;
        if (description.length() > 35) {
            minText = description.substring(0, 30) + "...";
        }
        return minText;
    }

    @Async
    public void notifyNewUserInvite(User user, String namePlayground, List<MinUser> players, String idplayground) {
        try {
            logger.info("Отправляем уведомление о вступлении участника   " + user);
            if (players.size() > 0) {
                VkApiClient vkApiClient = getVkApiClient();
                GroupActor groupActor = InitVkMain.getGroupActor();

                Integer userIdCreator = Integer.valueOf(user.getUserId());
                int countSend = 0;
                for (MinUser minUser : players) {
                    Integer userId = Integer.valueOf(minUser.getUserId());
                    if (!Objects.equals(userId, userIdCreator)) {
                        try {
                            if (isAllowSendMessages(userId)) {
                                Thread.sleep(1000);
                                vkApiClient.messages().send(groupActor).message("Новый игрок в группе "
                                        + "\"" + namePlayground + "\": \n" + LINK_PLAYGROUND + idplayground).userId(userId).randomId(random.nextInt()).execute();
                                countSend++;
                            }

                        } catch (Exception e) {
                            logger.warn(e);
                        }
                        Thread.sleep(3000);
                    }
                }
                logger.info("Уведомление отправлено " + countSend + " участникам группы " + namePlayground);
            }
        } catch (InterruptedException e) {
            logger.error(e);
        }
    }
}
