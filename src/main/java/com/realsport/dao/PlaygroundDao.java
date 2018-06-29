package com.realsport.dao;

import com.realsport.dao.vo.Playground;

import java.util.List;

/**
 * Created by Igor Ryabtsev on 28.12.2016.
 * Интерфейс определяет основные методы полученя данных из БД
 */
public interface PlaygroundDao {
    /**
     * Method to get all playground available
     *
     * @param allPlaygroundList
     * @return List of product
     */
    List<Playground> getFootballPlayground(List<Playground> allPlaygroundList);

    /**
     * Method to get all playground available
     *
     * @param allPlaygroundList
     * @return List of product
     */
    List<Playground> getVoleyballPlayground(List<Playground> allPlaygroundList);

    /**
     * Method to get all playground available
     *
     * @return List of product
     */
    List<Playground> getBasketballPlayground(List<Playground> allPlaygroundList);


}
