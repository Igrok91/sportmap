package com.realsport.dao.cache;

import com.google.appengine.api.memcache.MemcacheService;
import com.google.appengine.api.memcache.MemcacheServiceFactory;

import java.util.concurrent.atomic.AtomicReference;

public class CacheObserver {

    private static AtomicReference<MemcacheService> memcacheServiceAtomicReference = new AtomicReference<>();

    public static MemcacheService getCacheObserver() {
        if (memcacheServiceAtomicReference.get() == null) {
            //datastore.set(DatastoreOptions.newBuilder().setProjectId(PROJECT_ID).build().getService());
            memcacheServiceAtomicReference.set(MemcacheServiceFactory.getMemcacheService());
        }

        return memcacheServiceAtomicReference.get();
    }
}
