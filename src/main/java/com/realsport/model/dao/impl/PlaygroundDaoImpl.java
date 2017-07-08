package com.realsport.model.dao.impl;

import com.realsport.model.dao.PlaygroundDao;
import com.realsport.model.dao.daoException.DataBaseException;

import com.realsport.model.entityDao.Basketball;
import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.entityDao.Voleyball;
import com.realsport.model.repository.BasketballRepository;
import com.realsport.model.repository.PlayfootballRepository;
import com.realsport.model.repository.VoleyballRepository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


import javax.sql.DataSource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Igor Ryabtsev on 28.12.2016.
 * Класс, определяющий методы для получения данных из БД, о
 * пределяющие содержимое пользовательского интерфейса
 */


public class PlaygroundDaoImpl implements PlaygroundDao {
    private static Logger log = LoggerFactory.getLogger(PlaygroundDaoImpl.class);

    @Autowired
    private PlayfootballRepository footRepository;

    @Autowired
    private VoleyballRepository voleyballRepository;

    @Autowired
    private BasketballRepository basketballRepository;


    /**
     *   Method to get all products available
     * @return List of product
     * @throws DataBaseException
     */
    @Override
    public List<Playfootball> getFootballPlayground()  throws DataBaseException {
        List<Playfootball> list = footRepository.findAllPlayfootball();

        return list;
    }

    @Override
    public List<Voleyball> getVoleyballPlayground() throws DataBaseException {
        List<Voleyball> list = voleyballRepository.findAllVoleyball();
        return list;
    }

    @Override
    public List<Basketball> getBasketballPlayground() throws DataBaseException {
        List<Basketball> list = basketballRepository.findAllBasketball();
        return list;
    }
}
