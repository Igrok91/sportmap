package com.realsport.model.cache;

import com.google.appengine.api.memcache.stdimpl.GCacheFactory;

import javax.cache.Cache;
import javax.cache.CacheException;
import javax.cache.CacheFactory;
import javax.cache.CacheManager;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicReference;

public class CacheUser {

    private static AtomicReference<Cache> atomicReference = new AtomicReference<>();

    public static Cache getCacheUser() {
        if (atomicReference.get() == null) {
            try {
                CacheFactory cacheFactory = CacheManager.getInstance().getCacheFactory();
                Map<Object, Object> properties = new HashMap<>();
                properties.put(GCacheFactory.EXPIRATION_DELTA, TimeUnit.HOURS.toSeconds(1));
                atomicReference.set(cacheFactory.createCache(properties));
            } catch (CacheException e) {
                e.printStackTrace();
            }
        }

        return atomicReference.get();
    }
}
