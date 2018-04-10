package com.realsport.model.repository.impl.spb;


import com.realsport.model.entityDao.VoleyballPlayground;
import com.realsport.model.repository.VoleyballRepository;
import com.realsport.model.repository.impl.spb.data.VoleyData;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by IgorR on 08.07.2017.
 */
@Component
public class VoleballRepositoryImpl implements VoleyballRepository {
    @Override
    public List<VoleyballPlayground> findAllVoleyball() {
        ArrayList<VoleyballPlayground> list = new ArrayList<>();
        for (VoleyData f: VoleyData.values()) {
            VoleyballPlayground p = new VoleyballPlayground();
            p.setIdplayground(f.getId());
            p.setName(f.getName());
            p.setLatitude(f.getLattitude());
            p.setLongitude(f.getLongitude());
            p.setLinks(f.getLinks());
            p.setСreator(f.getCreator());
            p.setSity(f.getCity());
            p.setStreet(f.getStreet());
            p.setHouse(f.getHouse());
            p.setSport(f.getSubject());
            list.add(p);

        }
        return list;
    }

    @Override
    public VoleyballPlayground findPlayGroundById(String id) {
        VoleyballPlayground p = null;
        for (VoleyData f: VoleyData.values()) {
            if(f.getId().equals(id)){
                p = new VoleyballPlayground();
                p.setIdplayground(f.getId());
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
