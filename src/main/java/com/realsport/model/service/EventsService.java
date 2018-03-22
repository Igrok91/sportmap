package com.realsport.model.service;

import com.realsport.model.entityDao.Event;
import com.realsport.model.repository.impl.spb.data.FootData;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class EventsService {

    public static final String FOOTBALL = "Футбол";
    public static final String BASKETBALL = "Баскетбол";
    public static final String VOLEYBALL = "Волейбол";
    private List<Event> allFootbalEventSpb = new ArrayList<>();
    private List<Event> allBasketEventSpb = new ArrayList<>();
    private List<Event> allVoleyEventSpb = new ArrayList<>();




    private List<Event> getAllEvents() {
        return null;
    }

    public void publishEvent(Event game, String userId) {
            game.setIdEvent("2323");
        allFootbalEventSpb.add(game);
    }

    public List<Event> getEvents(Event game, List<String> playgroundFoottUser, List<String> playgroundBaskettUser, List<String> playgroundVoleyUser) {
        List<Event> eventList = new ArrayList<>();
        // Достаем из бд активные события.
        if (playgroundFoottUser.size() != 0) {
            allFootbalEventSpb.addAll(getAllFootEventsSpb(playgroundFoottUser));
            eventList.addAll(allFootbalEventSpb);
        }

        if (playgroundBaskettUser.size() != 0) {
            allBasketEventSpb = getAllBasketEventsSpb(playgroundFoottUser);
            eventList.addAll(allBasketEventSpb);
        }

        if (playgroundVoleyUser.size() != 0) {
            allVoleyEventSpb = getAllVoleyEventsSpb(playgroundFoottUser);
            eventList.addAll(allVoleyEventSpb);
        }

        return eventList;
    }

    private List<Event> getAllVoleyEventsSpb(List<String> playgroundFoottUser) {
        Event event2 = new Event();
        event2.setUserIdCreator("5");
        event2.setIdEvent("1234");
        event2.setDescription("Го на игру в 9?");
        event2.setCountAnswer(10);
        event2.setListAnswer(Collections.singletonList("+"));
        event2.setDuration("2");
        event2.setSport(VOLEYBALL);
        event2.setPlaygroundId("10");
        List<Event> listStub = new ArrayList<>();
        listStub.add(event2);
        return listStub;

    }

    private List<Event> getAllBasketEventsSpb(List<String> playgroundFoottUser) {
        List<Event> listStub = new ArrayList<>();
        Event event = new Event();
        event.setUserIdCreator("3");
        event.setIdEvent("1234");
        event.setDescription("Го на игру в 9?");
        event.setCountAnswer(0);
        event.setListAnswer(Collections.singletonList("+"));
        event.setDuration("1");
        event.setSport(BASKETBALL);
        event.setPlaygroundId("10");
        listStub.add(event);
        return listStub;
    }

    private List<Event> getAllFootEventsSpb(List<String> playgroundFoottUser) {
        List<Event> listStub = new ArrayList<>();
        Event event = new Event();
        event.setUserIdCreator("2");
        event.setIdEvent("123");
        event.setDescription("Го на игру в 8?");
        event.setCountAnswer(0);
        event.setListAnswer(Collections.singletonList("+"));
        event.setDuration("1");
        event.setSport(FOOTBALL);
        event.setPlaygroundId("15");
        listStub.add(event);
        return listStub;
    }
}
