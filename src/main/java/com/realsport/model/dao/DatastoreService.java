package com.realsport.model.dao;

import com.realsport.model.dao.kinds.Events;
import com.realsport.model.dao.kinds.Playgrounds;
import com.realsport.model.dao.kinds.Subscriptions;
import com.realsport.model.dao.kinds.Users;
import com.realsport.model.entityDao.Comment;
import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.EventUser;
import com.realsport.model.entityDao.MinUser;
import com.realsport.model.entityDao.Playground;
import com.realsport.model.entityDao.TemplateGame;
import com.realsport.model.entityDao.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DatastoreService {

    private Log logger = LogFactory.getLog(DatastoreService.class);


    @Autowired
    private Events events;

    @Autowired
    private Users users;

    @Autowired
    private Playgrounds playgrounds;

    @Autowired
    private Subscriptions subscriptions;


    {
      /*  GoogleCredentials credentials = null;
        File credentialsPath = new File("src/main/resources/TestDatastore-a80d177b4553.json");
        try (FileInputStream serviceAccountStream = new FileInputStream(this.getClass().getResource("/TestDatastore-a80d177b4553.json").getFile())) {
            credentials = GoogleCredentials.fromStream(serviceAccountStream).toBuilder().setAccessToken(new AccessToken(API_KEY, null)).build();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }*/

        //options = DatastoreOptions.newBuilder().setCredentials(credentials).setNamespace(EVENT).build();
        //datastore = DatastoreOptions.getDefaultInstance().getService();
        //keyFactory = datastore.newKeyFactory();

    }

    public DatastoreService() {
    }

    /**
     * Публикация события
     *
     * @param game
     */
    public void publishEvent(Event game) {
        logger.info("Публикация события " + game.getDescription() + " Sport " + game.getSport());
        events.publishEvent(game);
    }


    public User getUser(String id) {
        return users.getUser(id);
    }

    /**
     * Получение футбольныйх событий по группам пользователя
     *
     * @return
     */
    public List<Event> getAllEvents() {
        return events.getAllActiveEvents();
    }


    /**
     * Получение всех  площадок
     *
     * @return
     */
    public List<Playground> getAllPlayground() {
        return playgrounds.getAllPlayground();
    }

    public Playground getPlaygroundById(String idGroup) {
        return playgrounds.getPlaygroundById(idGroup);
    }

    public void addUserToPlayground(MinUser user, String playgroundId) {
        playgrounds.addUserToPlayground(user, playgroundId);
    }

    public void deleteUserFromPlayground(String userId, String playgroundId) {
        playgrounds.deleteUserFromPlayground(userId, playgroundId);
    }

    public void deletePlaygroundFromUser(String userId, String playgroundId) {
        users.deletePlaygroundFromUser(userId, playgroundId);
    }

    public void addPlaygroundToUser(String userId, String playgroundId) {
        users.addPlaygroundToUser(userId, playgroundId);
    }


    public void addUserToEvent(String eventId, User user, boolean isFake) {
        events.addUserToEvent(eventId, user, isFake);
    }

    public void deleteUserFromEvent(String eventId, String userId) {
        events.deleteUserFromEvent(eventId, userId);
    }

    public Event getEventById(String eventId) {
        return events.getEventById(eventId);
    }

    public List<TemplateGame> getTemplatesUserById(String userId) {
        return users.getTemplatesUserById(userId);
    }

    public String saveTemplateUser(TemplateGame template, String userId) {
        return users.saveTemplateUser(template, userId);
    }

    public void removeTemplateUser(String id) {
        users.removeTemplateUser(id);
    }

    public Event createEventByTemplate(String templateId, String id) {
        return users.createEventByTemplate(templateId, id);
    }

    public void editEventById(String eventId, String description, int maxCountAnswer, String duration) {
        events.editEventById(eventId, description, maxCountAnswer, duration);
    }

    public void deleteGame(String eventId) {
        events.deleteGame(eventId);
    }

    public void endGame(String eventId) {
        events.endGame(eventId);
    }

    public String addCommentToEvent(String eventId, Comment message) {
        return events.addCommentToEvent(eventId, message);
    }

    public void deleteCommentFromEvent(String commentId, String eventId) {
        events.deleteCommentFromEvent(commentId, eventId);
    }

    public List<Event> getEventsByIdGroup(String id) {
        return events.getEventsByIdGroup(id);
    }

    public List<Event> getActiveEventsByIdGroup(String playgroundId) {
        return events.getActiveEventsByIdGroup(playgroundId);
    }

    public void editUserInfo(String userInfo, String userId) {
        users.editUserInfo(userInfo, userId);
    }

    public List<Event> getEventUserParticipantorOrganize(List<EventUser> listParticipant) {
        return events.getEventUserParticipantorOrganize(listParticipant);
    }


    public void addEventToUserParticipant(List<User> userList, Long eventId, String userId) {
        users.addEventToUserParticipant(userList, eventId, userId);
    }

    public void registerUser(String userId, String first_name, String last_name, String photo_50, String photo_100) {
        users.registerUser(userId, first_name, last_name, photo_50, photo_100);
    }

    public String getSubscriptionStatusUser(String userId) {
        return subscriptions.getSubscriptionStatusUser(userId);
    }

    public Integer addSubscriptionToUser(Integer user_id, Integer subscription_id, String item_id, Integer item_price) {
        return subscriptions.addSubscriptionToUser(user_id, subscription_id, item_id, item_price);
    }

    public Integer setSubscriptionStatusUser(Integer user_id, Integer subscription_id, String item_id, String cancel_reason, String status) {
        return subscriptions.setSubscriptionStatusUser(user_id, subscription_id, item_id, cancel_reason, status);
    }
}
