package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.*;
import com.google.cloud.datastore.StructuredQuery.CompositeFilter;
import com.realsport.model.entityDao.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Playgrounds {
    private Log logger = LogFactory.getLog(Playgrounds.class);

    public static final String EVENTS_FOOTBALL = "EventsFootball";
    public static final String EVENTS_BASKETBALL = "EventsBasketball";
    public static final String EVENTS_VOLEYBALL = "EventsVoleyball";

    public static final String FOOTBALL_PLAYGROUND = "FootballPlayground";
    public static final String BASKETBALL_PLAYGROUND = "BasketballPlayground";
    public static final String VOLEYBALL_PLAYGROUND = "VoleyballPlayground";

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

    /**
     * Получение всех площадок
     */
    public List<FootballPlayground> getFootballPlayground() {
        Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                .setKind(FOOTBALL_PLAYGROUND).build();
        QueryResults<Entity>  queryResults = getDatastore().run(entityQuery);
        return convertEntityToPlayground(queryResults);
    }

    private List<FootballPlayground> convertEntityToPlayground(QueryResults<Entity> queryResults) {
        List<FootballPlayground> list = new ArrayList<>();
        for (QueryResults<Entity> it = queryResults; it.hasNext(); ) {
            Entity entity = it.next();
            List<EntityValue> listValues = entity.getList("players");
            LatLng latLng = entity.getLatLng("latlong");
            FootballPlayground playground = new FootballPlayground();
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


    public List<VoleyballPlayground> getVoleyballPlayground() {
        return new ArrayList<>();
    }

    public List<BasketballPlayground> getBasketballPlayground() {
        return new ArrayList<>();
    }


}
