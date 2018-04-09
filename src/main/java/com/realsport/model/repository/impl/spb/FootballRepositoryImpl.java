package com.realsport.model.repository.impl.spb;

import com.realsport.model.entityDao.FootballPlayground;
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
    public List<FootballPlayground> findAllPlayfootball() {
        ArrayList<FootballPlayground> list = new ArrayList<>();
        for (FootData f: FootData.values()) {
            FootballPlayground p = new FootballPlayground();
            p.setIdplayground(Integer.parseInt(f.getId()));
            p.setName(f.getName());
            p.setLatitude(f.getLattitude());
            p.setLongitude(f.getLongitude());
            p.setLinks(f.getLinks());
            p.setСreator(f.getCreator());
            p.setSity(f.getCity());
            p.setStreet(f.getStreet());
            p.setHouse(f.getHouse());
            p.setSport(f.getSport());
            list.add(p);

        }
        return list;
    }

    @Override
    public FootballPlayground findPlayGroundById(String id) {
        FootballPlayground p = null;
        for (FootData f: FootData.values()) {
            if(f.getId().equals(id)){
                p = new FootballPlayground();
                p.setIdplayground(Integer.parseInt(f.getId()));
                p.setName(f.getName());
                p.setLatitude(f.getLattitude());
                p.setLongitude(f.getLongitude());
                p.setLinks(f.getLinks());
                p.setСreator(f.getCreator());
                p.setSity(f.getCity());
                p.setStreet(f.getStreet());
                p.setHouse(f.getHouse());
                p.setSport(f.getSport());
            }
        }

        return p;
    }
}
