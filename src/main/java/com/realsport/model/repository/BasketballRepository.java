package com.realsport.model.repository;


import com.realsport.model.entityDao.BasketballPlayground;

import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */
public interface BasketballRepository  {

    List<BasketballPlayground> findAllBasketball();

    BasketballPlayground findPlayGroundById(String id);
}
