package com.realsport.model.cache;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

import javax.cache.CacheFactory;
import javax.cache.CacheManager;
import java.util.concurrent.atomic.AtomicReference;

public class CacheObserver {

    private static AtomicReference<MemcacheService> memcacheServiceAtomicReference =  new AtomicReference<>();

    public static MemcacheService getCacheObserver() {
        if (memcacheServiceAtomicReference.get() == null) {
            //datastore.set(DatastoreOptions.newBuilder().setProjectId(PROJECT_ID).build().getService());
            memcacheServiceAtomicReference.set(MemcacheServiceFactory.getMemcacheService());
        }

        return memcacheServiceAtomicReference.get();
    }
}
