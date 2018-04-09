package com.realsport.model.dao;



import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.BasketballPlayground;
import com.realsport.model.entityDao.FootballPlayground;
import com.realsport.model.entityDao.VoleyballPlayground;

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
     */
    List<FootballPlayground> getFootballPlayground() throws DataBaseException;

    /**
     *   Method to get all playground available
     * @return List of product
     * @throws DataBaseException
     */
    List<VoleyballPlayground> getVoleyballPlayground() throws DataBaseException;

    /**
     *   Method to get all playground available
     * @return List of product
     * @throws DataBaseException
     */
    List<BasketballPlayground> getBasketballPlayground() throws DataBaseException;

    FootballPlayground getFootballById(String id) throws DataBaseException;

}
