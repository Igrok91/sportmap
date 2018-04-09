package com.realsport.model.dao;

import com.google.cloud.datastore.*;
import com.realsport.model.dao.kinds.*;
import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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


    public void publishEvent(Event game) {
        //KeyFactory  keyFactory = getKeyFactory(EVENT);
       // keyFactory.setKind(EVENT);
        //Key key = datastore.allocateId(keyFactory.newKey());
        logger.info("Публикация события " + game.getDescription() + " Sport " + game.getSport());
        if (game.getSport().equals(FOOTBALL)) {
            events.setKeyFactory(EVENTS_FOOTBALL);
            events.publishEvent(game);
        } else if (game.getSport().equals(VOLEYBALL)) {
            events.setKeyFactory(EVENTS_VOLEYBALL);
            events.publishEvent(game);
        } else if (game.getSport().equals(BASKETBALL)) {
            events.setKeyFactory(EVENTS_BASKETBALL);
            events.publishEvent(game);
        }
    }

    public void registerUser(User user) {
         users.registerUser(user);
    }

    public User getUser(String id) {
        return users.getUser(id);
    }

    public List<Event> getEventsFootballOfGroupUser(List<String> playgroundFoottUser) {
        return events.eventsFootballOfGroupUser(playgroundFoottUser);

    }

    public List<User> getPlayersGroup(String id, String playgroundKind) {
        playgrounds.setKeyFactory(playgroundKind);
        return null;
    }
}
