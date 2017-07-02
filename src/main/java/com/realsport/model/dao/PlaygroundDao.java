package com.realsport.model.dao;



import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.pojo.Basketball;
import com.realsport.model.entityDao.pojo.Playfootball;
import com.realsport.model.entityDao.pojo.Voleyball;

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
    List<Playfootball> getFootballPlayground() throws DataBaseException;

    /**
     *   Method to get all playground available
     * @return List of product
     * @throws DataBaseException
     */
    List<Voleyball> getVoleyballPlayground() throws DataBaseException;

    /**
     *   Method to get all playground available
     * @return List of product
     * @throws DataBaseException
     */
    List<Basketball> getBasketballPlayground() throws DataBaseException;

}
