package com.realsport.model.service;

import com.realsport.model.dao.DatastoreService;
import com.realsport.model.dao.PlaygroundDao;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

    @Qualifier("productDao")
    @Autowired
    private PlaygroundDao playgroundDao;

    @Autowired
    private DatastoreService datastoreService;


    public PlaygroundService() {

    }

    @Override
    public List<FootballPlayground> getFootballPlayground() throws DataBaseException {
        return playgroundDao.getFootballPlayground();
    }

    @Override
    public List<VoleyballPlayground> getVoleyballPlayground() throws DataBaseException {
        return playgroundDao.getVoleyballPlayground();
    }

    @Override
    public List<BasketballPlayground> getBasketballPlayground() throws DataBaseException {
        return playgroundDao.getBasketballPlayground();
    }

    @Override
    public FootballPlayground getFootballById(String id) throws DataBaseException {
        return  playgroundDao.getFootballById(id);
    }

    public List<User> getFootballPlayersGroupById(String id) {

        return datastoreService.getPlayersGroup(id, FOOTBALL_PLAYGROUND);
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
}
