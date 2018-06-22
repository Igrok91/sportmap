package com.realsport.model.dao.kinds;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.*;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.dao.entityDao.Event;
import com.realsport.model.dao.entityDao.EventUser;
import com.realsport.model.dao.entityDao.TemplateGame;
import com.realsport.model.dao.entityDao.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Users {
    private Log logger = LogFactory.getLog(Users.class);
    private static final KeyFactory keyFactory = getKeyFactory(Users.class);


    private User getUserFromEntity(Entity entity) {
        User user = new User();
        user.setUserId(entity.getString("userId"));
        user.setFirstName(entity.getString("firstName"));
        user.setLastName(entity.getString("lastName"));
        user.setPhoto_50(entity.getString("photo_50"));
        user.setPhoto_100(entity.getString("photo_100"));
        try {
            user.setInfo(entity.getString("info"));
        } catch (Exception e) {
            logger.warn(e);
        }
        try {
            user.setSubscriptionsTemp(entity.getTimestamp("subscriptionsTemp"));
        } catch (Exception e) {
            logger.warn(e);
            user.setSubscriptionsTemp(null);
        }
        try {
            user.setPlaygroundIdlList(convertListValuePlaygroundIdToList(entity.getList("playgroundIdList")));
        } catch (Exception e) {
            logger.warn(e);
        }
        try {
            user.setListParticipant(convertListValueEventUserToList(entity.getList("listParticipant")));
        } catch (Exception e) {
            logger.warn(e);
        }
        try {
            user.setTemplateGames(getTemplatesFromEntity(entity.getList("templates")));
        } catch (Exception e) {
            logger.warn(e);
        }

        logger.info("Данные пользователя " + user);
        return user;
    }

    private List<EventUser> convertListValueEventUserToList(List<EntityValue> listParticipant) {
        List<EventUser> eventUsers = new ArrayList<>();
        for (EntityValue entityValue : listParticipant) {
            EventUser eventUser = new EventUser();
            eventUser.setEventId(entityValue.get().getLong("eventId"));
            eventUser.setOrganize(entityValue.get().getBoolean("isOrganize"));
            eventUsers.add(eventUser);
        }
        return eventUsers;
    }

    public User getUser(String id) {
        logger.info("Поиск пользователя");
        Datastore datastore = getDatastore();
        Entity entity = datastore.get(keyFactory.newKey(id));
        if (Objects.nonNull(entity)) {
            logger.info("Пользователь найден");
            return getUserFromEntity(entity);
        }
            /*Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                    .setKind("Users")
                    .setFilter(StructuredQuery.PropertyFilter.eq("userId", id))
                    .build();
            QueryResults<Entity>  vo = getDatastore().run(entityQuery);
            if (vo.hasNext()) {
                logger.info("Пользователь найден");
                return getUserFromEntity(vo.next());

            }*/
        logger.info("Пользователь не найден");
        return null;
    }

    private List<String> convertListValuePlaygroundIdToList(List<StringValue> listValues) {
        List<String> list = new ArrayList<>();
        logger.info("Количество участников = " + listValues.size());
        if (listValues.size() != 0) {
            for (StringValue value : listValues) {
                list.add(value.get());
            }
        }
        return list;
    }

    public void addPlaygroundToUser(String userId, String playgroundId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity task = transaction.get(keyFactory.newKey(userId));
            logger.info("task" + task);
            if (Objects.nonNull(task)) {
                List<StringValue> listValue = null;
                try {
                    listValue = task.getList("playgroundIdList");
                } catch (Exception e) {
                    logger.warn(e);
                }
                if (Objects.nonNull(listValue)) {
                    List<StringValue> list = new ArrayList<>();
                    boolean isPresent = FluentIterable.from(listValue).firstMatch(new Predicate<StringValue>() {
                        @Override
                        public boolean apply(StringValue stringValue) {
                            return stringValue.get().equals(playgroundId);
                        }
                    }).isPresent();
                    list.addAll(listValue);
                    if (!isPresent) {
                        list.add(StringValue.of(playgroundId));
                    }
                    transaction.update(Entity.newBuilder(task).set("playgroundIdList", list).build());
                } else {
                    transaction.update(Entity.newBuilder(task).set("playgroundIdList", ListValue.of(playgroundId)).build());
                }
                logger.info("Добавили в список групп пользователя " + userId + " группу " + playgroundId);

            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    public void deletePlaygroundFromUser(String userId, String playgroundId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity task = transaction.get(keyFactory.newKey(userId));
            logger.info("task" + task);
            if (Objects.nonNull(task)) {
                List<StringValue> listValue = null;
                try {
                    listValue = task.getList("playgroundIdList");
                } catch (Exception e) {
                    logger.warn(e);
                }
                if (Objects.nonNull(listValue)) {
                    List<StringValue> list = FluentIterable.from(listValue).filter(new Predicate<StringValue>() {
                        @Override
                        public boolean apply(StringValue stringValue) {
                            return !stringValue.get().equals(playgroundId);
                        }
                    }).toList();
                    transaction.update(Entity.newBuilder(task).set("playgroundIdList", list).build());
                }
                logger.info("Удалили из списка групп пользователя " + userId + " группу " + playgroundId);

            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }


    public List<TemplateGame> getTemplatesUserById(String userId) {
        Entity entity = getDatastore().get(keyFactory.newKey(userId));
        try {
            if (Objects.nonNull(entity)) {
                List<EntityValue> list = entity.getList("templates");
                return getTemplatesFromEntity(list);
            }
        } catch (Exception e) {
            logger.warn(e);
        }
        return null;
    }

    private List<TemplateGame> getTemplatesFromEntity(List<EntityValue> list) {
        List<TemplateGame> listTemplate = new ArrayList<>();
        for (EntityValue entityValue : list) {
            FullEntity fullEntity = entityValue.get();
            TemplateGame game = new TemplateGame();
            game.setTemplateId(fullEntity.getString("templateId"));
            game.setDescription(getMinText(fullEntity.getString("description")));
            game.setCountAnswer((int) fullEntity.getLong("countAnswer"));
            game.setDuration(fullEntity.getString("duration"));
            listTemplate.add(game);
        }
        return listTemplate;
    }

    private String getMinText(String description) {
        String minText = description;
        if (description.length() > 35) {
            minText = description.substring(0, 30) + "...";
        }
        return minText;
    }


    public String saveTemplateUser(TemplateGame template, String userId) {
        Transaction transaction = getDatastore().newTransaction();
        String id = "10";
        try {
            Entity user = transaction.get(keyFactory.newKey(userId));
            logger.info("user" + user);
            if (Objects.nonNull(user)) {
                List<EntityValue> listValue = null;
                try {
                    listValue = user.getList("templates");

                } catch (Exception e) {
                    logger.warn(e);
                }
                if (Objects.nonNull(listValue)) {
                    List<EntityValue> list = new ArrayList<>();
                    list.addAll(listValue);
                    id = String.valueOf(list.size() + 1);
                    list.add(getEntityFromTemplates(template, id));
                    transaction.update(Entity.newBuilder(user).set("templates", list).build());
                } else {
                    id = "1";
                    transaction.update(Entity.newBuilder(user).set("templates", ListValue.of(getEntityFromTemplates(template, id))).build());
                }
                logger.info("Добавили в список шаблонов пользователя " + userId + " шаблон " + template);

            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
        return id;
    }

    private EntityValue getEntityFromTemplates(TemplateGame template, String id) {
        FullEntity entity = FullEntity.newBuilder()
                .set("templateId", id)
                .set("description", template.getDescription())
                .set("countAnswer", template.getCountAnswer())
                .set("duration", template.getDuration())
                .build();
        return EntityValue.of(entity);
    }

    public void removeTemplateUser(String userId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity user = transaction.get(keyFactory.newKey(userId));
            logger.info("user" + user);
            if (Objects.nonNull(user)) {
                List<EntityValue> listValue = null;
                try {
                    listValue = user.getList("templates");

                } catch (Exception e) {
                    logger.warn(e);
                }
                if (Objects.nonNull(listValue)) {
                    List<EntityValue> entityValues = new ArrayList<>();
                    transaction.update(Entity.newBuilder(user).set("templates", entityValues).build());
                }
                logger.info("Удалили  из списка шаблонов пользователя " + userId);

            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    public Event createEventByTemplate(String templateId, String userId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity user = transaction.get(keyFactory.newKey(userId));
            logger.info("user " + user);
            logger.info("userId " + userId);
            if (Objects.nonNull(user)) {
                List<EntityValue> listValue = null;
                try {
                    listValue = user.getList("templates");

                } catch (Exception e) {
                    logger.warn(e);
                }
                if (Objects.nonNull(listValue)) {
                    EntityValue entityValue = FluentIterable.from(listValue).firstMatch(new Predicate<EntityValue>() {
                        @Override
                        public boolean apply(EntityValue entityValue) {
                            return entityValue.get().getString("templateId").equals(templateId);
                        }
                    }).orNull();
                    if (Objects.nonNull(entityValue)) {
                        return getEventFromTemplateEntity(entityValue);
                    }
                }
                logger.info("Создание  события по шаблону пользователем " + userId + ", шаблон " + templateId);
            }
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
        return null;
    }

    private Event getEventFromTemplateEntity(EntityValue entityValue) {
        FullEntity fullEntity = entityValue.get();
        Event game = new Event();
        game.setAnswer("+");
        game.setDescription(fullEntity.getString("description"));
        game.setMaxCountAnswer((int) fullEntity.getLong("countAnswer"));
        game.setDuration(fullEntity.getString("duration"));
        return game;
    }

    public void editUserInfo(String userInfo, String userId) {
        Entity entity = getDatastore().get(keyFactory.newKey(userId));
        try {
            if (Objects.nonNull(entity)) {
                getDatastore().update(Entity.newBuilder(entity).set("info", userInfo).build());
            }
        } catch (Exception e) {
            logger.warn(e);
        }
    }


    public void addEventToUserParticipant(List<User> userList, Long eventId, String userId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            for (User u : userList) {
                Entity userEntity = transaction.get(keyFactory.newKey(u.getUserId()));
                boolean isOrganize = u.getUserId().equals(userId);
                logger.info("user " + userEntity);
                if (Objects.nonNull(userEntity)) {
                    List<EntityValue> list1 = new ArrayList<>();
                    List<EntityValue> listParticipant = null;
                    try {
                        listParticipant = userEntity.getList("listParticipant");
                    } catch (Exception e) {
                        logger.warn(e);
                    }

                    if (Objects.nonNull(listParticipant)) {
                        list1.addAll(listParticipant);
                        list1.add(EntityValue.of(getEntityEventUser(eventId, isOrganize)));
                        transaction.update(Entity.newBuilder(userEntity).set("listParticipant", ListValue.of(list1)).build());
                    } else {
                        list1.add(EntityValue.of(getEntityEventUser(eventId, isOrganize)));
                        transaction.update(Entity.newBuilder(userEntity).set("listParticipant", ListValue.of(list1)).build());
                    }
                }
            }
            logger.info("Изменение списка пользователя, в которых учавствовал ");
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    private FullEntity getEntityEventUser(Long eventId, boolean userIdCreator) {
        FullEntity entity = FullEntity.newBuilder()
                .set("eventId", LongValue.of(eventId))
                .set("isOrganize", BooleanValue.of(userIdCreator))
                .build();
        return entity;
    }

    public void registerUser(String userId, String first_name, String last_name, String photo_50, String photo_100) {
        Transaction tx = getDatastore().newTransaction();
        try {
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey(Long.valueOf(userId)))
                    .set("firstName", first_name)
                    .set("userId", userId)
                    .set("lastName", last_name)
                    .set("photo_50", photo_50)
                    .set("photo_100", photo_100)
                    .build();
            tx.add(task);
            tx.commit();
        } catch (Exception e) {
            logger.error("Ошибка при регистрации: " + e);
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }
    }

    public void addSubscriptionsTemp(String userId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
                Entity userEntity = transaction.get(keyFactory.newKey(Long.valueOf(userId)));

                logger.info("addSubscriptionsTemp " + userId + " " + userEntity);
                Date date = new Date();
                if (Objects.nonNull(userEntity)) {

                    transaction.update(Entity.newBuilder(userEntity).set("subscriptionsTemp", TimestampValue.of(Timestamp.of(date))).build());
                }

            logger.info("Изменение статуса временной подписки пользователя " + date );
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }
}
