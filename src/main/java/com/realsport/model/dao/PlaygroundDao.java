package com.realsport.model.dao;

import com.realsport.model.entityDao.Playground;

import java.util.List;

/**
 * Created by Igor Ryabtsev on 28.12.2016.
 * Интерфейс определяет основные методы полученя данных из БД
 */
public interface PlaygroundDao {
    /**
     *   Method to get all playground available
     * @return List of product
     * @param allPlaygroundList
     */
    List<Playground> getFootballPlayground(List<Playground> allPlaygroundList);

    /**
     *   Method to get all playground available
     * @return List of product
     * @param allPlaygroundList
     */
    List<Playground> getVoleyballPlayground(List<Playground> allPlaygroundList);

    /**
     *   Method to get all playground available
     * @return List of product
     */
    List<Playground> getBasketballPlayground(List<Playground> allPlaygroundList);


}
