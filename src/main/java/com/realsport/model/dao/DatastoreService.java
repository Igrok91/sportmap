package com.realsport.model.dao;

import com.google.cloud.datastore.*;
import com.realsport.model.dao.kinds.*;
import com.realsport.model.entityDao.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class DatastoreService {

    private Log logger = LogFactory.getLog(DatastoreService.class);


    public static final String FOOTBALL = "Футбол";
    public static final String BASKETBALL = "Баскетбол";
    public static final String VOLEYBALL = "Волейбол";

    public static final String EVENTS_FOOTBALL = "EventsFootball";
    public static final String EVENTS_BASKETBALL = "EventsBasketball";
    public static final String EVENTS_VOLEYBALL = "EventsVoleyball";

    private static final String PROJECT_ID = "testdatastore-199913";
    private static final String NAMESPACE = "sportMap";
    private static final String EVENT = "Events";
    private static final String API_KEY = "AIzaSyAsU2pmAvoBerONIfy-nvtyLpSFKOAFWI8";

    private DatastoreOptions options;
    private Datastore datastore;
    private KeyFactory keyFactory;


    @Autowired
    private Events events;

    @Autowired
    private Users users;

    @Autowired
    private Playgrounds playgrounds;



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
     * @param game
     */
    public void publishEvent(Event game) {
        //KeyFactory  keyFactory = getKeyFactory(EVENT);
       // keyFactory.setKind(EVENT);
        //Key key = datastore.allocateId(keyFactory.newKey());
        logger.info("Публикация события " + game.getDescription() + " Sport " + game.getSport());
        events.publishEvent(game);
    }

    public void registerUser(User user) {
         users.registerUser(user);
    }

    public User getUser(String id) {
        return users.getUser(id);
    }

    /**
     * Получение футбольныйх событий по группам пользователя
     * @return
     */
    public List<Event> getAllEvents() {
        return events.getAllActiveEvents();
    }


    /**
     * Получение всех  площадок
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


    public void addPlaygroundToEventListActive(String playgroundId, String userId) {
        users.addPlaygroundToEventListActive(playgroundId, userId);
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

    public void removeTemplateUser(String templateId, String id) {
        users.removeTemplateUser(templateId, id);
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
}
