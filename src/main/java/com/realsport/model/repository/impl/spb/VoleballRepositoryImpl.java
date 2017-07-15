package com.realsport.model.repository.impl.spb;

import com.realsport.model.entityDao.Basketball;
import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.entityDao.Voleyball;
import com.realsport.model.repository.VoleyballRepository;
import com.realsport.model.repository.impl.spb.data.BasketData;
import com.realsport.model.repository.impl.spb.data.FootData;
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
    public List<Voleyball> findAllVoleyball() {
        ArrayList<Voleyball> list = new ArrayList<>();
        for (VoleyData f: VoleyData.values()) {
            Voleyball p = new Voleyball();
            p.setIdvoleyball(Integer.parseInt(f.getId()));
            p.setName(f.getName());
            p.setLatitude(f.getLattitude());
            p.setLongitude(f.getLongitude());
            p.setLinks(f.getLinks());
            p.setСreator(f.getCreator());
            p.setSity(f.getCity());
            list.add(p);

        }
        return list;
    }

    @Override
    public Voleyball findPlayGroundById(String id) {
        Voleyball p = null;
        for (VoleyData f: VoleyData.values()) {
            if(f.getId().equals(id)){
                p = new Voleyball();
                p.setIdvoleyball(Integer.parseInt(f.getId()));
                p.setName(f.getName());
                p.setLatitude(f.getLattitude());
                p.setLongitude(f.getLongitude());
                p.setLinks(f.getLinks());
                p.setСreator(f.getCreator());
                p.setSity(f.getCity());
            }
        }

        return p;
    }


}
