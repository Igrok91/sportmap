package com.realsport.model.service;

import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.User;
import org.springframework.stereotype.Service;

import java.util.*;

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
            //listFoot.add(game);
    }

    public List<Event> getEvents( List<String> playgroundFoottUser, List<String> playgroundBaskettUser, List<String> playgroundVoleyUser) {
        List<Event> eventList = new ArrayList<>();
        // Достаем из бд активные события.
        if (playgroundFoottUser.size() != 0) {
            allFootbalEventSpb = getAllFootEventsSpb(playgroundFoottUser);
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
        event2.setMaxCountAnswer(10);
        event2.setAnswer("+");
        event2.setDuration("2");
        event2.setSport(VOLEYBALL);
        event2.setPlaygroundId("10");
        event2.setPlaygroundName("У Школы №33");
        List<Event> listStub = new ArrayList<>();
        event2.setUserFirtsNameCreator("Игорь");
        event2.setUserLastNameCreator("Рябцев");
        listStub.add(event2);
        return listStub;

    }

    private List<Event> getAllBasketEventsSpb(List<String> playgroundFoottUser) {
        List<Event> listStub = new ArrayList<>();
        Event event = new Event();
        event.setUserIdCreator("3");
        event.setIdEvent("12345");
        event.setDescription("Го на игру в 9?");
        event.setMaxCountAnswer(0);
        event.setAnswer("+");
        event.setDuration("1");
        event.setSport(BASKETBALL);
        event.setPlaygroundId("10");
        event.setPlaygroundName("У Школы №34");
        event.setUserFirtsNameCreator("Леонид");
        event.setUserLastNameCreator("Заручевский");
        event.setUserList(Collections.singletonList(new User()));
        listStub.add(event);
        return listStub;
    }

    private List<Event> getAllFootEventsSpb(List<String> playgroundFoottUser) {
        List<Event>  listFoot= new ArrayList<>();
        Event event = new Event();
        event.setUserIdCreator("2");
        event.setIdEvent("123");
        event.setDescription("Го на игру в 8?");
        event.setMaxCountAnswer(0);
        event.setAnswer("+");
        event.setDuration("1");
        event.setSport(FOOTBALL);
        event.setPlaygroundId("15");
        event.setPlaygroundName("У Школы №23");
        event.setUserFirtsNameCreator("Леонид");
        event.setUserLastNameCreator("Заручевский");
        event.setMaxCountAnswer(21);
        event.setUserList(Collections.singletonList(new User()));
        listFoot.add(event);
        return listFoot;
    }

    public Event createEventByTemplate(String templateId) {
        Event  game = new Event();
        game.setDescription("template");
        game.setAnswer("+");
        game.setMaxCountAnswer(0);
        game.setDuration("5");
        game.setUserIdCreator("2312312");
        game.setPlaygroundId("23555");
        game.setSport("Футбол");
        game.setDateCreation(new Date());
        game.setPlaygroundName("template");

        return game;
    }
}
