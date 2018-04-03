package com.realsport.model.dao;

import com.google.auth.Credentials;
import com.google.auth.oauth2.AccessToken;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.datastore.*;
import com.google.common.collect.Lists;
import com.realsport.model.entityDao.Event;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;

@Service
public class DatabaseService {

    private static final String PROJECT_ID = "testdatastore-199913";
    private static final String NAMESPACE = "sportMap";
    private static final String EVENT = "Event";
    private static final String API_KEY = "AIzaSyAsU2pmAvoBerONIfy-nvtyLpSFKOAFWI8";

    private DatastoreOptions options;
    private Datastore datastore;
    private KeyFactory keyFactory;

    {
        GoogleCredentials credentials = GoogleCredentials.newBuilder().setAccessToken(new AccessToken(API_KEY, null)).build();
        options = DatastoreOptions.newBuilder().setCredentials(credentials).setProjectId(PROJECT_ID).setNamespace(NAMESPACE).build();
        datastore = options.getService();
        keyFactory = datastore.newKeyFactory();

    }

    public DatabaseService() {
    }


    public void publishEvent(Event game) {
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
            tx.add(task);
            tx.commit();
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }

    }
}
