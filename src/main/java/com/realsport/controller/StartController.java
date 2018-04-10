package com.realsport.controller;

import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.google.gson.Gson;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.dao.kinds.KindSport;
import com.realsport.model.entity.Template;
import com.realsport.model.entityDao.*;
import com.realsport.model.service.EventsService;
import com.realsport.model.service.UserService;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.VkService;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * Created by Igor on 31.03.2017.
 */
@Controller
public class StartController {
    Log logger = LogFactory.getLog(StartController.class);

    private List<FootballPlayground> footballPlaygroundList = new ArrayList<>();
    private List<VoleyballPlayground> voleyballPlaygroundList = new ArrayList<>();
    private List<BasketballPlayground> basketballPlaygroundList = new ArrayList<>();

    ArrayList<String> footLocationList = new ArrayList<>();
    ArrayList<String> basketLocationList = new ArrayList<>();
    ArrayList<String> voleyLocationList = new ArrayList<>();

    ArrayList<String> footInfoList = new ArrayList<>();
    ArrayList<String> basketInfoList = new ArrayList<>();
    ArrayList<String> voleyballInfoList = new ArrayList<>();

    public static final String FOOTBALL = "football";
    public static final String BASKETBALL = "basketball";
    public static final String VOLEYBALL = "voleyball";
    public static final int INACTIVE_INTERVAL = 1800;

    private static final Integer ADMIN = 172924708;


    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private EventsService eventsService;

    @Autowired
    private VkService messageService;

    @Autowired
    private UserService userService;


    @Autowired
    HttpSession httpSession;

    @RequestMapping(value = "/error2")
    public String error() {
        return "error2";
    }

    @RequestMapping(value = "/start")
    public String onStart(Model model, @RequestParam(value = "viewer_id", required = false) String id, @RequestParam(value = "access_token", required = false) String access_token) {
        httpSession.setMaxInactiveInterval(INACTIVE_INTERVAL);
        User user = null;
        boolean isFirst = false;
        if (id != null) {
            try {
                user = userService.getUser(id);
                if (user != null) {
                    setPlaygroundDataToModel(model, id);
                    setUserDataToModel(user, model);

                    Gson gson = new Gson();

                    List<Event> listEvents = eventsService.getEvents(user.getPlaygroundFootballList(), user.getPlaygroundBasketList(), user.getPlaygroundVoleyList());
                    model.addAttribute("listEventsJson", gson.toJson(listEvents));
                    model.addAttribute("listEvents", listEvents);
                    model.addAttribute("playgroundCoordinate", "empty");
                } else {
                    user = userService.registerUser(id);
                    isFirst = true;
                }
                httpSession.setAttribute("user", user);
                httpSession.setAttribute("userId", id);

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            model.addAttribute("userId", id);
            return "error";
        }

        return !isFirst ? "main" : "begin";
    }

    private void setUserDataToModel(User user, Model model) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        map.put("isAdmin", user.isAdmin());
      //  if (user.getPlaygroundFootballList().size() != 0) {
            map.put("playgroundFoottUser", user.getPlaygroundFootballList());
      //  }

       // if (user.getPlaygroundBasketList().size() != 0) {
            map.put("playgroundBasketUser", user.getPlaygroundBasketList());
      //  }

       // if (user.getPlaygroundVoleyList().size() != 0) {
            map.put("playgroundVoleyUser", user.getPlaygroundVoleyList());
       // }

        map.put("allPlaygroundUser", getAllPlaygroundUser(user));
        String jsonUser = gson.toJson(map);
        httpSession.setAttribute("sessionUser", jsonUser);
        httpSession.setAttribute("eventListActive", gson.toJson(user.getEventListActive()));

        model.addAttribute("allPlaygroundUser", getAllPlaygroundUser(user));
    }

