package com.realsport.model.repository.impl.spb;

import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.repository.PlayfootballRepository;
import com.realsport.model.repository.impl.spb.data.FootData;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IgorR on 08.07.2017.
 */
@Component
public class FootballRepositoryImpl implements PlayfootballRepository {

    @Override
    public List<Playfootball> findAllPlayfootball() {
        ArrayList<Playfootball> list = new ArrayList<>();
        for (FootData f: FootData.values()) {
            Playfootball p = new Playfootball();
            p.setIdplayground(Integer.parseInt(f.getId()));
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
    public Playfootball findPlayGroundById(String id) {
        Playfootball p = null;
        for (FootData f: FootData.values()) {
            if(f.getId().equals(id)){
                p = new Playfootball();
                p.setIdplayground(Integer.parseInt(f.getId()));
                p.setName(f.getName());
                p.setLatitude(f.getLattitude());
                p.setLongitude(f.getLongitude());
                p.setLinks(f.getLinks());
                p.setСreator(f.getCreator());
                p.setSity(f.getCity());
                p.setStreet(f.getStreet());
                p.setHouse(f.getHouse());
                p.setSubject(f.getSubject());
            }
        }

        return p;
    }
}
