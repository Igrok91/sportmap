package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.*;
import com.realsport.model.entityDao.*;
import com.realsport.model.entityDao.Event;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import com.google.cloud.datastore.StructuredQuery.CompositeFilter;

import java.awt.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Events {
    private Logger logger = LoggerFactory.getLogger(Events.class);

    public static final String EVENTS_FOOTBALL = "EventsFootball";
    public static final String EVENTS_BASKETBALL = "EventsBasketball";
    public static final String EVENTS_VOLEYBALL = "EventsVoleyball";
    private KeyFactory keyFactory;

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

    public  void setKeyFactory(String c) {
        keyFactory = getKeyFactory(c);
    }

    public List<Event> eventsFootballOfGroupUser(List<String> playgroundFoottUser) {
        Datastore datastore = getDatastore();

        List<Entity>  listEntity = new ArrayList<>();
        for (String id: playgroundFoottUser) {
            Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                    .setKind(EVENTS_FOOTBALL)
                    .setFilter(CompositeFilter.and(StructuredQuery.PropertyFilter.eq("playgroundId", id)
                            ,StructuredQuery.PropertyFilter.eq("active", true)))
                    .build();
            QueryResults<Entity>  queryResults = datastore.run(entityQuery);
            if (queryResults.hasNext()) {
                listEntity.add(queryResults.next());
            }
        }
        List<Event> list = getEventsFromEntity(listEntity);
        return  list;

    }

    private List<Event> getEventsFromEntity(List<Entity> listEntity) {
        List<Event> events = new ArrayList<>();
        for (Entity entity : listEntity) {
            Event event = new Event();
            event.setIdEvent(entity.getKey().getId().toString());
            event.setUserIdCreator(entity.getString("userIdCreator"));
            event.setUserFirtsNameCreator(entity.getString("userFirtsNameCreator"));
            event.setUserLastNameCreator(entity.getString("userLastNameCreator"));
            event.setDescription(entity.getString("description"));
            event.setAnswer("+");
            event.setMaxCountAnswer(Integer.parseInt(entity.getString("maxCountAnswer")));
            event.setDuration(entity.getString("duration"));
            event.setSport(entity.getString("sport"));
            event.setPlaygroundId(entity.getString("playgroundId"));
            event.setPlaygroundName(entity.getString("playgroundName"));
            event.setDateCreation(new Date());
            try{
                List<EntityValue> entityValues = entity.getList("userList");
                event.setUserList(getUserListFromEntity(entityValues));

            } catch (DatastoreException ex) {
                logger.warn(ex.getMessage());
            }
            try{
                List<EntityValue> entityComment = entity.getList("commentsList");
                if (entityComment.size() != 0) {
                    event.setCommentsList(getCommentListFromEntity(entityComment));
                }
            } catch (DatastoreException ex) {
                logger.warn(ex.getMessage());
            }
            event.setPlaygroundName(entity.getString("playgroundName"));

            events.add(event);
        }
        return events;
    }

    private List<Comment> getCommentListFromEntity(List<EntityValue> entityComment) {
        List<Comment> listComment = new ArrayList<>();
        for(EntityValue entityValue : entityComment) {
            Comment comment = new Comment();
            FullEntity fullEntity = entityValue.get();
            comment.setCommentId(fullEntity.getString("commentId"));
            comment.setUserId(fullEntity.getString("userId"));
            comment.setFirstName(fullEntity.getString("firstName"));
            comment.setLastName(fullEntity.getString("lastName"));
            comment.setMessage(fullEntity.getString("message"));
            comment.setDate(fullEntity.getString("date"));
            listComment.add(comment);
        }
        return listComment;
    }

    private List<User> getUserListFromEntity(List<EntityValue> entityValues) {
        List<User> userList = new ArrayList<>();
        for(EntityValue entityValue : entityValues) {
            User user = new User();
            FullEntity fullEntity = entityValue.get();
            user.setUserId(fullEntity.getString("userId"));
            user.setFirstName(fullEntity.getString("firstName"));
            user.setLastName(fullEntity.getString("lastName"));
            user.setFake(fullEntity.getBoolean("isFake"));
            user.setAdmin(fullEntity.getBoolean("isAdmin"));
            user.setCountFake(Integer.parseInt(fullEntity.getString("countFake")));
            userList.add(user);
        }
        return userList;
    }


}