    private List<Playground> getAllPlaygroundUser(User user) {
        List<Playground> allList = new ArrayList<>();
        List<FootballPlayground> footballPlaygroundListUser = new ArrayList<>();
        List<VoleyballPlayground> voleyballlListUser = new ArrayList<>();
        List<BasketballPlayground> basketballPlaygroundListUser = new ArrayList<>();
        if ( user.getPlaygroundFootballList().size() != 0) {
            for (String id : user.getPlaygroundFootballList()) {
                FootballPlayground p = FluentIterable.from(footballPlaygroundList).firstMatch(new Predicate<FootballPlayground>() {
                    @Override
                    public boolean apply(FootballPlayground playfootball) {
                        return playfootball.getIdplayground().equals(id);
                    }
                }).orNull();
                if (p != null) {
                    footballPlaygroundListUser.add(p);
                }
            }
        }

        if ( user.getPlaygroundBasketList().size() != 0) {
            for (String id : user.getPlaygroundBasketList()) {
                BasketballPlayground p = FluentIterable.from(basketballPlaygroundList).firstMatch(new Predicate<BasketballPlayground>() {
                    @Override
                    public boolean apply(BasketballPlayground basketball) {
                        return basketball.getIdplayground().equals(id);
                    }
                }).orNull();
                if (p != null) {
                    basketballPlaygroundListUser.add(p);
                }
            }
        }

        if ( user.getPlaygroundVoleyList().size() != 0) {
            for (String id : user.getPlaygroundVoleyList()) {
                VoleyballPlayground p = FluentIterable.from(voleyballPlaygroundList).firstMatch(new Predicate<VoleyballPlayground>() {
                    @Override
                    public boolean apply(VoleyballPlayground voleyball) {
                        return voleyball.getIdplayground().equals(id);
                    }
                }).orNull();
                if (p != null) {
                    voleyballlListUser.add(p);
                }
            }
        }
        allList.addAll(footballPlaygroundListUser);
        allList.addAll(basketballPlaygroundListUser);
        allList.addAll(voleyballlListUser);

        return allList;

    }


    private void setPlaygroundDataToModel(Model model, String id) throws Exception {
        try {
            //messageService.sendMessage(ADMIN, "В приложение зашел пользователь с id " + id);

            // Получение данных по площадкам из базы данных
            voleyballPlaygroundList = playgroundService.getVoleyballPlayground();
            footballPlaygroundList = playgroundService.getFootballPlayground();
            basketballPlaygroundList = playgroundService.getBasketballPlayground();
        /*    if (voleyballPlaygroundList == null || footballPlaygroundList == null || basketballPlaygroundList == null) {
                throw new DataBaseException(DataBaseException.ERORR_MESSAGE);
            }*/
            // Получение координат площадок и конвертация в JSON
            if (voleyballPlaygroundList != null) {
                voleyballInfoList = getVoleyballInfoList(voleyballPlaygroundList);
                voleyLocationList = getСoordinateVoleyPlayground(voleyballPlaygroundList);
            }
            if (footballPlaygroundList != null) {
                // Получение основных данных по площадкам и конвертация данных в формат JSON
                footInfoList = getFootInfoList(footballPlaygroundList);
                footLocationList = getСoordinateFootPlayground(footballPlaygroundList);

            }
            if (basketballPlaygroundList != null) {
                basketInfoList = getBasketInfoList(basketballPlaygroundList);
                basketLocationList = getСoordinateBasketPlayground(basketballPlaygroundList);
            }


            // Добавление данных в модель
            addPlaygroundDataToModel(model);

            model.addAttribute("errorMaps", "success");
        } catch (Exception e) {
            model.addAttribute("errorMaps", "fail");
            messageService.sendMessage(ADMIN, errorCreateMaps(id, e));
            e.printStackTrace();
        }

    }

    private void addPlaygroundDataToModel(Model model) {
        model.addAttribute("footLocation", footLocationList);
        model.addAttribute("basketLocation", basketLocationList);
        model.addAttribute("voleyLocation", voleyLocationList);

        model.addAttribute("footInfo", footInfoList);
        model.addAttribute("basketInfo", basketInfoList);
        model.addAttribute("voleyballInfo", voleyballInfoList);
    }

