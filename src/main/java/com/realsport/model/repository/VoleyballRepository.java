package com.realsport.model.repository;


import com.realsport.model.entityDao.Voleyball;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */

public interface VoleyballRepository  {


    List<Voleyball> findAllVoleyball();
}
