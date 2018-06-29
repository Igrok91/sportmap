package com.realsport.controller;


import com.google.cloud.datastore.BooleanValue;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.EntityValue;
import com.google.cloud.datastore.FullEntity;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.ListValue;
import com.google.cloud.datastore.LongValue;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.StructuredQuery;
import com.google.cloud.datastore.Transaction;
import com.realsport.dao.kinds.Users;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

import static com.realsport.dao.Persistence.getDatastore;
import static com.realsport.dao.Persistence.getKeyFactory;

@WebServlet("/updateEvent")
public class EventsServlet extends HttpServlet {
    private Log logger = LogFactory.getLog(EventsServlet.class);
    public static final String EVENTS = "Events";
    public static final Long DURATION = 86400000L;
    private Datastore datastore;
    private static final KeyFactory keyFactory = getKeyFactory(Users.class);

    @Override
    public void init() throws ServletException {
        datastore = getDatastore();
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        logger.info("Обновление событий ");
        List<Entity> listEntity = new ArrayList<>();
        Query<Entity> entityQuery = Query.newEntityQueryBuilder()
                .setKind(EVENTS)
                .setFilter(StructuredQuery.PropertyFilter.eq("active", true))
                .build();
        QueryResults<Entity> queryResults = datastore.run(entityQuery);
        for (QueryResults<Entity> it = queryResults; it.hasNext(); ) {
            listEntity.add(it.next());
        }
        if (listEntity.size() > 0) {
            for (Entity entity : listEntity) {
                Timestamp timestampValue = entity.getTimestamp("dateCreation").toSqlTimestamp();
                Long duration = Integer.parseInt(entity.getString("duration")) * DURATION;
                Date now = new Date();
                Date expires = new Date(timestampValue.getTime() + duration);
                if (now.after(expires)) {
                    updateEvent(entity);
                    updateUser(entity);
                }
            }
        }
        logger.info("Обновление событий прошло успешно");
        resp.setStatus(200);
    }

    private void updateUser(Entity event) {
        Transaction transaction = datastore.newTransaction();
        try {
            List<EntityValue> listUser = event.getList("userList");
            Long eventId = event.getKey().getId();
            for (EntityValue entityValue : listUser) {
                FullEntity user = entityValue.get();
                String userId = user.getString("userId");
                boolean isOrganize =  event.getString("userIdCreator").equals(userId);
                Entity userEntity = transaction.get(keyFactory.newKey(userId));
                List<EntityValue> list1 = new ArrayList<>();
                List<EntityValue> listParticipant = null;
                try {
                   listParticipant = userEntity.getList("listParticipant");
                } catch (Exception e) {
                    logger.warn(e);
                }

                if (Objects.nonNull(listParticipant) && Objects.nonNull(userEntity)) {
                    list1.addAll(listParticipant);
                    list1.add(EntityValue.of(getEntityEventUser(eventId, isOrganize)));
                    transaction.update(Entity.newBuilder(userEntity).set("listParticipant", ListValue.of(list1)).build());
                } else  {
                    list1.add(EntityValue.of(getEntityEventUser(eventId, isOrganize)));
                    transaction.update(Entity.newBuilder(userEntity).set("listParticipant", ListValue.of(list1)).build());
                }
            }

            logger.info("Завершили событие " + event.getString("description"));
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }

    private FullEntity getEntityEventUser(Long eventId, boolean userCreator) {
        FullEntity entity = FullEntity.newBuilder()
                .set("eventId", LongValue.of(eventId))
                .set("isOrganize", BooleanValue.of(userCreator))
                .build();
        return entity;
    }

    private void updateEvent(Entity event) {
        Transaction transaction = datastore.newTransaction();
        try {
            transaction.update(Entity.newBuilder(event).set("active", false).build());
            logger.info("Завершили событие " + event.getString("description"));
            transaction.commit();
        } finally {
            if (transaction.isActive()) {
                transaction.rollback();
            }
        }
    }
}


