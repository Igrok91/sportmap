package com.realsport.model.repository;

import com.realsport.model.entityDao.entityJPA.PlayfootballEntity;
import com.realsport.model.entityDao.entityJPA.VoleyballEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */

public interface VoleyballRepository extends CrudRepository<VoleyballEntity, Integer> {

    @Query(value = "select * from voleyball", nativeQuery = true)
    List<VoleyballEntity> findAllVoleyball();
}
