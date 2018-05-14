package com.realsport.model.utils;


import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.FullEntity;
import com.google.cloud.datastore.KeyFactory;
import com.google.cloud.datastore.LatLng;
import com.google.cloud.datastore.LatLngValue;
import com.realsport.model.repository.impl.spb.data.BasketData;
import com.realsport.model.repository.impl.spb.data.FootData;
import com.realsport.model.repository.impl.spb.data.VoleyData;

import static com.realsport.model.dao.Persistence.getDatastore;
import static com.realsport.model.dao.Persistence.getKeyFactory;

public class Playgrounds {
    private static final KeyFactory keyFactory = getKeyFactory(Playgrounds.class);
    public void loadFootbalPlayground() {
        Datastore dataStore = getDatastore();
        for (FootData f : FootData.values()) {
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("city", f.getCity())
                    .set("house", f.getHouse())
                    .set("latlong", LatLngValue.of(LatLng.of(Double.valueOf(f.getLattitude()), Double.valueOf(f.getLongitude()))) )
                    .set("name", f.getName())
                    .set("sport", f.getSport())
                    .set("street", f.getStreet())
                    .build();
            dataStore.add(task);
        }
    }

    public void loadVoleyballPlayground() {
        Datastore dataStore = getDatastore();
        for (VoleyData f : VoleyData.values()) {
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("city", f.getCity())
                    .set("house", f.getHouse())
                    .set("latlong", LatLngValue.of(LatLng.of(Double.valueOf(f.getLattitude()), Double.valueOf(f.getLongitude()))) )
                    .set("name", f.getName())
                    .set("sport", f.getSport())
                    .set("street", f.getStreet())
                    .build();
            dataStore.add(task);
        }
    }

    public void loadBasketBallPlayground() {
        Datastore dataStore = getDatastore();
        for (BasketData f : BasketData.values()) {
            FullEntity task = FullEntity.newBuilder(keyFactory.newKey())
                    .set("city", f.getCity())
                    .set("house", f.getHouse())
                    .set("latlong", LatLngValue.of(LatLng.of(Double.valueOf(f.getLattitude()), Double.valueOf(f.getLongitude()))) )
                    .set("name", f.getName())
                    .set("sport", f.getSport())
                    .set("street", f.getStreet())
                    .build();
            dataStore.add(task);
        }
    }
}
