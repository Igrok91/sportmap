package com.realsport.model.service;

import com.google.appengine.api.memcache.MemcacheService;

import com.realsport.model.entity.LastEditData;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import java.util.Date;

import static com.realsport.model.cache.CacheObserver.getCacheObserver;

@Service
public class CacheService {
    private Log logger = LogFactory.getLog(CacheService.class);

    public void putToCache(String eventId, String userId) throws Exception {
        logger.info("Добавляем последнюю дату изменения ");
        for (long delayMs = 1; delayMs < 1000; delayMs *= 2) {
            MemcacheService syncCache = getCacheObserver();
            MemcacheService.IdentifiableValue oldValue = syncCache.getIdentifiable(eventId);
            LastEditData lastEditData = new LastEditData(new Date(), userId);
            if (oldValue == null) {
                // Key doesn't exist. We can safely put it in cache.
                syncCache.put(eventId, lastEditData);
                break;
            } else if (syncCache.putIfUntouched(eventId, oldValue, lastEditData)) {
                // newValue has been successfully put into cache.
                break;
            } else {
                // Some other client changed the value since oldValue was retrieved.
                // Wait a while before trying again, waiting longer on successive loops.
                try {
                    Thread.sleep(delayMs);
                } catch (InterruptedException e) {
                    throw new Exception("Error when sleeping", e);
                }
            }
        }
    }

}
