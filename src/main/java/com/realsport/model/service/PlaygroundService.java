package com.realsport.model.service;

import com.realsport.model.dao.PlaygroundDao;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.Basketball;
import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.entityDao.Voleyball;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;


import java.util.List;

/**
 * Created by Igor Ryabtsev on 28.12.2016.
 * Класс определят сервис для получения данных из БД и вычисления Бизнес логики
 */
@Service
public class PlaygroundService implements PlaygroundDao{

    @Qualifier("productDao")
    @Autowired
    private PlaygroundDao playgroundDao;


    public PlaygroundService() {

    }

    @Override
    public List<Playfootball> getFootballPlayground() throws DataBaseException {
        return playgroundDao.getFootballPlayground();
    }

    @Override
    public List<Voleyball> getVoleyballPlayground() throws DataBaseException {
        return playgroundDao.getVoleyballPlayground();
    }

    @Override
    public List<Basketball> getBasketballPlayground() throws DataBaseException {
        return playgroundDao.getBasketballPlayground();
    }

}
