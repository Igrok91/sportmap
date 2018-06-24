package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.DoubleValue;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.FullEntity;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.Transaction;
import com.realsport.model.vo.CheckPlaygroundData;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Notifications {

    private Log logger = LogFactory.getLog(Notifications.class);
    private static final KeyFactory keyFactory = getKeyFactory(Notifications.class);
    public static final String NOTIFICATIONS = "Notifications";


    public void addPlaygroundToCheck(Double lat, Double lng, String sport, String userId) {
        Transaction tx = getDatastore().newTransaction();
        try {
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("lat", DoubleValue.of(lat))
                    .set("lng", DoubleValue.of((lng)))
                    .set("sport", sport)
                    .set("userIdCreator", userId)
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

    public List<CheckPlaygroundData> getPlaygroundsCheck() {

        List<CheckPlaygroundData> listPlayground = new ArrayList<>();
        try {
            Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                    .setKind(NOTIFICATIONS).build();
            QueryResults<Entity> queryResults = getDatastore().run(entityQuery);
            listPlayground = convertListEntity(queryResults);
        } catch (Exception e) {
            logger.warn("Нет площадок");
        }
        return listPlayground;
    }

    private List<CheckPlaygroundData> convertListEntity(QueryResults<Entity> queryResults) {
        List<CheckPlaygroundData> list = new ArrayList<>();
        for (QueryResults<Entity> it = queryResults; it.hasNext(); ) {
            Entity entity = it.next();
            CheckPlaygroundData data = new CheckPlaygroundData(entity.getDouble("lat"),
                    entity.getDouble("lng"),
                    entity.getString("sport"),
                    entity.getString("userIdCreator"));
            data.setId(entity.getKey().getId());
            list.add(data);
        }
        return list;
    }

    public void deleteNotification(String idPlayground) {
        try {
            logger.info("Удаление площадки из уведомлений с id " + idPlayground);
            getDatastore().delete(keyFactory.newKey(Long.valueOf(idPlayground)));
        } catch (Exception e) {
            logger.error(e);
        }
    }
}
