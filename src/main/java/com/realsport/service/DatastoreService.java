package com.realsport.service;

import com.realsport.dao.kinds.Events;
import com.realsport.dao.kinds.Notifications;
import com.realsport.dao.kinds.Playgrounds;
import com.realsport.dao.kinds.Users;
import com.realsport.model.vo.CheckPlaygroundData;
import com.realsport.dao.vo.Comment;
import com.realsport.dao.vo.Event;
import com.realsport.dao.vo.EventUser;
import com.realsport.model.vo.MinUser;
import com.realsport.dao.vo.Playground;
import com.realsport.dao.vo.TemplateGame;
import com.realsport.dao.vo.User;
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
    private Notifications notifications;


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


    public void addPlaygroundToCheck(Double lat, Double lng, String sport, String userId) {
        notifications.addPlaygroundToCheck(lat, lng, sport, userId);
    }

    public List<CheckPlaygroundData> getPlaygroundsCheck() {
        return notifications.getPlaygroundsCheck();
    }

    public Long addPlaygroundToDB(String userId, String lat, String lng, String name, String city, String street, String house, String sport) {
        return playgrounds.addPlaygroundToDB(userId, lat, lng, name, city, street, house, sport);
    }

    public void deleteNotification(String idPlayground) {
        notifications.deleteNotification(idPlayground);
    }

    public void addSubscriptionsTemp(String userId) {
        users.addSubscriptionsTemp(userId);
    }
}
