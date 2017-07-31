package com.realsport.model.repository;


import com.realsport.model.entityDao.Basketball;

import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */
public interface BasketballRepository  {

    List<Basketball> findAllBasketball();

    Basketball findPlayGroundById(String id);
}
