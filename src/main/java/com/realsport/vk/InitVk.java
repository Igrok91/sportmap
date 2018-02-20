package com.realsport.vk;

import com.vk.api.sdk.client.TransportClient;
import com.vk.api.sdk.client.VkApiClient;
import com.vk.api.sdk.client.actors.GroupActor;
import com.vk.api.sdk.httpclient.HttpTransportClient;
import org.springframework.stereotype.Component;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
public  class InitVk {

    private static InitVk initVk;

    private static final Integer GROUP_ID = 6098255;



    private static final String ACCESS_TOKEN = "0b7f21f4057408fb061cb2fa5a7fac6b3f6c2e932566a03a332bea30aac6441e81a8cc7fe0ab56126f71e";

    private static TransportClient transportClient = new HttpTransportClient();
    private static VkApiClient vk = new VkApiClient(transportClient);
    private static GroupActor actor = new GroupActor(GROUP_ID, ACCESS_TOKEN);

/*    public static synchronized InitVk getInstance(){
        if (initVk == null) {
            initVk = new InitVk();
        }
        return initVk;
    }*/

    public  static VkApiClient getVk() {
        return vk;
    }

    public static GroupActor getGroupActor(){
        return actor;
    }

    public static String getAccessToken() {
        return ACCESS_TOKEN;
    }
}
