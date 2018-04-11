package com.realsport.model.dao;



import com.realsport.model.dao.daoException.DataBaseException;
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
     * @throws DataBaseException
     * @param allPlaygroundList
     */
    List<Playground> getFootballPlayground(List<Playground> allPlaygroundList) throws DataBaseException;

    /**
     *   Method to get all playground available
     * @return List of product
     * @throws DataBaseException
     * @param allPlaygroundList
     */
    List<Playground> getVoleyballPlayground(List<Playground> allPlaygroundList) throws DataBaseException;

    /**
     *   Method to get all playground available
     * @return List of product
     * @throws DataBaseException
     */
    List<Playground> getBasketballPlayground(List<Playground> allPlaygroundList) throws DataBaseException;


}
