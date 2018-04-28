package com.realsport.model.service;

import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.dao.DatastoreService;
import com.realsport.model.dao.PlaygroundDao;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.utils.KindSport;
import com.realsport.model.entityDao.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Created by Igor Ryabtsev on 28.12.2016.
 * Класс определят сервис для получения данных из БД и вычисления Бизнес логики
 */
@Service
public class PlaygroundService implements PlaygroundDao{

    public static final String FOOTBALL = "Футбол";
    public static final String BASKETBALL = "Баскетбол";
    public static final String VOLEYBALL = "Волейбол";


    public static final String FOOTBALL_PLAYGROUND = "FootballPlayground";
    public static final String BASKETBALL_PLAYGROUND = "BasketballPlayground";
    public static final String VOLEYBALL_PLAYGROUND = "VoleyballPlayground";


    @Autowired
    private DatastoreService datastoreService;


    public PlaygroundService() {

    }

    @Override
    public List<Playground> getFootballPlayground(List<Playground> allPlaygroundList) throws DataBaseException {
        List<Playground> footballPlaygrounds = FluentIterable.from(allPlaygroundList).filter(new Predicate<Playground>() {
            @Override
            public boolean apply(Playground playground) {
                return playground.getSport().equals(KindSport.FOOTBALL.getSport());
            }
        }).toList();
        return footballPlaygrounds;
    }

    @Override
    public List<Playground> getVoleyballPlayground(List<Playground> allPlaygroundList) throws DataBaseException {
        List<Playground> playgrounds = FluentIterable.from(allPlaygroundList).filter(new Predicate<Playground>() {
            @Override
            public boolean apply(Playground playground) {
                return playground.getSport().equals(KindSport.VOLEYBALL.getSport());
            }
        }).toList();
        return playgrounds;
    }

    @Override
    public List<Playground> getBasketballPlayground(List<Playground> allPlaygroundList) throws DataBaseException {
        List<Playground> playgrounds = FluentIterable.from(allPlaygroundList).filter(new Predicate<Playground>() {
            @Override
            public boolean apply(Playground playground) {
                return playground.getSport().equals(KindSport.BASKETBALL.getSport());
            }
        }).toList();
        return playgrounds;
    }




    public List<Event> getFootballEventsById(String id) {
        List<Event>  listFoot= new ArrayList<>();
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

        Event event2 = new Event();
        event2.setUserIdCreator("172924708");
        event2.setIdEvent("172924708");
        event2.setDescription("Го играть в выходные?");
        event2.setMaxCountAnswer(0);
        event2.setAnswer("+");
        event2.setDuration("1");
        event2.setSport(FOOTBALL);
        event2.setPlaygroundId("15");
        event2.setPlaygroundName("У Школы №4");
        event2.setUserFirtsNameCreator("Рябцев");
        event2.setUserLastNameCreator("Игорь");
        event2.setMaxCountAnswer(21);
        Event event3 = new Event();
        event3.setUserIdCreator("172924708");
        event3.setIdEvent("172924708");
        event3.setDescription("Го играть в выходные?\n\n\n\n");
        event3.setMaxCountAnswer(0);
        event3.setAnswer("+");
        event3.setDuration("1");
        event3.setSport(FOOTBALL);
        event3.setPlaygroundId("15");
        event3.setPlaygroundName("У Школы №4");
        event3.setUserFirtsNameCreator("Рябцев");
        event3.setUserLastNameCreator("Игорь");
        event3.setMaxCountAnswer(21);
        listFoot.add(event);
        listFoot.add(event2);
        listFoot.add(event3);
        return listFoot;
    }

    public List<User> getBasketballPlayersById(String id) {
        List<User> userList = new ArrayList<>();
        User user3 = new User();
        user3.setUserId("1729247081");
        User user = new User();
        user.setUserId("172924708");
        userList.add(user);
        userList.add(user3);
        return userList;
    }

    public List<Event> getBasketballPlayById(String id) {
        return new ArrayList<>();
    }

    public List<User> getVoleyPlayersById(String id) {
        List<User> userList = new ArrayList<>();
        User user3 = new User();
        user3.setUserId("1729247081");
        User user = new User();
        user.setUserId("172924708");
        userList.add(user);
        userList.add(user3);
        return userList;
    }

    public List<Event> getVoleyPlayById(String id) {
        return Collections.singletonList(new Event());
    }

    public List<Playground> getAllPlayground() {
        return datastoreService.getAllPlayground();
    }

    public Playground getPlaygroundById(String idGroup) {
        return datastoreService.getPlaygroundById(idGroup);
    }

    public void addUserToPlayground(MinUser minUser, String playgroundId) {
        datastoreService.addUserToPlayground(minUser, playgroundId);
    }

    public void deleteUserFromPlayground(String userId, String playgroundId) {
        datastoreService.deleteUserFromPlayground(userId, playgroundId);
    }
}
