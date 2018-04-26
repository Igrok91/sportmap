package com.realsport.model.dao.kinds;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.*;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.entityDao.*;
import com.realsport.model.entityDao.Event;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.*;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Events {
    private Log logger = LogFactory.getLog(Events.class);


    public static final String EVENTS = "Events";


    private List<Event> allActiveEventList = new ArrayList<>();

    private static final KeyFactory keyFactory = getKeyFactory(Events.class);


    public void publishEvent(Event game) {
        Transaction tx = getDatastore().newTransaction();
        try {
            List<User> list = game.getUserList();
            List<EntityValue> entityList = getEntityListFromUserList(list);
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("description", StringValue.newBuilder(game.getDescription()).setExcludeFromIndexes(true).build())
                    .set("userIdCreator", game.getUserIdCreator())
                    .set("playgroundName", game.getPlaygroundName())
                    .set("playgroundId", game.getPlaygroundId())
                    .set("userFirtsNameCreator", "firstName")
                    .set("userLastNameCreator", "firstName")
                    .set("maxCountAnswer", StringValue.of(String.valueOf(game.getMaxCountAnswer())))
                    .set("duration", game.getDuration())
                    .set("sport", game.getSport())
                    .set("active", game.isActive())
                    .set("dateCreation", TimestampValue.of(game.getDateCreation()))
                    .set("userList", ListValue.of(entityList))
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

    private List<EntityValue> getEntityListFromUserList(List<User> listUser) {
        if (listUser.size() != 0) {
            List<EntityValue> list = new ArrayList<>();
            for (User user : listUser) {
                FullEntity userEntity = FullEntity.newBuilder(keyFactory.newKey(user.getUserId()))
                        .set("userId", user.getUserId())
                        .set("firstName", user.getFirstName())
                        .set("lastName", user.getLastName())
                        .set("isFake", BooleanValue.of(user.isFake()))
                        .set("countFake", LongValue.of(user.getCountFake()))
                        .build();
                EntityValue value = EntityValue.of(userEntity);
                list.add(value);
                return list;
            }
        }
        return new ArrayList<>();
    }

    public List<Event> getAllActiveEvents() {
        try {
            Datastore datastore = getDatastore();
            List<Entity>  listEntity = new ArrayList<>();
            Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                    .setKind(EVENTS)
                    .setFilter(StructuredQuery.PropertyFilter.eq("active", true))
                    .build();
            QueryResults<Entity>  queryResults = datastore.run(entityQuery);
            for (QueryResults<Entity> it = queryResults; it.hasNext(); ) {
                listEntity.add(it.next());
            }
            allActiveEventList = getEventsFromEntity(listEntity);
        } catch (Exception e) {
            logger.error(e);
            logger.warn("Событий еще нет");
        }
        return  allActiveEventList;

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
            event.setMaxCountAnswer(Integer.parseInt((entity.getString("maxCountAnswer"))));
            event.setDuration(entity.getString("duration"));
            event.setSport(entity.getString("sport"));
            event.setPlaygroundId(entity.getString("playgroundId"));
            event.setPlaygroundName(entity.getString("playgroundName"));
            Timestamp timestamp = entity.getTimestamp("dateCreation");
            event.setDateCreation(timestamp);
            event.setDate(getDateFormat(timestamp));
            logger.info(entity.getString("description"));
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
            Timestamp timestamp = fullEntity.getTimestamp("dateCreation");
            comment.setDateCreation(timestamp);
            comment.setDate(getDateFormat(timestamp));
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

            user.setCountFake((int) fullEntity.getLong("countFake"));
            userList.add(user);
        }
        return userList;
    }


    public void addUserToEvent(String eventId, User user, boolean isFake) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity event = transaction.get(keyFactory.newKey(Long.valueOf(eventId)));
            if (Objects.nonNull(event)) {
                List<EntityValue> list = event.getList("userList");
                if (Objects.nonNull(list) ) {
                    List<EntityValue> listValue = new ArrayList<>();
                    List<EntityValue> listFilter = FluentIterable.from(list).filter(new Predicate<EntityValue>() {
                        @Override
                        public boolean apply(EntityValue entityValue) {
                            FullEntity fullEntity = entityValue.get();
                            return !(fullEntity.getString("userId").equals(user.getUserId()) && fullEntity.getBoolean("isFake") == true);
                        }
                    }).toList();
                    listValue.addAll(listFilter);
                    listValue.addAll(getEntityListFromUserList(Collections.singletonList(user)));
                    transaction.put(Entity.newBuilder(event).set("userList", listValue).build());
                    logger.info("Добавили  пользователя " + user + " в событие " + eventId);
                }
            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    public void deleteUserFromEvent(String eventId, String userId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity event = transaction.get(keyFactory.newKey(Long.valueOf(eventId)));
            if (Objects.nonNull(event)) {
                List<EntityValue> list = event.getList("userList");
                if (Objects.nonNull(list) && list.size() != 0) {
                    List<EntityValue> listValue = FluentIterable.from(list).filter(new Predicate<EntityValue>() {
                        @Override
                        public boolean apply(EntityValue entityValue) {
                            return !entityValue.get().getString("userId").equals(userId);
                        }
                    }).toList();
                    transaction.put(Entity.newBuilder(event).set("userList", listValue).build());
                    logger.info("Удалили пользователя " + userId + " из события " + eventId);
                }
            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    public Event getEventById(String eventId) {
            Entity event = getDatastore().get(keyFactory.newKey(Long.valueOf(eventId)));
            if (Objects.nonNull(event)) {
                logger.info("Получаем событие " + eventId);
                return getEventFromEntity(event);
            }
            return null;
    }

    private Event getEventFromEntity(Entity entity) {
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
        Timestamp timestamp = entity.getTimestamp("dateCreation");
        event.setDateCreation(timestamp);
        event.setDate(getDateFormat(timestamp));
        try {
            List<EntityValue> entityValues = entity.getList("userList");
            event.setUserList(getUserListFromEntity(entityValues));

        } catch (DatastoreException ex) {
            logger.warn(ex.getMessage());
        }
        try {
            List<EntityValue> entityComment = entity.getList("commentsList");
            if (entityComment.size() != 0) {
                event.setCommentsList(getCommentListFromEntity(entityComment));
            }
        } catch (DatastoreException ex) {
            logger.warn(ex.getMessage());
        }
        event.setPlaygroundName(entity.getString("playgroundName"));
        return event;
    }

    private String getDateFormat(Timestamp timestamp) {
        Date date = new Date(timestamp.toSqlTimestamp().getTime());
        logger.info("getDateFormat " + date);
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM в HH:mm ", myDateFormatSymbols );
        SimpleDateFormat dateFormatNow = new SimpleDateFormat("dd MMMM", myDateFormatSymbols );
        dateFormat.setTimeZone(TimeZone.getTimeZone("Europe/Moscow"));
        String d = dateFormat.format(date);
        String dateNow = dateFormatNow.format(new Date());
        logger.info("dateNow " + dateNow);
        if (d.contains(dateNow.trim())) {
            logger.info("replace " + dateNow);
            String d2 = "сегодня в " + d.split("в")[1].trim();
            logger.info("date new " + d2);
            return d2;
        }
        logger.info("dateFormat " + d);
        return d;
    }

    public void editEventById(String eventId, String description, int maxCountAnswer, String duration) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity event = transaction.get(keyFactory.newKey(Long.valueOf(eventId)));
            if (Objects.nonNull(event)) {
                    transaction.put(Entity.newBuilder(event).
                            set("description", StringValue.of(description)).
                            set("duration", StringValue.of(duration)).
                            set("maxCountAnswer", StringValue.of(String.valueOf(maxCountAnswer))).
                            build());
                    logger.info("Изменили событие c id " + eventId);
                }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    public void deleteGame(String eventId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            transaction.delete(keyFactory.newKey(Long.valueOf(eventId)));
            logger.info("Удаляем игру с id " + eventId);
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    public void endGame(String eventId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity event = transaction.get(keyFactory.newKey(Long.valueOf(eventId)));
            if (Objects.nonNull(event)) {
                transaction.put(Entity.newBuilder(event).
                        set("active", BooleanValue.of(false)).
                        build());
                logger.info("Завершаем событие c id " + eventId);
            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    private static DateFormatSymbols myDateFormatSymbols = new DateFormatSymbols(){

        @Override
        public String[] getMonths() {
            return new String[]{"янв", "фев", "мар", "апр", "мая", "июня",
                    "июля", "авг", "сен", "окт", "ноя", "дек"};
        }

    };

    public String addCommentToEvent(String eventId, Comment message) {
        Transaction transaction = getDatastore().newTransaction();
        Entity entity = null;
        String idComment = null;
        try {
            Entity event = transaction.get(keyFactory.newKey(Long.valueOf(eventId)));
            if (Objects.nonNull(event)) {
                List<EntityValue> list = null;
                try {
                   list = event.getList("commentsList");
                } catch (Exception e) {
                    logger.warn("Нет поля commentsList");
                }
                List<EntityValue> listComment = new ArrayList<>();
                if (Objects.nonNull(list)) {
                    listComment.addAll(list);

                }
                idComment = message.getUserId() + "_" + message.getDateCreation().toSqlTimestamp().getTime();
                listComment.add(getEntityComment(message, idComment));
                entity = transaction.put(Entity.newBuilder(event).
                        set("commentsList", ListValue.of(listComment)).
                        build());
                logger.info("Отправлен комментарий в событии " + eventId + " от пользователя " + message.getUserId());

                transaction.commit();
            }
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
        logger.info("key comment " + idComment);
        return entity == null ? null : idComment;
    }

    private EntityValue getEntityComment(Comment message, String idComment) {
        FullEntity userEntity = FullEntity.newBuilder(keyFactory.newKey())
                .set("commentId", idComment)
                .set("userId", message.getUserId())
                .set("firstName", message.getFirstName())
                .set("lastName", message.getLastName())
                .set("dateCreation", TimestampValue.of(message.getDateCreation()))
                .set("message", message.getMessage())
                .build();
        return EntityValue.of(userEntity);
    }


    public void deleteCommentFromEvent(String commentId, String eventId) {
        Transaction transaction = getDatastore().newTransaction();
        Entity entity = null;
        try {
            Entity event = transaction.get(keyFactory.newKey(Long.valueOf(eventId)));
            if (Objects.nonNull(event)) {
                List<EntityValue> list = null;
                try {
                    list = event.getList("commentsList");
                } catch (Exception e) {
                    logger.warn("Нет поля commentsList");
                }
                List<EntityValue> listComment = new ArrayList<>();
                if (Objects.nonNull(list)) {
                    List<EntityValue> valueList = FluentIterable.from(list).filter(new Predicate<EntityValue>() {
                        @Override
                        public boolean apply(EntityValue entityValue) {
                            return !entityValue.get().getString("commentId").equals(commentId);
                        }
                    }).toList();
                    listComment.addAll(valueList);
                    entity = transaction.put(Entity.newBuilder(event).
                            set("commentsList", ListValue.of(listComment)).
                            build());
                    logger.info("Удален комментарий в событии " + eventId );

                    transaction.commit();
                }

            }
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    public List<Event> getEventsByIdGroup(String playgroundId) {
        try {
            Datastore datastore = getDatastore();
            List<Entity>  listEntity = new ArrayList<>();
            Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                    .setKind(EVENTS)
                    .setFilter(StructuredQuery.PropertyFilter.eq("playgroundId", playgroundId))
                    .build();
            QueryResults<Entity>  queryResults = datastore.run(entityQuery);
            for (QueryResults<Entity> it = queryResults; it.hasNext(); ) {
                listEntity.add(it.next());
            }
            List<Event> eventPlaygrounds = getEventsFromEntity(listEntity);
            return eventPlaygrounds;
        } catch (Exception e) {
            logger.error(e);
            logger.warn("Событий еще нет");
        }
        return null;
    }
}
