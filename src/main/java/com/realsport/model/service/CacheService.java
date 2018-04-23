package com.realsport.model.service;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;
import com.google.appengine.api.memcache.stdimpl.GCacheFactory;
import com.realsport.model.cache.CacheUser;
import com.realsport.model.entity.LastEditData;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.cache.Cache;
import javax.cache.CacheException;
import javax.cache.CacheFactory;
import javax.cache.CacheManager;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static com.realsport.model.cache.CacheObserver.getCacheObserver;

@Service
public class CacheService {
    private Log logger = LogFactory.getLog(CacheService.class);

    public void putToCache(String playgroundId, String userId) throws Exception {
        logger.info("Добавляем последнюю дату изменения ");
        for (long delayMs = 1; delayMs < 1000; delayMs *= 2) {
            MemcacheService syncCache = getCacheObserver();
            MemcacheService.IdentifiableValue oldValue = syncCache.getIdentifiable(playgroundId);
            LastEditData lastEditData = new LastEditData(new Date(), userId);
            if (oldValue == null) {
                // Key doesn't exist. We can safely put it in cache.
                syncCache.put(playgroundId, lastEditData);
                break;
            } else if (syncCache.putIfUntouched(playgroundId, oldValue, lastEditData)) {
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