    @RequestMapping(value = "/begin")
    public String onStart(Model model) {
        User user = (User) httpSession.getAttribute("sessionUser");
        String userId = (String) httpSession.getAttribute("userId");


        return "main";
    }

    @RequestMapping(value = "/searchPlayground")
    public String onSearchPlayground(Model model) {
        User user = (User) httpSession.getAttribute("sessionUser");
        String userId = (String) httpSession.getAttribute("userId");

        return "searchPlayground";
    }

    @RequestMapping("/groupFromMap")
    public String toGroup(Model model, @RequestParam(value="playgroundId") String id, @RequestParam(value="sport", required=false, defaultValue=FOOTBALL) String sport) {
        User user = (User) httpSession.getAttribute("user");
        if (user == null) {
            return "error";
        }
        addGroupToModel(model, id, KindSport.valueOf(sport), user);

        model.addAttribute("returnBack", "map");
        return "playground";
    }

    private void addGroupToModel(Model model, String idGroup, KindSport sport, User user) {
        boolean isParticipant = false;
        switch (sport) {
            case FOOTBALL:
                FootballPlayground footballPlayground = FluentIterable.from(footballPlaygroundList).firstMatch(new Predicate<FootballPlayground>() {
                    @Override
                    public boolean apply(FootballPlayground playfootball) {
                        return playfootball.getIdplayground().equals(idGroup);
                    }
                }).get();
                if (footballPlayground != null) {
                    addGroupDataToModel(model, footballPlayground, idGroup, KindSport.FOOTBALL);
                }

                isParticipant = isParticipant(user.getPlaygroundFootballList(), idGroup);
                break;
            case BASKETBALL:
                BasketballPlayground basketballPlayground = FluentIterable.from(basketballPlaygroundList).firstMatch(new Predicate<BasketballPlayground>() {
                    @Override
                    public boolean apply(BasketballPlayground basketballPlayground) {
                        return basketballPlayground.getIdplayground().equals(idGroup);
                    }
                }).get();

                if (basketballPlayground != null) {
                    addGroupDataToModel(model, basketballPlayground, idGroup, KindSport.BASKETBALL);
                }

                isParticipant = isParticipant(user.getPlaygroundBasketList(), idGroup);
                break;
            case VOLEYBALL:
                VoleyballPlayground voleyballPlayground = FluentIterable.from(voleyballPlaygroundList).firstMatch(new Predicate<VoleyballPlayground>() {
                    @Override
                    public boolean apply(VoleyballPlayground voleyballPlayground) {
                        return voleyballPlayground.getIdplayground().equals(idGroup);
                    }
                }).get();
                if (voleyballPlayground != null) {
                    addGroupDataToModel(model, voleyballPlayground, idGroup, KindSport.VOLEYBALL);
                }

                isParticipant = isParticipant(user.getPlaygroundVoleyList(), idGroup);
                break;
        }
        model.addAttribute("isParticipant", isParticipant);
    }

    private boolean isParticipant(List<String> playgroundList, String idGroup) {
        return FluentIterable.from(playgroundList).firstMatch(new Predicate<String>() {
            @Override
            public boolean apply(String idPlay) {
                return idPlay.equals(idGroup);
            }
        }).isPresent();
    }

    private void addGroupDataToModel(Model model, Playground playground, String idGroup, KindSport kindSport) {
        model.addAttribute("playgroundId", playground.getIdplayground());
        model.addAttribute("namePlayground", playground.getName() );
        model.addAttribute("street", playground.getStreet() );
        model.addAttribute("house", playground.getHouse() );
        model.addAttribute("sport", playground.getSport() );
        model.addAttribute("players", playground.getPlayers() );
        model.addAttribute("listEvents", eventsService.getEventsByIdGroup(idGroup, kindSport) );
    }

