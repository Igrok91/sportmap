package com.realsport.model.dao;

import com.google.cloud.datastore.*;
import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

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
            List<EntityValue> list = new ArrayList<>();
            for (User user: game.getUserList()) {
                FullEntity userEntity = FullEntity.newBuilder(keyFactory.newKey(user.getUserId()))
                        .set("firstName", "firstName")
                        .build();
                EntityValue value = EntityValue.of(userEntity);
                list.add(value);
            }
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("description", StringValue.newBuilder(game.getDescription()).setExcludeFromIndexes(true).build())
                    .set("userIdCreator", game.getUserIdCreator())
                    .set("playgroundName", game.getPlaygroundName())
                    .set("playgroundId", game.getPlaygroundId())
                    .set("userFirtsNameCreator", game.getUserFirtsNameCreator())
                    .set("userLastNameCreator", game.getUserLastNameCreator())
                    .set("maxCountAnswer", game.getMaxCountAnswer())
                    .set("duration", game.getDuration())
                    .set("sport", game.getSport())
                    .set("active", game.isActive())
                    .set("dateCreation", String.valueOf(game.getDateCreation()))
                    .set("userList", ListValue.of(list))
                    .build();
            Entity entity = tx.add(task);
            game.setIdEvent(entity.getKey().getId().toString());
            logger.info(" Создание события с Id" + game.getIdEvent());
            tx.commit();
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }
    }
}
