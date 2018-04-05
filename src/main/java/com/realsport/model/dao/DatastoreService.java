package com.realsport.model.dao;

import com.google.cloud.datastore.*;
import com.realsport.model.entityDao.Event;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class DatastoreService {

    private Logger logger = LoggerFactory.getLogger(DatastoreService.class);
    private static final String PROJECT_ID = "testdatastore-199913";
    private static final String NAMESPACE = "sportMap";
    private static final String EVENT = "Events";
    private static final String API_KEY = "AIzaSyAsU2pmAvoBerONIfy-nvtyLpSFKOAFWI8";

    private DatastoreOptions options;
    private Datastore datastore;
    private KeyFactory keyFactory;

    @Autowired
    private Events events;

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
        events.publishEvent(game);

    }
}