    @RequestMapping("/group")
    public String toGroupUser(Model model, @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport) {
        User user = (User) httpSession.getAttribute("user");
        if (user == null) {
            return "error";
        }
        addGroupToModel(model, id, KindSport.valueOf(sport), user);

        model.addAttribute("returnBack", "group");
        return "playground";
    }

    @RequestMapping("/playground")
    public String toGroupFromEvent(Model model, @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport) {
        User user = (User) httpSession.getAttribute("user");
        if (user == null) {
            return "error";
        }

        addGroupToModel(model, id, KindSport.valueOf(sport), user);
        model.addAttribute("returnBack", "home");
        return "playground";
    }

    @RequestMapping("/create")
    public String toCreate(Model model,  @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport,
                           @RequestParam(value="eventId", required = false, defaultValue = "null") String eventId) {
        if (sport.equals("Футбол")) {
            for (FootballPlayground footballPlayground : footballPlaygroundList) {
                if (footballPlayground.getIdplayground().equals(id)) {
                    model.addAttribute("namePlayground", footballPlayground.getName() );
                    model.addAttribute("playId", footballPlayground.getIdplayground() );
                    model.addAttribute("street", footballPlayground.getStreet() );
                    model.addAttribute("house", footballPlayground.getHouse() );
                    model.addAttribute("sport", footballPlayground.getSport() );
                    model.addAttribute("players", footballPlayground.getPlayers() );
                    model.addAttribute("plays", playgroundService.getFootballEventsById(id) );
                }
            }
        } else if (sport.equals("Баскетбол")) {
            for (BasketballPlayground basketballPlayground : basketballPlaygroundList) {
                if (basketballPlayground.getIdplayground().equals(id)) {
                    model.addAttribute("namePlayground", basketballPlayground.getName() );
                    model.addAttribute("playId", basketballPlayground.getIdplayground() );
                    model.addAttribute("street", basketballPlayground.getStreet() );
                    model.addAttribute("house", basketballPlayground.getHouse() );
                    model.addAttribute("sport", basketballPlayground.getSport() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getBasketballPlayById(id) );
                }
            }
        } else if (sport.equals("Волейбол")) {
            for (VoleyballPlayground voleyballPlayground : voleyballPlaygroundList) {
                if (voleyballPlayground.getIdplayground().equals(id)) {
                    model.addAttribute("namePlayground", voleyballPlayground.getName() );
                    model.addAttribute("playId", voleyballPlayground.getIdplayground() );
                    model.addAttribute("street", voleyballPlayground.getStreet() );
                    model.addAttribute("house", voleyballPlayground.getHouse() );
                    model.addAttribute("sport", voleyballPlayground.getSport() );
                    model.addAttribute("players", playgroundService.getVoleyPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getVoleyPlayById(id) );
                }
            }
        }
        Gson gson = new Gson();
        if (!eventId.equals("null")) {

            Event event = eventsService.getEventById(eventId);
            model.addAttribute("eventJson", gson.toJson(event) );
            model.addAttribute("event", event );
            model.addAttribute("templates", new ArrayList<>());
            model.addAttribute("template", new Template());
        } else {
            String userId = (String) httpSession.getAttribute("userId");
            List<TemplateGame> list = userService.getTemplatesUserById(userId);
            ArrayList<String> userTemplates = new ArrayList<>();
            if (list != null) {
                userTemplates = getUserTemplates(list);
            }
            model.addAttribute("eventJson", gson.toJson(new Event()) );
            model.addAttribute("event", new Event() );
            model.addAttribute("templates", userTemplates);
            model.addAttribute("template", new Template());
        }
        model.addAttribute("returnBack", "home");

        model.addAttribute("playgroundId", id);
        return "create";
    }

