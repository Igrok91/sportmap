package com.realsport.service;

import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.dao.DatastoreService;
import com.realsport.model.dao.PlaygroundDao;
import com.realsport.model.vo.CheckPlaygroundData;
import com.realsport.model.vo.MinUser;
import com.realsport.model.dao.entityDao.Playground;
import com.realsport.model.utils.KindSport;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

import static com.realsport.model.cache.CachePlaygrounds.getCachePlaygrounds;

/**
 * Created by Igor Ryabtsev on 28.12.2016.
 * Класс определят сервис для получения данных из БД и вычисления Бизнес логики
 */
@Service
public class PlaygroundService implements PlaygroundDao {

    private Log logger = LogFactory.getLog(PlaygroundService.class);
    public static final String PLAYGROUNDS_DATA = "playgroundsData";

    @Autowired
    private DatastoreService datastoreService;


    public PlaygroundService() {

    }

    @Override
    public List<Playground> getFootballPlayground(List<Playground> allPlaygroundList) {
        List<Playground> footballPlaygrounds = FluentIterable.from(allPlaygroundList).filter(new Predicate<Playground>() {
            @Override
            public boolean apply(Playground playground) {
                return playground.getSport().equals(KindSport.FOOTBALL.getSport());
            }
        }).toList();
        return footballPlaygrounds;
    }

    @Override
    public List<Playground> getVoleyballPlayground(List<Playground> allPlaygroundList) {
        List<Playground> playgrounds = FluentIterable.from(allPlaygroundList).filter(new Predicate<Playground>() {
            @Override
            public boolean apply(Playground playground) {
                return playground.getSport().equals(KindSport.VOLEYBALL.getSport());
            }
        }).toList();
        return playgrounds;
    }

    @Override
    public List<Playground> getBasketballPlayground(List<Playground> allPlaygroundList) {
        List<Playground> playgrounds = FluentIterable.from(allPlaygroundList).filter(new Predicate<Playground>() {
            @Override
            public boolean apply(Playground playground) {
                return playground.getSport().equals(KindSport.BASKETBALL.getSport());
            }
        }).toList();
        return playgrounds;
    }


    public List<Playground> getAllPlayground() {
        List<Playground> playgroundsFromCache = null;
        try {
            playgroundsFromCache = (List<Playground>) getCachePlaygrounds().get(PLAYGROUNDS_DATA);
        } catch (Exception e) {
            logger.error(e);
        }

        if (Objects.nonNull(playgroundsFromCache)) {
            logger.info("Берем данные площадок из кеша ");
            return playgroundsFromCache;
        } else {
            logger.info("Берем данные площадок из бд ");
            List<Playground> playgrounds = datastoreService.getAllPlayground();
            if (Objects.nonNull(playgrounds)) {
                getCachePlaygrounds().put(PLAYGROUNDS_DATA, playgrounds);
            }
            return playgrounds;
        }
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

    public void addPlaygroundToCheck(Double lat, Double lng, String sport, String userId) {
        datastoreService.addPlaygroundToCheck(lat, lng, sport, userId);
    }

    public List<CheckPlaygroundData> getPlaygroundsCheck() {
        return datastoreService.getPlaygroundsCheck();
    }

    public Long addPlaygroundToDB(String userId, String lat, String lng, String name, String city, String street, String house, String sport) {
        return datastoreService.addPlaygroundToDB(userId, lat, lng, name, city, street, house, sport);
    }

    public void deleteNotification(String idPlayground) {
        datastoreService.deleteNotification(idPlayground);
    }
}
