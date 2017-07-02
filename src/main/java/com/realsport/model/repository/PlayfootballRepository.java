package com.realsport.model.repository;

import com.realsport.model.entityDao.entityJPA.PlayfootballEntity;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by IgorR on 18.06.2017.
 */
public interface PlayfootballRepository extends CrudRepository<PlayfootballEntity, Integer> {
}
