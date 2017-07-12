package com.realsport.vk;

import com.vk.api.sdk.client.TransportClient;
import com.vk.api.sdk.client.VkApiClient;
import com.vk.api.sdk.client.actors.GroupActor;
import com.vk.api.sdk.exceptions.ApiException;
import com.vk.api.sdk.exceptions.ClientException;
import com.vk.api.sdk.httpclient.HttpTransportClient;
import com.vk.api.sdk.objects.GroupAuthResponse;
import org.springframework.stereotype.Component;

/**
 * Created by sbt-ryabtsev-is on 12.07.2017.
 */
@Component
public class initVk {

    private static final Integer GROUP_ID = 6098255;
    private static final String ACCESS_TOKEN = "";

    private static TransportClient transportClient = new HttpTransportClient();
    private static VkApiClient vk = new VkApiClient(transportClient);
    private static GroupActor actor = new GroupActor(GROUP_ID, ACCESS_TOKEN);


    public VkApiClient getVk() {
        return vk;
    }

    public GroupActor getGroupActor(){
        return actor;
    }
}
