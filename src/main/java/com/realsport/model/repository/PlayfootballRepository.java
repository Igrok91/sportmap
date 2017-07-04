package com.realsport.model.repository;

import com.realsport.model.entityDao.entityJPA.PlayfootballEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */
public interface PlayfootballRepository extends CrudRepository<PlayfootballEntity, Integer> {
    @Query(value = "select * from playfootball", nativeQuery = true)
    List<PlayfootballEntity> findAllPlayfootball();
}
