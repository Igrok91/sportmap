package com.realsport.model.dao.kinds;

import com.google.cloud.datastore.*;
import com.realsport.model.vo.SubscribtionInfoUser;
import com.realsport.model.utils.Utils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

import java.util.Objects;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

@Component
public class Subscriptions {
    private Log logger = LogFactory.getLog(Subscriptions.class);
    private static final KeyFactory keyFactory = getKeyFactory(Subscriptions.class);

    public SubscribtionInfoUser getSubscriptionStatusUser(String userId) {
        Transaction tx = getDatastore().newTransaction();
        Entity user = null;
        try {
            user = tx.get(keyFactory.newKey(Long.valueOf(userId)));
            if (Objects.nonNull(user)) {
                return getSubscribtionInfoUser(user);
            }

        } catch (Exception e) {
            logger.error("Ошибка при регистрации подписки: " + e);
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }
        return null;
    }

    private SubscribtionInfoUser getSubscribtionInfoUser(Entity user) {
        SubscribtionInfoUser infoUser = new SubscribtionInfoUser(user.getString("status"), (int) user.getLong("subscription_id"));
        return infoUser;
    }


    public Long addSubscriptionToUser(Integer user_id, Integer subscription_id, String item_id, Integer item_price) {
        Transaction tx = getDatastore().newTransaction();
        Entity user = null;
        try {
            user = tx.get(keyFactory.newKey(user_id));
            if (Objects.isNull(user)) {
                FullEntity task = FullEntity.newBuilder(keyFactory.newKey(user_id))
                        .set("subscription_id", LongValue.of(subscription_id))
                        .set("userId", user_id)
                        .set("item_id", item_id)
                        .set("item_price", LongValue.of(item_price))
                        .set("status", Utils.ACTIVE)
                        .build();
                Entity entity = tx.add(task);
                tx.commit();
                return entity.getKey().getId();
            } else {
                tx.update(Entity.newBuilder(user).set("status", Utils.ACTIVE).build());
                tx.commit();
                return user.getKey().getId();
            }

        } catch (Exception e) {
            logger.error("Ошибка при регистрации подписки: " + e);
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }
        return null;
    }

    public Long setSubscriptionStatusUser(Integer user_id, String cancel_reason, String status) {
        Transaction tx = getDatastore().newTransaction();
        Entity userEntity = null;
        try {
            userEntity = tx.get(keyFactory.newKey(Long.valueOf(user_id)));
            if (Objects.nonNull(userEntity)) {
                if (cancel_reason != null) {
                    tx.update(Entity.newBuilder(userEntity)
                            .set("status", status.trim())
                            .set("cancel_reason", cancel_reason.trim())
                            .build());
                } else {
                    tx.update(Entity.newBuilder(userEntity).set("status", status.trim()).build());
                }
                tx.commit();
                return userEntity.getKey().getId();
            }

        } catch (Exception e) {
            logger.error("Ошибка при изменении статуса подписки: " + e);
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }
        return null;
    }

    public boolean isPremiumUser(String userId) {
        Transaction tx = getDatastore().newTransaction();
        Entity userEntity = null;
        try {
            userEntity = tx.get(keyFactory.newKey(Long.valueOf(userId)));
            if (Objects.nonNull(userEntity)) {
                return userEntity.getString("status").equals(Utils.ACTIVE);
            } else {
                return false;
            }

        } catch (Exception e) {
            logger.error("Ошибка при получении статуса подписки: " + e);
        } finally {
            if (tx.isActive()) {
                tx.rollback();
            }
        }
        return false;
    }
}
