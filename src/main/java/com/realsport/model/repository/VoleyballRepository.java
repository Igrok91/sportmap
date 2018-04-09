package com.realsport.model.repository;


import com.realsport.model.entityDao.VoleyballPlayground;

import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */

public interface VoleyballRepository  {


    List<VoleyballPlayground> findAllVoleyball();

    VoleyballPlayground findPlayGroundById(String id);
}