    @RequestMapping(value = "/home")
    public String toHome(Model model, @RequestParam(value="where", required = false, defaultValue = "home") String where, @RequestParam(value="playgroundId", required = false) String id, @RequestParam(value="sport", required = false) String sport ) {
       // User user = (User) httpSession.getAttribute("sessionUser");
        //String userId = (String) httpSession.getAttribute("userId");
        if (where.equals("group")) {
            addPlaygroundDataToModel(model);
            model.addAttribute("returnBack", where);
            model.addAttribute("sport", sport);
            model.addAttribute("playgroundCoordinate", "empty");
        } else if (where.equals("map")) {
            addPlaygroundDataToModel(model);
            String json = null;
            if (sport.equals("Футбол")) {
                HashMap<String, Double> map = new HashMap<>();
                Gson gson = new Gson();

                for (FootballPlayground p : footballPlaygroundList) {
                    if (p.getIdplayground().equals(id)) {
                        map.put("lat", Double.parseDouble(p.getLatitude()));
                        map.put("lng", Double.parseDouble(p.getLongitude()));
                        json = gson.toJson(map);
                    }

                }
            }

            if (sport.equals("Баскетбол")) {
                HashMap<String, Double> map = new HashMap<>();
                Gson gson = new Gson();

                for (BasketballPlayground p : basketballPlaygroundList) {
                    if (p.getIdplayground().equals(id)) {
                        map.put("lat", Double.parseDouble(p.getLatitude()));
                        map.put("lng", Double.parseDouble(p.getLongitude()));
                        json = gson.toJson(map);
                    }

                }
            }

            if (sport.equals("Волейбол")) {
                HashMap<String, Double> map = new HashMap<>();
                Gson gson = new Gson();

                for (VoleyballPlayground p : voleyballPlaygroundList) {
                    if (p.getIdplayground().equals(id)) {
                        map.put("lat", Double.parseDouble(p.getLatitude()));
                        map.put("lng", Double.parseDouble(p.getLongitude()));
                        json = gson.toJson(map);
                    }

                }
            }

            model.addAttribute("returnBack", where);
            model.addAttribute("sport", sport);
            model.addAttribute("playgroundCoordinate", json == null ? "empty" : json);
        } else {
            addPlaygroundDataToModel(model);
            model.addAttribute("returnBack", "home");
            model.addAttribute("playgroundCoordinate", "empty");
        }

        User user = (User)httpSession.getAttribute("user");
        setUserDataToModel(user, model);
        Gson gson = new Gson();

        List<Event> listEvents = eventsService.getEvents(user.getPlaygroundFootballList(), user.getPlaygroundBasketList(), user.getPlaygroundVoleyList());
        model.addAttribute("listEventsJson", gson.toJson(listEvents));
        model.addAttribute("listEvents", listEvents);
        return "main";
    }

    // Удаляем атрибут active
    @RequestMapping(value = "/deleteGame")
    public String deleteGame(@RequestParam(name = "eventId", required = false) String eventId) {
        if (eventId != null ) {
            eventsService.deleteGame(eventId);
        }
        return "redirect:/home";
    }

    @RequestMapping(value = "/endGame")
    public String endGame(@RequestParam(name = "eventId", required = false) String eventId) {
        if (eventId != null ) {
            eventsService.endGame(eventId);
        }
        return "redirect:/home";
    }


    @RequestMapping(value = "/event")
    public String event(Model model, @RequestParam(name = "eventId") String eventId) {
        Gson gson = new Gson();
        User user = (User)httpSession.getAttribute("user");
        List<Event> listEvents = eventsService.getEvents(user.getPlaygroundFootballList(), user.getPlaygroundBasketList(), user.getPlaygroundVoleyList());
        Event event = FluentIterable.from(listEvents).firstMatch(new Predicate<Event>() {
            @Override
            public boolean apply(Event event) {
                return event.getIdEvent().equalsIgnoreCase(eventId);
            }
        }).get();
        model.addAttribute("event", event);
        model.addAttribute("eventJson", gson.toJson(event));

        return "event";
    }



