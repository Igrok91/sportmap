package com.realsport.controller;

import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.google.gson.Gson;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entity.Template;
import com.realsport.model.entityDao.*;
import com.realsport.model.service.EventsService;
import com.realsport.model.service.UserService;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.VkMessageService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * Created by Igor on 31.03.2017.
 */
@Controller
public class StartController {
    Logger logger = LoggerFactory.getLogger(StartController.class);

    private List<Playfootball> playfootballList;
    private List<Voleyball> voleyballList;
    private List<Basketball> basketballList;

    ArrayList<String> footLocationList;
    ArrayList<String> basketLocationList;
    ArrayList<String> voleyLocationList;

    ArrayList<String> footInfoList;
    ArrayList<String> basketInfoList;
    ArrayList<String> voleyballInfoList;

    public static final String FOOTBALL = "football";
    public static final String BASKETBALL = "basketball";
    public static final String VOLEYBALL = "voleyball";

    private static final Integer ADMIN = 172924708;


    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private EventsService eventsService;

    @Autowired
    private VkMessageService messageService;

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
        User user = null;
        boolean isFirst = false;
        if (id != null) {
            try {
                if (userService.isRegister(id)) {
                    user = userService.getUser(id);
                    setPlaygroundDataToModel(model, id);
                    setUserDataToModel(user, model);
                } else {
                    user = userService.registerUser(id);
                    isFirst = true;
                    setUserDataToModel(user, model);
                }
                httpSession.getServletContext().setAttribute("user", user);
                httpSession.getServletContext().setAttribute("userId", id);

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            model.addAttribute("userId", "null");
            return "error";
        }
        Gson gson = new Gson();

        List<Event> listEvents = eventsService.getEvents(user.getPlaygroundFootballList(), user.getPlaygroundBasketList(), user.getPlaygroundVoleyList());
        model.addAttribute("listEventsJson", gson.toJson(listEvents));
        model.addAttribute("listEvents", listEvents);
        model.addAttribute("playgroundCoordinate", "empty");
        return !isFirst ? "main" : "begin";
    }

    private void setUserDataToModel(User user, Model model) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        map.put("isAdmin", user.isAdmin());
        map.put("playgroundFoottUser", user.getPlaygroundFootballList());
        map.put("playgroundBasketUser", user.getPlaygroundBasketList());
        map.put("playgroundVoleyUser", user.getPlaygroundVoleyList());
        map.put("allPlaygroundUser", getAllPlaygroundUser(user));
        map.put("eventListPast", user.getEventListPast());
        String jsonUser = gson.toJson(map);
        httpSession.setAttribute("sessionUser", jsonUser);
        httpSession.setAttribute("eventListActive", gson.toJson(user.getEventListActive()));

