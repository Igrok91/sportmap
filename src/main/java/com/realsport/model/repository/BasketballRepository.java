package com.realsport.model.repository;

import com.realsport.model.entityDao.entityJPA.BasketballEntity;
import com.realsport.model.entityDao.entityJPA.PlayfootballEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by IgorR on 18.06.2017.
 */
public interface BasketballRepository extends CrudRepository<BasketballEntity, Integer> {
    @Query(value = "select * from basketball", nativeQuery = true)
    List<BasketballEntity> findAllBasketball();
}