    @RequestMapping(value = "/createGame", method = RequestMethod.POST)
    public String createGame(Model model, @RequestParam(name = "descr", required = false, defaultValue = "description") String  descr, @RequestParam(name = "answer", required = false, defaultValue="+") String  answer, @RequestParam(name = "sel2", required = false, defaultValue="Без ограничений") String  sel2
            , @RequestParam(name = "sel1", required = false, defaultValue="3") String  sel1, @RequestParam(name = "sport", required = false, defaultValue="Футбол") String  sport, @RequestParam(name = "playgroundId", required = false, defaultValue="123") String  playgroundId
                ,@RequestParam(name = "namePlayground") String  namePlayground
            ,@RequestParam(name = "templateId", required = false, defaultValue = "0") String  templateId
            ,@RequestParam(name = "eventId", required = false, defaultValue = "null") String  eventId)  throws IOException {
        String userId = (String) httpSession.getAttribute("userId");
        Event game;
        if (templateId.equals("0")) {
            game = new Event();
            game.setDescription(descr);
            game.setAnswer(answer);
            game.setMaxCountAnswer(sel2.equals("Без ограничений") ? 0 : Integer.valueOf(sel2));
            game.setDuration(sel1.substring(0, 1));
            game.setUserIdCreator(userId);
            game.setPlaygroundId(playgroundId);
            game.setSport(sport);
            game.setDateCreation(getDateCreation());
            game.setPlaygroundName(namePlayground);
        } else {
            game = eventsService.createEventByTemplate(templateId);
        }

        Gson gson = new Gson();
        String jsonUser = (String)httpSession.getAttribute("sessionUser");
        HashMap<String, Object> map = gson.fromJson(jsonUser, HashMap.class);

        if (!eventId.equals("null")) {
            game.setIdEvent(eventId);
            eventsService.editEventById(eventId);
        } else {
            eventsService.publishEvent(game, userId);
        }
        return "redirect:/home";
    }

    private Date getDateCreation() {

        return new Date();
    }


    /**
     * Возвращает представление карты Google со всеми данными
     *
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/maps")
    public String onMap(Model model, @RequestParam(value = "viewer_id", required = false) String id, @RequestParam(value = "access_token", required = false) String access_token) throws Exception {
        try {
            //messageService.sendMessage(ADMIN, "В приложение зашел пользователь с id " + id);

            // Получение данных по площадкам из базы данных
            voleyballPlaygroundList = playgroundService.getVoleyballPlayground();
            footballPlaygroundList = playgroundService.getFootballPlayground();
            basketballPlaygroundList = playgroundService.getBasketballPlayground();
            if (voleyballPlaygroundList == null || footballPlaygroundList == null || basketballPlaygroundList == null) {
                throw new DataBaseException(DataBaseException.ERORR_MESSAGE);
            }
            // Получение координат площадок и конвертация в JSON
            ArrayList<String> footLocationList = getСoordinateFootPlayground(footballPlaygroundList);
            ArrayList<String> basketLocationList = getСoordinateBasketPlayground(basketballPlaygroundList);
            ArrayList<String> voleyLocationList = getСoordinateVoleyPlayground(voleyballPlaygroundList);

            // Получение основных данных по площадкам и конвертация данных в формат JSON
            ArrayList<String> footInfoList = getFootInfoList(footballPlaygroundList);
            ArrayList<String> basketInfoList = getBasketInfoList(basketballPlaygroundList);
            ArrayList<String> voleyballInfoList = getVoleyballInfoList(voleyballPlaygroundList);

            // Добавление данных в модель
            model.addAttribute("footLocation", footLocationList);
            model.addAttribute("basketLocation", basketLocationList);
            model.addAttribute("voleyLocation", voleyLocationList);

            model.addAttribute("footInfo", footInfoList);
            model.addAttribute("basketInfo", basketInfoList);
            model.addAttribute("voleyballInfo", voleyballInfoList);
            model.addAttribute("errorMaps", "success");
        } catch (Exception e) {
            model.addAttribute("errorMaps", "fail");
            messageService.sendMessage(ADMIN, errorCreateMaps(id, e));
            e.printStackTrace();
        }

        return "map";
    }

    private ArrayList<String> getUserTemplates(List<TemplateGame> list) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> templates = new ArrayList<>();
        for (TemplateGame p : list) {
            map.put("templateId", p.getTemplateId());
            map.put("description", p.getDescription());
            map.put("listAnswer", p.getListAnswer());
            String json = gson.toJson(map);
            templates.add(json);
        }
        return templates;
    }
    /**
     * Получение основных данных по площадкам и конвертация данных в формат JSON
     *
     * @param voleyballPlaygroundList
     * @return
     */
    private ArrayList<String> getVoleyballInfoList(List<VoleyballPlayground> voleyballPlaygroundList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (VoleyballPlayground p : voleyballPlaygroundList) {
            map.put("namePlayground", p.getName());
            map.put("street", p.getStreet());
            map.put("house", p.getHouse());
            map.put("id", p.getIdplayground());
            map.put("sport", p.getSport());
            String json = gson.toJson(map);
            mapArrayList.add(json);

        }
        return mapArrayList;
    }

