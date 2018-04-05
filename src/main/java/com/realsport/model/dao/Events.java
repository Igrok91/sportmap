package com.realsport.model.dao;

import com.google.cloud.datastore.*;
import com.realsport.model.entityDao.Event;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Events {
    private Logger logger = LoggerFactory.getLogger(Events.class);
    private static final KeyFactory keyFactory = getKeyFactory(Events.class);


    public Events() {

    }


    public void publishEvent(Event game) {
        Transaction tx = getDatastore().newTransaction();
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
