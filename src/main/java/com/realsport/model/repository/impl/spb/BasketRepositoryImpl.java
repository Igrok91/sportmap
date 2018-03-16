package com.realsport.model.repository.impl.spb;

import com.realsport.model.entityDao.Basketball;

import com.realsport.model.repository.BasketballRepository;
import com.realsport.model.repository.impl.spb.data.BasketData;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IgorR on 08.07.2017.
 */
@Component
public class BasketRepositoryImpl implements BasketballRepository{
    @Override
    public List<Basketball> findAllBasketball() {
        ArrayList<Basketball> list = new ArrayList<>();
        for (BasketData f: BasketData.values()) {
            Basketball p = new Basketball();
            p.setIdbasketball(Integer.parseInt(f.getId()));
            p.setName(f.getName());
            p.setLatitude(f.getLattitude());
            p.setLongitude(f.getLongitude());
            p.setLinks(f.getLinks());
            p.setСreator(f.getCreator());
            p.setSity(f.getCity());
            p.setStreet(f.getStreet());
            p.setHouse(f.getHouse());
            p.setSubject(f.getSubject());
            list.add(p);

        }
        return list;
    }

    @Override
    public Basketball findPlayGroundById(String id) {
        Basketball p = null;
        for (BasketData f: BasketData.values()) {
            if(f.getId().equals(id)){
                p = new Basketball();
                p.setIdbasketball(Integer.parseInt(f.getId()));
                p.setName(f.getName());
                p.setLatitude(f.getLattitude());
                p.setLongitude(f.getLongitude());
                p.setLinks(f.getLinks());
                p.setСreator(f.getCreator());
                p.setSity(f.getCity());
                p.setStreet(f.getStreet());
                p.setHouse(f.getHouse());
            }
        }

        return p;
    }
}
