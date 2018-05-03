package com.realsport.vk;

import com.vk.api.sdk.client.TransportClient;
import com.vk.api.sdk.client.VkApiClient;
import com.vk.api.sdk.client.actors.GroupActor;
import com.vk.api.sdk.httpclient.HttpTransportClient;

import java.util.concurrent.atomic.AtomicReference;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
public  class InitVkMain {

    private static final Integer GROUP_ID = 148660655;

    private static final String ACCESS_TOKEN = "e3715ec9efbfa67968d33bedbe8080989364423236d2a43d77ab15e0c7d0c8923db1920833f18bd4d2be7";

    private static AtomicReference<VkApiClient> vkApiClient = new AtomicReference<>();
    private static AtomicReference<GroupActor> groupActor = new AtomicReference<>();

    public static VkApiClient getVkApiClient() {
        if (vkApiClient.get() == null) {
            TransportClient transportClient = new HttpTransportClient();
            vkApiClient.set(new VkApiClient(transportClient));
        }

        return vkApiClient.get();
    }

    public static GroupActor getGroupActor() {
        if (groupActor.get() == null) {
            groupActor.set(new GroupActor(GROUP_ID, ACCESS_TOKEN));
        }

        return groupActor.get();
    }


    public static String getAccessToken() {
        return ACCESS_TOKEN;
    }
}