        model.addAttribute("allPlaygroundUser", getAllPlaygroundUser(user));
    }

    private List<Playground> getAllPlaygroundUser(User user) {
        List<Playground> allList = new ArrayList<>();
        List<Playfootball> playfootballListUser = new ArrayList<>();
        List<Voleyball> voleyballlListUser = new ArrayList<>();
        List<Basketball> basketballListUser = new ArrayList<>();
        for (String id : user.getPlaygroundFootballList()) {
            Playfootball p = FluentIterable.from(playfootballList).firstMatch(new Predicate<Playfootball>() {
                @Override
                public boolean apply(Playfootball playfootball) {
                    return playfootball.getIdplayground() == Integer.valueOf(id);
                }
            }).orNull();
            if (p != null) {
                playfootballListUser.add(p);
            }
        }

        for (String id : user.getPlaygroundBasketList()) {
            Basketball p = FluentIterable.from(basketballList).firstMatch(new Predicate<Basketball>() {
                @Override
                public boolean apply(Basketball basketball) {
                    return basketball.getIdplayground() == Integer.valueOf(id);
                }
            }).orNull();
            if (p != null) {
                basketballListUser.add(p);
            }
        }

        for (String id : user.getPlaygroundVoleyList()) {
            Voleyball p = FluentIterable.from(voleyballList).firstMatch(new Predicate<Voleyball>() {
                @Override
                public boolean apply(Voleyball voleyball) {
                    return voleyball.getIdplayground() == Integer.valueOf(id);
                }
            }).orNull();
            if (p != null) {
                voleyballlListUser.add(p);
            }
        }
        allList.addAll(playfootballListUser);
        allList.addAll(basketballListUser);
        allList.addAll(voleyballlListUser);

        return allList;

    }


    private void setPlaygroundDataToModel(Model model, String id) throws Exception {
        try {
            //messageService.sendMessage(ADMIN, "В приложение зашел пользователь с id " + id);

            // Получение данных по площадкам из базы данных
            voleyballList = playgroundService.getVoleyballPlayground();
            playfootballList = playgroundService.getFootballPlayground();
            basketballList = playgroundService.getBasketballPlayground();
            if (voleyballList == null || playfootballList == null || basketballList == null) {
                throw new DataBaseException(DataBaseException.ERORR_MESSAGE);
            }
            // Получение координат площадок и конвертация в JSON
            footLocationList = getСoordinateFootPlayground(playfootballList);
            basketLocationList = getСoordinateBasketPlayground(basketballList);
            voleyLocationList = getСoordinateVoleyPlayground(voleyballList);


            // Получение основных данных по площадкам и конвертация данных в формат JSON
            footInfoList = getFootInfoList(playfootballList);
            basketInfoList = getBasketInfoList(basketballList);
            voleyballInfoList = getVoleyballInfoList(voleyballList);
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
    public String toGroup(Model model, @RequestParam(value="playgroundId", required=false, defaultValue="5") String id, @RequestParam(value="sport", required=false, defaultValue=FOOTBALL) String sport) {
        User user = (User) httpSession.getAttribute("user");
        boolean isParticipant = false;
        if (sport.equals(FOOTBALL)) {
            for (Playfootball playfootball : playfootballList) {
                if (playfootball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", playfootball.getName() );
                    model.addAttribute("street", playfootball.getStreet() );
                    model.addAttribute("house", playfootball.getHouse() );
                    model.addAttribute("sport", playfootball.getSubject() );
                    model.addAttribute("players", playgroundService.getFootballPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getFootballPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundFootballList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        } else if (sport.equals(BASKETBALL)) {
            for (Basketball basketball : basketballList) {
                if (basketball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", basketball.getName() );
                    model.addAttribute("street", basketball.getStreet() );
                    model.addAttribute("house", basketball.getHouse() );
                    model.addAttribute("sport", basketball.getSubject() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getBasketballPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundBasketList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        } else if (sport.equals(VOLEYBALL)) {
            for (Voleyball voleyball : voleyballList) {
                if (voleyball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", voleyball.getName() );
                    model.addAttribute("street", voleyball.getStreet() );
                    model.addAttribute("house", voleyball.getHouse() );
                    model.addAttribute("sport", voleyball.getSubject() );
                    model.addAttribute("players", playgroundService.getVoleyPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getVoleyPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundVoleyList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        }
        model.addAttribute("isParticipant", isParticipant);
        model.addAttribute("returnBack", "map");
        model.addAttribute("playgroundId", id);
        return "playground";
    }

    @RequestMapping("/group")
    public String toGroupUser(Model model, @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport) {
        User user = (User) httpSession.getAttribute("user");
        boolean isParticipant = false;
        if (sport.equals("Футбол")) {
            for (Playfootball playfootball : playfootballList) {
                if (playfootball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", playfootball.getName() );
                    model.addAttribute("street", playfootball.getStreet() );
                    model.addAttribute("house", playfootball.getHouse() );
                    model.addAttribute("sport", playfootball.getSubject() );
                    model.addAttribute("players", playgroundService.getFootballPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getFootballPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundFootballList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        } else if (sport.equals("Баскетбол")) {
            for (Basketball basketball : basketballList) {
                if (basketball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", basketball.getName() );
                    model.addAttribute("street", basketball.getStreet() );
                    model.addAttribute("house", basketball.getHouse() );
                    model.addAttribute("sport", basketball.getSubject() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getBasketballPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundBasketList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        } else if (sport.equals("Волейбол")) {
            for (Voleyball voleyball : voleyballList) {
                if (voleyball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", voleyball.getName() );
                    model.addAttribute("street", voleyball.getStreet() );
                    model.addAttribute("house", voleyball.getHouse() );
                    model.addAttribute("sport", voleyball.getSubject() );
                    model.addAttribute("players", playgroundService.getVoleyPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getVoleyPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundVoleyList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        }

        model.addAttribute("returnBack", "group");
        model.addAttribute("playgroundId", id);
        model.addAttribute("isParticipant", isParticipant);
        return "playground";
    }

    @RequestMapping("/playground")
    public String toGroupFromEvent(Model model, @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport) {
        User user = (User) httpSession.getAttribute("user");
        boolean isParticipant = false;
        if (sport.equals("Футбол")) {
            for (Playfootball playfootball : playfootballList) {
                if (playfootball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", playfootball.getName() );
                    model.addAttribute("street", playfootball.getStreet() );
                    model.addAttribute("house", playfootball.getHouse() );
                    model.addAttribute("sport", playfootball.getSubject() );
                    model.addAttribute("players", playgroundService.getFootballPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getFootballPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundFootballList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        } else if (sport.equals("Баскетбол")) {
            for (Basketball basketball : basketballList) {
                if (basketball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", basketball.getName() );
                    model.addAttribute("street", basketball.getStreet() );
                    model.addAttribute("house", basketball.getHouse() );
                    model.addAttribute("sport", basketball.getSubject() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getBasketballPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundBasketList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        } else if (sport.equals("Волейбол")) {
            for (Voleyball voleyball : voleyballList) {
                if (voleyball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", voleyball.getName() );
                    model.addAttribute("street", voleyball.getStreet() );
                    model.addAttribute("house", voleyball.getHouse() );
                    model.addAttribute("sport", voleyball.getSubject() );
                    model.addAttribute("players", playgroundService.getVoleyPlayersById(id) );
                    model.addAttribute("listEvents", playgroundService.getVoleyPlayById(id) );
                }
            }
            isParticipant = FluentIterable.from(user.getPlaygroundVoleyList()).firstMatch(new Predicate<String>() {
                @Override
                public boolean apply(String idPlay) {
                    return idPlay.equals(id);
                }
            }).isPresent();
        }


        model.addAttribute("returnBack", "home");
        model.addAttribute("isParticipant", isParticipant);
        model.addAttribute("playgroundId", id);
        return "playground";
    }

    @RequestMapping("/create")
    public String toCreate(Model model,  @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport,
                           @RequestParam(value="eventId", required = false, defaultValue = "null") String eventId) {
        if (sport.equals("Футбол")) {
            for (Playfootball playfootball : playfootballList) {
                if (playfootball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", playfootball.getName() );
                    model.addAttribute("playId", playfootball.getIdplayground() );
                    model.addAttribute("street", playfootball.getStreet() );
                    model.addAttribute("house", playfootball.getHouse() );
                    model.addAttribute("sport", playfootball.getSubject() );
                    model.addAttribute("players", playgroundService.getFootballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getFootballPlayById(id) );
                }
            }
        } else if (sport.equals("Баскетбол")) {
            for (Basketball basketball : basketballList) {
                if (basketball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", basketball.getName() );
                    model.addAttribute("playId", basketball.getIdplayground() );
                    model.addAttribute("street", basketball.getStreet() );
                    model.addAttribute("house", basketball.getHouse() );
                    model.addAttribute("sport", basketball.getSubject() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getBasketballPlayById(id) );
                }
            }
        } else if (sport.equals("Волейбол")) {
            for (Voleyball voleyball : voleyballList) {
                if (voleyball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", voleyball.getName() );
                    model.addAttribute("playId", voleyball.getIdplayground() );
                    model.addAttribute("street", voleyball.getStreet() );
                    model.addAttribute("house", voleyball.getHouse() );
                    model.addAttribute("sport", voleyball.getSubject() );
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

                for (Playfootball p : playfootballList) {
                    if (p.getIdplayground() == Integer.parseInt(id)) {
                        map.put("lat", Double.parseDouble(p.getLatitude()));
                        map.put("lng", Double.parseDouble(p.getLongitude()));
                        json = gson.toJson(map);
                    }

                }
            }

            if (sport.equals("Баскетбол")) {
                HashMap<String, Double> map = new HashMap<>();
                Gson gson = new Gson();

                for (Basketball p : basketballList) {
                    if (p.getIdplayground() == Integer.parseInt(id)) {
                        map.put("lat", Double.parseDouble(p.getLatitude()));
                        map.put("lng", Double.parseDouble(p.getLongitude()));
                        json = gson.toJson(map);
                    }

                }
            }

            if (sport.equals("Волейбол")) {
                HashMap<String, Double> map = new HashMap<>();
                Gson gson = new Gson();

                for (Voleyball p : voleyballList) {
                    if (p.getIdplayground() == Integer.parseInt(id)) {
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
        String userId = (String) httpSession.getServletContext().getAttribute("userId");
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
            voleyballList = playgroundService.getVoleyballPlayground();
            playfootballList = playgroundService.getFootballPlayground();
            basketballList = playgroundService.getBasketballPlayground();
            if (voleyballList == null || playfootballList == null || basketballList == null) {
                throw new DataBaseException(DataBaseException.ERORR_MESSAGE);
            }
            // Получение координат площадок и конвертация в JSON
            ArrayList<String> footLocationList = getСoordinateFootPlayground(playfootballList);
            ArrayList<String> basketLocationList = getСoordinateBasketPlayground(basketballList);
            ArrayList<String> voleyLocationList = getСoordinateVoleyPlayground(voleyballList);

            // Получение основных данных по площадкам и конвертация данных в формат JSON
            ArrayList<String> footInfoList = getFootInfoList(playfootballList);
            ArrayList<String> basketInfoList = getBasketInfoList(basketballList);
            ArrayList<String> voleyballInfoList = getVoleyballInfoList(voleyballList);

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
     * @param voleyballList
     * @return
     */
    private ArrayList<String> getVoleyballInfoList(List<Voleyball> voleyballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Voleyball p : voleyballList) {
            map.put("namePlayground", p.getName());
            map.put("street", p.getStreet());
            map.put("house", p.getHouse());
            map.put("link", p.getLinks());
            map.put("creator", p.getСreator());
            map.put("id", p.getIdplayground());
            map.put("sport", p.getSubject());
            String json = gson.toJson(map);
            mapArrayList.add(json);

        }
        return mapArrayList;
    }

    /**
     * Получение основных данных по площадкам и конвертация данных в формат JSON
     *
     * @param basketballList
     * @return
     */
    private ArrayList<String> getBasketInfoList(List<Basketball> basketballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Basketball p : basketballList) {
            map.put("namePlayground", p.getName());
            map.put("street", p.getStreet());
            map.put("house", p.getHouse());
            map.put("link", p.getLinks());
            map.put("creator", p.getСreator());
            map.put("id", p.getIdplayground());
            map.put("sport", p.getSubject());
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }

        return mapArrayList;
    }

    /**
     * Получение основных данных по площадкам и конвертация данных в формат JSON
     *
     * @param playfootballList
     * @return
     */
    private ArrayList<String> getFootInfoList(List<Playfootball> playfootballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playfootball p : playfootballList) {
            map.put("namePlayground", p.getName());
            map.put("street", p.getStreet());
            map.put("house", p.getHouse());
            map.put("link", p.getLinks());
            map.put("creator", p.getСreator());
            map.put("id", p.getIdplayground());
            map.put("sport", p.getSubject());

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
    private ArrayList<String> getСoordinateFootPlayground(List<Playfootball> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playfootball p : list) {
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
    private ArrayList<String> getСoordinateBasketPlayground(List<Basketball> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Basketball p : list) {
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
    private ArrayList<String> getСoordinateVoleyPlayground(List<Voleyball> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Voleyball p : list) {
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
