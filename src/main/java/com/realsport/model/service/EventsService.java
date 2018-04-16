package com.realsport.model.service;

import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.dao.DatastoreService;
import com.realsport.model.entityDao.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class EventsService {
    private Log logger = LogFactory.getLog(EventsService.class);

    @Autowired
    private DatastoreService databaseService;

    public static final String FOOTBALL = "Футбол";
    public static final String BASKETBALL = "Баскетбол";
    public static final String VOLEYBALL = "Волейбол";
    private List<Event> allFootbalEvent = new ArrayList<>();
    private List<Event> allBasketEventSpb = new ArrayList<>();
    private List<Event> allVoleyEventSpb = new ArrayList<>();


    public static final String FOOTBALL_PLAYGROUND = "FootballPlayground";
    public static final String BASKETBALL_PLAYGROUND = "BasketballPlayground";
    public static final String VOLEYBALL_PLAYGROUND = "VoleyballPlayground";


    private List<Event> getAllEvents() {
        return null;
    }

    public void publishEvent(Event game) {
        databaseService.publishEvent(game);
    }

    public List<Event> getEvents(List<String> playgroundUser) {
        List<Event> eventOfGroupUser = new ArrayList<>();
        // Достаем из бд активные события.
        if (playgroundUser.size() != 0) {
            List<Event> allActiveEventList = databaseService.getAllEvents();


            if (allActiveEventList.size() != 0) {
                for (String id : playgroundUser) {
                    List<Event> event = FluentIterable.from(allActiveEventList).filter(new Predicate<Event>() {
                        @Override
                        public boolean apply(Event event) {
                            return event.getPlaygroundId().equals(id);
                        }
                    }).toList();
                    if (Objects.nonNull(event)) {
                        eventOfGroupUser.addAll(event);
                    }
                }
            }
        }
        return eventOfGroupUser;
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
        List<Event> listFoot = new ArrayList<>();
        Event event = new Event();
        event.setUserIdCreator("172924708");
        event.setIdEvent("172924708");
        event.setDescription("Го на игру в 8?");
        event.setMaxCountAnswer(0);
        event.setAnswer("+");
        event.setDuration("1");
        event.setSport(FOOTBALL);
        event.setPlaygroundId("15");
        event.setPlaygroundName("У Школы №4");
        event.setUserFirtsNameCreator("Леонид");
        event.setUserLastNameCreator("Заручевский");
        event.setMaxCountAnswer(21);

        List<User> userList = new ArrayList<>();
        User user2 = new User();
        user2.setUserId("1729247081");
        user2.setFake(true);
        user2.setCountFake(3);
        User user3 = new User();
        user3.setUserId("1729247081");
        User user = new User();
        user.setUserId("172924708");
        userList.add(user);
        userList.add(user3);
        userList.add(user2);
        event.setUserList(userList);
        Comment comment = new Comment();
        comment.setCommentId("2");
        comment.setFirstName("Игорь");
        comment.setLastName("Рябцев");
        comment.setDate("сегодня в 12:12");
        comment.setMessage("Еще + 5");
        comment.setUserId("17292479038");
        event.setCommentsList(Collections.singletonList(comment));
        HistoryEvent event1 = new HistoryEvent();
        event1.setFirstName("Игорь");
        event1.setLastName("Рябцев");
        event1.setDate("сегодня в 12:12");
        event1.setAction("создал опрос");
        event1.setUserId("12345*-");
        event.setHistoryEvent(Collections.singletonList(event1));
        listFoot.add(event);
        return listFoot;
    }

    public Event createEventByTemplate(String templateId) {
        Event game = new Event();
        game.setDescription("template");
        game.setAnswer("+");
        game.setMaxCountAnswer(0);
        game.setDuration("5");
        game.setUserIdCreator("2312312");
        game.setPlaygroundId("23555");
        game.setSport("Футбол");
        //game.setDateCreation(new Date());
        game.setPlaygroundName("template");

        return game;
    }

    public Event getEventById(String eventId) {
        return databaseService.getEventById(eventId);
    }

    public void editEventById(String eventId) {

    }

    public void deleteGame(String eventId) {


    }

    public void editUserAnswer(String eventId, String userId) {

    }


    public void deleteUserFromEvent(String eventId, String userId) {
        databaseService.deleteUserFromEvent(eventId, userId);
    }

    public int addCommentToEvent(String eventId, Comment message) {

        return 1;
    }

    public void deleteCommentFromEvent(String commentId, String eventId) {


    }

    public List<Comment> getCommentFromEventById(String eventId) {
        Comment comment = new Comment();
        comment.setCommentId("3");
        comment.setFirstName("Игорь");
        comment.setLastName("Рябцев");
        comment.setDate("сегодня в 12:12");
        comment.setMessage("Еще + 5");
        comment.setUserId("1729247038");
        List<Comment> list = new ArrayList<>();
        list.add(comment);
        return list;
    }

    public void addCountIgrokFromUser(String userId, String eventId, Integer integer) {

    }

    public void addIgrokToListFromUser(String eventId, String userId, String count) {

    }


    public void deletePlaygroundFromUser(String userId, String playgroundId) {
        databaseService.deletePlaygroundFromUser(userId, playgroundId);
    }

    public void endGame(String eventId) {

    }

    public List<Event> getEventsByIdGroup(String id) {
        return new ArrayList<>();

    }

    public void addUserToEvent(String eventId, User user, boolean isFake) {
        databaseService.addUserToEvent(eventId, user, isFake);
    }
}
