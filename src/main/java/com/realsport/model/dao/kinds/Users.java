package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.*;
import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Users {
    private Log logger = LogFactory.getLog(Users.class);
    private static final KeyFactory keyFactory = getKeyFactory(Users.class);


    public Users() {

    }


    public void publishEvent(Event game) {
        Transaction tx = getDatastore().newTransaction();
        try {
   /*         User u = new User();
            u.setUserId("1234");
            u.setFirstName("firstName");
            game.setUserList(Collections.singletonList(u));
            List<EntityValue> list = new ArrayList<>();
            for (User user: game.getUserList()) {
                FullEntity userEntity = FullEntity.newBuilder(keyFactory.newKey(user.getUserId()))
                        .set("firstName", "firstName")
                        .build();
                EntityValue value = EntityValue.of(userEntity);
                list.add(value);
            }*/
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("description", StringValue.newBuilder(game.getDescription()).setExcludeFromIndexes(true).build())
                    .set("userIdCreator", game.getUserIdCreator())
                    .set("playgroundName", game.getPlaygroundName())
                    .set("playgroundId", game.getPlaygroundId())
                    .set("userFirtsNameCreator", "firstName")
                    .set("userLastNameCreator", "firstName")
                    .set("maxCountAnswer", game.getMaxCountAnswer())
                    .set("duration", game.getDuration())
                    .set("sport", game.getSport())
                    .set("active", game.isActive())
                    .set("dateCreation", String.valueOf(game.getDateCreation()))
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

    public void registerUser(User user) {
        Transaction tx = getDatastore().newTransaction();
        try {
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey(user.getUserId()))
                    .set("firstName", user.getFirstName())
                    .set("userId", user.getUserId())
                    .set("lastName", user.getLastName())
                    .build();
            tx.add(task);
            tx.commit();

        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }
    }

    private User getUserFromEntity(Entity entity) {
        User user = new User();
        user.setUserId(entity.getString("userId"));
        user.setFirstName(entity.getString("firstName"));
        user.setLastName(entity.getString("lastName"));
        logger.info("Данные пользователя " + user);
        return user;
    }

    public User getUser(String id) {
        logger.info("Поиск пользователя");
            Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                    .setKind("Users")
                    .setFilter(StructuredQuery.PropertyFilter.eq("userId", id))
                    .build();
            QueryResults<Entity>  entity = getDatastore().run(entityQuery);
            if (entity.hasNext()) {
                logger.info("Пользователь найден");
                return getUserFromEntity(entity.next());

            }
        logger.info("Пользователь не найден");
        return null;
    }
}