    /**
     * Получение основных данных по площадкам и конвертация данных в формат JSON
     *
     * @param basketballPlaygroundList
     * @return
     */
    private ArrayList<String> getBasketInfoList(List<BasketballPlayground> basketballPlaygroundList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (BasketballPlayground p : basketballPlaygroundList) {
            map.put("namePlayground", p.getName());
            map.put("street", p.getStreet());
            map.put("house", p.getHouse());
            map.put("id", p.getIdplayground());
            map.put("sport", p.getSport());
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }

        return mapArrayList;
    }

    /**
     * Получение основных данных по площадкам и конвертация данных в формат JSON
     *
     * @param footballPlaygroundList
     * @return
     */
    private ArrayList<String> getFootInfoList(List<FootballPlayground> footballPlaygroundList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (FootballPlayground p : footballPlaygroundList) {
            map.put("namePlayground", p.getName());
            map.put("street", p.getStreet());
            map.put("house", p.getHouse());
            map.put("id", p.getIdplayground());
            map.put("sport", p.getSport());

            String json = gson.toJson(map);
            mapArrayList.add(json);
        }
        return mapArrayList;
    }

    /**
     * Получение координат площадок и конвертация в JSON
     *
     * @param list
     * @return
     */
    private ArrayList<String> getСoordinateFootPlayground(List<FootballPlayground> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (FootballPlayground p : list) {
            map.put("lat", Double.parseDouble(p.getLatitude()));
            map.put("lng", Double.parseDouble(p.getLongitude()));
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }
        return mapArrayList;
    }

    /**
     * Получение координат площадок и конвертация в JSON
     *
     * @param list
     * @return
     */
    private ArrayList<String> getСoordinateBasketPlayground(List<BasketballPlayground> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (BasketballPlayground p : list) {
            map.put("lat", Double.parseDouble(p.getLatitude()));
            map.put("lng", Double.parseDouble(p.getLongitude()));
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }
        return mapArrayList;
    }

    /**
     * Получение координат площадок и конвертация в JSON
     *
     * @param list
     * @return
     */
    private ArrayList<String> getСoordinateVoleyPlayground(List<VoleyballPlayground> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (VoleyballPlayground p : list) {
            map.put("lat", Double.parseDouble(p.getLatitude()));
            map.put("lng", Double.parseDouble(p.getLongitude()));
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }
        return mapArrayList;
    }


    private String errorSendMessage(String userID, String idPlay, Exception e) {
        String error = "Произошла ошибка при отправки сообщения пользователю с Id " + userID + ", id площадки " + idPlay + ". Error: " + e.getMessage();
        return error;
    }

    private String errorCreateMaps(String userID, Exception e) {
        String error = "Произошла ошибка при создании карты пользователю с Id " + userID + ". Error: " + e.getMessage();
        return error;
    }

    public ArrayList<String> getFootInfoList() {
        return footInfoList;
    }

    public ArrayList<String> getBasketInfoList() {
        return basketInfoList;
    }

    public ArrayList<String> getVoleyballInfoList() {
        return voleyballInfoList;
    }


}
