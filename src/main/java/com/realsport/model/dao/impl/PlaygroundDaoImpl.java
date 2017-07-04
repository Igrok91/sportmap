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


import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
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
    @Autowired
    private DataSource dataSource;

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
        Iterable<PlayfootballEntity> productsEntities = footRepository.findAllPlayfootball();
        List<Playfootball> list = new ArrayList<>();
        for (PlayfootballEntity p : productsEntities){
            Playfootball product = mapperFactory.map(p, Playfootball.class);
            list.add(product);
        }
        return list;
      /*  Connection conn = null;
        Statement ps = null;
        ResultSet rs = null;
        String sql;

        sql = "select * from playfootball";
        List<Playfootball> products = new ArrayList<Playfootball>();

        try {
            conn = dataSource.getConnection();
            ps = conn.createStatement();
            rs = ps.executeQuery(sql);

            while (rs.next()) {

                Playfootball p = new Playfootball();
                p.setLinks(rs.getString("links"));
                p.setIdplayground(rs.getInt("idplayground"));
                p.setLongitude(rs.getString("longitude"));
                p.setLatitude(rs.getString("latitude"));
                products.add(p);
            }
            System.out.println("succes");

        } catch (Exception e) {
            log.warn(e.getMessage());
            throw new DataBaseException();
        }
        return products;*/
    }

    @Override
    public List<Voleyball> getVoleyballPlayground() throws DataBaseException {
        Iterable<VoleyballEntity> productsEntities = voleyballRepository.findAllVoleyball();
        List<Voleyball> list = new ArrayList<>();
        for (VoleyballEntity p : productsEntities){
            Voleyball product = mapperFactory.map(p, Voleyball.class);
            list.add(product);
        }
        return list;

       /* Connection conn = null;
        Statement ps = null;
        ResultSet rs = null;
        String sql;

        sql = "select * from voleyball";
        List<Voleyball> products = new ArrayList<Voleyball>();

        try {
            conn = dataSource.getConnection();
            ps = conn.createStatement();
            rs = ps.executeQuery(sql);

            while (rs.next()) {

                Voleyball p = new Voleyball();
                p.setLinks(rs.getString("links"));
                p.setIdvoleyball(rs.getInt("idvoleyball"));
                p.setLongitude(rs.getString("longitude"));
                p.setLatitude(rs.getString("latitude"));
                System.out.println("succes" + p.getLatitude());
                products.add(p);
            }


        } catch (Exception e) {
            log.warn(e.getMessage());
            throw new DataBaseException();
        }
        return products;*/
    }

    @Override
    public List<Basketball> getBasketballPlayground() throws DataBaseException {
        Iterable<BasketballEntity> productsEntities = basketballRepository.findAllBasketball();
        List<Basketball> list = new ArrayList<>();
        for (BasketballEntity p : productsEntities){
            Basketball product = mapperFactory.map(p, Basketball.class);
            list.add(product);
        }
        return list;

      /*  Connection conn = null;
        Statement ps = null;
        ResultSet rs = null;
        String sql;

        sql = "select * from basketball";
        List<Basketball> products = new ArrayList<Basketball>();

        try {
            conn = dataSource.getConnection();
            ps = conn.createStatement();
            rs = ps.executeQuery(sql);

            while (rs.next()) {

                Basketball p = new Basketball();
                p.setLinks(rs.getString("links"));
                p.setIdbasketball(rs.getInt("idbasketball"));
                p.setLongitude(rs.getString("longitude"));
                p.setLatitude(rs.getString("latitude"));
                System.out.println("succes" + p.getLatitude());
                products.add(p);
            }
            System.out.println("succes");

        } catch (Exception e) {
            log.warn(e.getMessage());
            throw new DataBaseException();
        }
        return products;*/
    }
}
