package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.*;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Users {
    private Log logger = LogFactory.getLog(Users.class);
    private static final KeyFactory keyFactory = getKeyFactory(Users.class);


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
        try {
            user.setPlaygroundIdlList(convertListValuePlaygroundIdToList(entity.getList("playgroundIdList")));
        } catch (Exception e) {
            logger.warn(e);
        }

        logger.info("Данные пользователя " + user);
        return user;
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
            QueryResults<Entity>  entity = getDatastore().run(entityQuery);
            if (entity.hasNext()) {
                logger.info("Пользователь найден");
                return getUserFromEntity(entity.next());

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
                    list.addAll(listValue);
                    list.add(StringValue.of(playgroundId));
                    transaction.put(Entity.newBuilder(task).set("playgroundIdList", list).build());
                } else {
                    transaction.put(Entity.newBuilder(task).set("playgroundIdList", ListValue.of(playgroundId)).build());
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
                    transaction.put(Entity.newBuilder(task).set("playgroundIdList", list).build());
                } else {
                    transaction.put(Entity.newBuilder(task).set("playgroundIdList", ListValue.of(playgroundId)).build());
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

    public void addPlaygroundToEventListActive(String playgroundId, String userId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity user = transaction.get(keyFactory.newKey(userId));
            logger.info("user" + user);
            if (Objects.nonNull(user)) {
                List<StringValue> listValue = null;
                try {
                    listValue = user.getList("eventListActive");
                } catch (Exception e) {
                    logger.warn(e);
                }
                if (Objects.nonNull(listValue)) {
                    List<StringValue> list = new ArrayList<>();
                    list.addAll(listValue);
                    list.add(StringValue.of(playgroundId));
                    transaction.put(Entity.newBuilder(user).set("eventListActive", list).build());
                } else {
                    transaction.put(Entity.newBuilder(user).set("eventListActive", ListValue.of(playgroundId)).build());
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
}
