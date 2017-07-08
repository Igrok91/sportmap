package com.realsport.model.repository;


import com.realsport.model.entityDao.Playfootball;

import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */
public interface PlayfootballRepository  {

    List<Playfootball> findAllPlayfootball();
}
