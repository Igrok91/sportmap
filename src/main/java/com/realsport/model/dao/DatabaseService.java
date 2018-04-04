package com.realsport.model.dao;

import com.google.auth.oauth2.AccessToken;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.auth.oauth2.ServiceAccountCredentials;
import com.google.cloud.datastore.*;
import com.realsport.model.entityDao.Event;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.*;

import static com.realsport.model.dao.Persistence.getKeyFactory;


@Service
public class DatabaseService {

    private Logger logger = LoggerFactory.getLogger(DatabaseService.class);
    private static final String PROJECT_ID = "testdatastore-199913";
    private static final String NAMESPACE = "sportMap";
    private static final String EVENT = "Event";
    private static final String API_KEY = "AIzaSyAsU2pmAvoBerONIfy-nvtyLpSFKOAFWI8";

    private DatastoreOptions options;
    private Datastore datastore;
    private KeyFactory keyFactory;

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

    public DatabaseService() {
    }


    public void publishEvent(Event game) {
        //KeyFactory  keyFactory = getKeyFactory(EVENT);
        keyFactory.setKind(EVENT);
        //Key key = datastore.allocateId(keyFactory.newKey());
        Transaction tx = datastore.newTransaction();
        try {
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("description", StringValue.newBuilder(game.getDescription()).setExcludeFromIndexes(true).build())
                    .set("userIdCreator", game.getUserIdCreator())
                    .set("playgroundName", game.getPlaygroundName())
                    .set("playgroundId", game.getPlaygroundId())
                    .build();
            Entity entity = tx.add(task);
            game.setIdEvent(entity.getKey().getId().toString());
            System.out.println("IdEvent" +game.getIdEvent());
            logger.info("IdEvent" + game.getIdEvent());
            tx.commit();
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }

    }
}
