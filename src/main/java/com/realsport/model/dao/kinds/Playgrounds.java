package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.*;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.entityDao.*;
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

    public static final String EVENTS_FOOTBALL = "EventsFootball";
    public static final String EVENTS_BASKETBALL = "EventsBasketball";
    public static final String EVENTS_VOLEYBALL = "EventsVoleyball";

    public static final String PLAYGROUNDS = "Playgrounds";

    List<Playground> listPlayground = new ArrayList<>();

    private static final KeyFactory keyFactory = getKeyFactory(Playgrounds.class);

    /**
     * Получение всех площадок
     */
    public List<Playground> getFootballPlayground() {
        List<Playground> footballPlaygrounds = FluentIterable.from(listPlayground).filter(new Predicate<Playground>() {
            @Override
            public boolean apply(Playground playground) {
                return playground.getSport().equals(KindSport.FOOTBALL.getSport());
            }
        }).toList();
        return footballPlaygrounds;
    }

    private List<Playground> convertListEntityToPlayground(QueryResults<Entity> queryResults) {
        List<Playground> list = new ArrayList<>();
        for (QueryResults<Entity> it = queryResults; it.hasNext(); ) {
            Entity entity = it.next();
            //List<EntityValue> listValues = entity.getList("players");
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
            //playground.setPlayers(convertListValueToUserList(listValues));
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
                minUser.setUserId(value.get().getString("firstName"));
                minUser.setUserId(value.get().getString("lastName"));
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
        Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                .setKind(PLAYGROUNDS)
                .setFilter(StructuredQuery.PropertyFilter.eq("idPlayground", idGroup))
                .build();
        QueryResults<Entity>  queryResults = getDatastore().run(entityQuery);
        if (queryResults.hasNext()) {
            return convertEntityToPlayground(queryResults.next());
        }

        return null;
    }

    private Playground convertEntityToPlayground(Entity entity) {
        //List<EntityValue> listValues = entity.getList("players");
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
        return playground;
    }

    public void addPlaygroundToUser(String userId, String playgroundId) {
        Transaction transaction = getDatastore().newTransaction();

        try {
            Entity task = transaction.get(keyFactory.newKey(userId));
            logger.info("task" + task);
            if (Objects.nonNull(task)) {
            ListValue listValue = null;
            try {
                listValue = task.getValue("playgroundIdlList");
            } catch (Exception e) {
                logger.warn(e);
            }
                if (Objects.nonNull(listValue)) {
                    listValue.toBuilder().addValue(StringValue.of(playgroundId));
                    transaction.put(Entity.newBuilder(task).set("playgroundIdlList", listValue).build());
                } else {
                    transaction.put(Entity.newBuilder(task).set("playgroundIdlList", ListValue.of(playgroundId)).build());
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

    }
}
