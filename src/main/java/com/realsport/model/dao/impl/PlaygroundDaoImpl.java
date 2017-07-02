package com.realsport.model.dao.impl;

import com.realsport.model.dao.PlaygroundDao;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.entityJPA.BasketballEntity;
import com.realsport.model.entityDao.entityJPA.PlayfootballEntity;
import com.realsport.model.entityDao.entityJPA.VoleyballEntity;
import com.realsport.model.entityDao.pojo.Basketball;
import com.realsport.model.entityDao.pojo.Playfootball;
import com.realsport.model.entityDao.pojo.Voleyball;
import com.realsport.model.repository.BasketballRepository;
import com.realsport.model.repository.PlayfootballRepository;
import com.realsport.model.repository.VoleyballRepository;
import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.MapperFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;


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

    private MapperFacade mapperFactory;
    @Autowired
    public void setMapperFactory(MapperFactory mapperFactory) {
        this.mapperFactory = mapperFactory.getMapperFacade();
    }


    /**
     *   Method to get all products available
     * @return List of product
     * @throws DataBaseException
     */
    @Override
    public List<Playfootball> getFootballPlayground()  throws DataBaseException {
        Iterable<PlayfootballEntity> productsEntities = footRepository.findAll();
        List<Playfootball> list = new ArrayList<>();
        for (PlayfootballEntity p : productsEntities){
            Playfootball product = mapperFactory.map(p, Playfootball.class);
            list.add(product);
        }
        return list;
    }

    @Override
    public List<Voleyball> getVoleyballPlayground() throws DataBaseException {
        Iterable<VoleyballEntity> productsEntities = voleyballRepository.findAll();
        List<Voleyball> list = new ArrayList<>();
        for (VoleyballEntity p : productsEntities){
            Voleyball product = mapperFactory.map(p, Voleyball.class);
            list.add(product);
        }
        return list;
    }

    @Override
    public List<Basketball> getBasketballPlayground() throws DataBaseException {
        Iterable<BasketballEntity> productsEntities = basketballRepository.findAll();
        List<Basketball> list = new ArrayList<>();
        for (BasketballEntity p : productsEntities){
            Basketball product = mapperFactory.map(p, Basketball.class);
            list.add(product);
        }
        return list;
    }
}
