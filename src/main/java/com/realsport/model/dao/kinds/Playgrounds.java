package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.*;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.entityDao.*;
import com.realsport.model.utils.KindSport;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Playgrounds {
    private Log logger = LogFactory.getLog(Playgrounds.class);

    public static final String PLAYGROUNDS = "Playgrounds";

    List<Playground> listPlayground = new ArrayList<>();

    private static final KeyFactory keyFactory = getKeyFactory(Playgrounds.class);

    private List<Playground> convertListEntityToPlayground(QueryResults<Entity> queryResults) {
        List<Playground> list = new ArrayList<>();
        for (QueryResults<Entity> it = queryResults; it.hasNext(); ) {
            Entity entity = it.next();

            LatLng latLng = entity.getLatLng("latlong");
            Playground playground = new Playground();
            playground.setIdplayground(entity.getKey().getId().toString());
            playground.setName(entity.getString("name"));
            playground.setLatitude(String.valueOf(latLng.getLatitude()));
            playground.setLongitude(String.valueOf(latLng.getLongitude()));
            playground.setSity(entity.getString("city"));
            playground.setStreet(entity.getString("street"));
            playground.setHouse(entity.getString("house"));
            playground.setSport(entity.getString("sport"));
            try {
                List<EntityValue> listValues = entity.getList("players");
                playground.setPlayers(convertListValueToUserList(listValues));
            } catch (Exception e) {
                logger.warn(e);
            }

            list.add(playground);
            logger.info(playground.getPlayers());
        }
        return list;
    }

    private List<MinUser> convertListValueToUserList(List<EntityValue> listValues) {
        List<MinUser> list = new ArrayList<>();
        logger.info("Количество участников = " + listValues.size());
        if (listValues.size() != 0) {
            for (EntityValue value : listValues) {
                MinUser minUser = new MinUser();
                minUser.setUserId(value.get().getString("userId"));
                minUser.setFirstName(value.get().getString("firstName"));
                minUser.setLastName(value.get().getString("lastName"));
                minUser.setPhoto_50(value.get().getString("photo_50"));
                list.add(minUser);
            }
        }
        return list;
    }



    public List<Playground> getAllPlayground() {
        try {
            Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                    .setKind(PLAYGROUNDS).build();
            QueryResults<Entity>  queryResults = getDatastore().run(entityQuery);
            listPlayground = convertListEntityToPlayground(queryResults);
        } catch (Exception e) {
            logger.warn("Нет площадок");
        }
        return listPlayground;
    }

    public Playground getPlaygroundById(String idGroup) {
    /*    Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                .setKind(PLAYGROUNDS)
                .setFilter(StructuredQuery.PropertyFilter.eq("idPlayground", idGroup))
                .build();*/
        Entity entity = getDatastore().get(keyFactory.newKey(Long.valueOf(idGroup)));
        if (Objects.nonNull(entity)) {
            return convertEntityToPlayground(entity);
        }

        return null;
    }

    private Playground convertEntityToPlayground(Entity entity) {
        LatLng latLng = entity.getLatLng("latlong");
        Playground playground = new Playground();
        playground.setIdplayground(entity.getKey().getId().toString());
        playground.setName(entity.getString("name"));
        playground.setLatitude(String.valueOf(latLng.getLatitude()));
        playground.setLongitude(String.valueOf(latLng.getLongitude()));
        playground.setSity(entity.getString("city"));
        playground.setStreet(entity.getString("street"));
        playground.setHouse(entity.getString("house"));
        playground.setSport(entity.getString("sport"));
        try {
            List<EntityValue>  listValues = entity.getList("players");
            playground.setPlayers(convertListValueToUserList(listValues));
        } catch (Exception e) {
            logger.warn(e);
        }

        return playground;
    }

    public void addUserToPlayground(MinUser minUser, String playgroundId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            logger.info("playgroundId = " + playgroundId);
            Entity task = transaction.get(keyFactory.newKey(Long.valueOf(playgroundId)));
            logger.info("task " + task);
            if (Objects.nonNull(task)) {
            List<EntityValue> listValue = null;
            try {
                listValue = task.getList("players");
            } catch (Exception e) {
                logger.warn(e);
            }
                if (Objects.nonNull(listValue)) {
                    List<EntityValue> list = new ArrayList<>();
                    boolean isPresent = FluentIterable.from(listValue).firstMatch(new Predicate<EntityValue>() {
                        @Override
                        public boolean apply(EntityValue entityValue) {
                            return entityValue.get().getString("userId").equals(minUser.getUserId());
                        }
                    }).isPresent();
                    list.addAll(listValue);
                    if (!isPresent) {
                        list.add(getEntityValueFromMinUser(minUser));
                    }
                    transaction.update(Entity.newBuilder(task).set("players", list).build());
                } else {
                    transaction.update(Entity.newBuilder(task).set("players", ListValue.of(getEntityValueFromMinUser(minUser))).build());
                }
                logger.info("Добавили  пользователя " + minUser + " в группу " + playgroundId);

            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    private EntityValue getEntityValueFromMinUser(MinUser minUser) {
        FullEntity entity = FullEntity.newBuilder()
                .set("userId", minUser.getUserId())
                .set("firstName", minUser.getFirstName())
                .set("lastName", minUser.getLastName())
                .set("photo_50", minUser.getPhoto_50())
                .build();
        return EntityValue.of(entity);
    }

    public void deleteUserFromPlayground(String userId, String playgroundId) {
        Transaction transaction = getDatastore().newTransaction();
        try {
            Entity task = transaction.get(keyFactory.newKey(Long.valueOf(playgroundId)));
            logger.info("task" + task);
            if (Objects.nonNull(task)) {
                List<EntityValue> listValue = null;
                try {
                    listValue = task.getList("players");
                } catch (Exception e) {
                    logger.warn(e);
                }
                if (Objects.nonNull(listValue)) {
                    List<EntityValue> list = FluentIterable.from(listValue).filter(new Predicate<EntityValue>() {
                        @Override
                        public boolean apply(EntityValue entityValue) {
                            return !entityValue.get().getString("userId").equals(userId);
                        }
                    }).toList();
                    transaction.update(Entity.newBuilder(task).set("players", list).build());
                }
                logger.info("Удалили из списка Участников группы пользователя " + userId);

            }
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }
}
