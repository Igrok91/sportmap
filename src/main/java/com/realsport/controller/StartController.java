package com.realsport.controller;

import com.google.cloud.Timestamp;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.google.gson.Gson;
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
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

/**
 * Created by Igor on 31.03.2017.
 */
@Controller
public class StartController {

    Log logger = LogFactory.getLog(StartController.class);

    private List<Playground> footballPlaygroundList = new ArrayList<>();
    private List<Playground> voleyballPlaygroundList = new ArrayList<>();
    private List<Playground> basketballPlaygroundList = new ArrayList<>();

    private List<Playground> allPlaygroundList = new ArrayList<>();


    ArrayList<String> footLocationList = new ArrayList<>();
    ArrayList<String> basketLocationList = new ArrayList<>();
    ArrayList<String> voleyLocationList = new ArrayList<>();

    ArrayList<String> footInfoList = new ArrayList<>();
    ArrayList<String> basketInfoList = new ArrayList<>();
    ArrayList<String> voleyballInfoList = new ArrayList<>();

    public static final String FOOTBALL = "football";
    public static final String BASKETBALL = "basketball";
    public static final String VOLEYBALL = "voleyball";
    public static final int INACTIVE_INTERVAL = 3600;

    private static final Integer ADMIN = 172924708;


    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private EventsService eventsService;

    @Autowired
    private VkService messageService;

    @Autowired
    private UserService userService;


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
                 user = userService.getUser(id);
                if (user != null) {
                    setPlaygroundDataToModel(model, id);
                    setUserDataToModel(user, model);
                    Gson gson = new Gson();
                    List<Event> listEvents = eventsService.getEvents(user.getPlaygroundIdlList());
                    model.addAttribute("listEventsJson", gson.toJson(listEvents));
                    model.addAttribute("listEvents", listEvents);
                    model.addAttribute("playgroundCoordinate", "empty");
                    // События в которых пользователь поставил плюс
                    model.addAttribute("eventUserActive", getEventUserActive(listEvents, id));
                } else {
                    user = userService.registerUser(id);
                    isFirst = true;
                }
                model.addAttribute("user", user);
                MinUser minUser = new MinUser();
                minUser.setUserId(id);
                minUser.setFirstName(user.getFirstName());
                minUser.setLastName(user.getLastName());
                model.addAttribute("userId", id);
                model.addAttribute("firstName", user.getFirstName());
                model.addAttribute("lastName", user.getLastName());
                model.addAttribute("minUser", minUser);

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            model.addAttribute("userId", id);
            return "error";
        }

        return !isFirst ? "main" : "begin";
    }

    private List<String> getEventUserActive(List<Event> listEvents, String id) {
        List<Event> activeUserEvent = FluentIterable.from(listEvents).filter(new Predicate<Event>() {
            @Override
            public boolean apply(Event event) {
                List<User> list = event.getUserList();
                boolean isActive = false;
                for (User user : list) {
                    if (user.getUserId().equals(id)) {

                        isActive = true;
                    }
                }
                return isActive;
            }
        }).toList();
        logger.info("activeUserEvent " + activeUserEvent);
        List<String> stringList = new ArrayList<>();
        for (Event event : activeUserEvent) {
            stringList.add(event.getIdEvent());
        }
        return stringList;
    }

    private void setUserDataToModel(User user, Model model) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        map.put("isAdmin", user.isAdmin());
        map.put("playgroundUser", user.getPlaygroundIdlList());

        map.put("allPlaygroundUser", getAllPlaygroundUser(user));
        String jsonUser = gson.toJson(map);
        model.addAttribute("sessionUser", jsonUser);


        model.addAttribute("allPlaygroundUser", getAllPlaygroundUser(user));
    }

    private List<Playground> getAllPlaygroundUser(User user) {
        List<Playground> allList = new ArrayList<>();
        if ( user.getPlaygroundIdlList().size() != 0) {
            for (String id : user.getPlaygroundIdlList()) {
                Playground p = FluentIterable.from(allPlaygroundList).firstMatch(new Predicate<Playground>() {
                    @Override
                    public boolean apply(Playground playfootball) {
                        return playfootball.getIdplayground().equals(id);
                    }
                }).orNull();
                if (p != null) {
                    allList.add(p);
                }
            }
        }
        return allList;
    }



    private void setPlaygroundDataToModel(Model model, String id) throws Exception {
        try {
            //messageService.sendMessage(ADMIN, "В приложение зашел пользователь с id " + id);
            allPlaygroundList = playgroundService.getAllPlayground();
            logger.info("allPlaygroundList " + allPlaygroundList.size() );
            // Получение данных по площадкам из базы данных
            voleyballPlaygroundList = playgroundService.getVoleyballPlayground(allPlaygroundList);
            footballPlaygroundList = playgroundService.getFootballPlayground(allPlaygroundList);
            basketballPlaygroundList = playgroundService.getBasketballPlayground(allPlaygroundList);
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


        return "main";
    }

    @RequestMapping("/groupFromMap")
    public String toGroup(Model model, @RequestParam(value="playgroundId") String id
            , @RequestParam(value="sport", required=false, defaultValue=FOOTBALL) String sport
            ,@RequestParam(value = "userId") String userId) {
        User user = userService.getUser(userId);

        if (user == null) {
            return "error";
        }
        logger.info("Переход в группу " + id);
        addGroupToModel(model, id, user);
        model.addAttribute("returnBack", "map");
        model.addAttribute("userId", userId);

        return "playground";
    }

    private void addGroupToModel(Model model, String idGroup, User user) {
        Playground playground = playgroundService.getPlaygroundById(idGroup);
            if (playground != null) {
                addGroupDataToModel(model, playground, idGroup);
            }
        model.addAttribute("firstName", user.getFirstName());
        model.addAttribute("lastName", user.getLastName());

        model.addAttribute("isParticipant", isParticipant(user.getPlaygroundIdlList(), idGroup));
    }

    private boolean isParticipant(List<String> playgroundList, String idGroup) {
        return FluentIterable.from(playgroundList).firstMatch(new Predicate<String>() {
            @Override
            public boolean apply(String idPlay) {
                return idPlay.equals(idGroup);
            }
        }).isPresent();
    }

    private void addGroupDataToModel(Model model, Playground playground, String idGroup) {
        model.addAttribute("playgroundId", playground.getIdplayground());
        model.addAttribute("namePlayground", playground.getName() );
        model.addAttribute("street", playground.getStreet() );
        model.addAttribute("house", playground.getHouse() );
        model.addAttribute("sport", playground.getSport() );
        model.addAttribute("players", playground.getPlayers() );
        model.addAttribute("listEvents", eventsService.getEventsByIdGroup(idGroup) );

    }

    @RequestMapping("/group")
    public String toGroupUser(Model model, @RequestParam(value="playgroundId") String id
            , @RequestParam(value="sport") String sport
            ,@RequestParam(value = "userId") String userId) {
        User user = userService.getUser(userId);
        if (user == null) {
            return "error";
        }
        addGroupToModel(model, id, user);

        model.addAttribute("returnBack", "group");
        model.addAttribute("userId", userId);
        return "playground";
    }

    @RequestMapping("/playground")
    public String toGroupFromEvent(Model model, @RequestParam(value="playgroundId") String id
            , @RequestParam(value="sport") String sport
            , @RequestParam(value = "userId") String userId) {
        User user = userService.getUser(userId);
        if (user == null) {
            return "error";
        }

        addGroupToModel(model, id, user);
        model.addAttribute("returnBack", "home");
        model.addAttribute("userId", userId);
        return "playground";
    }

    @RequestMapping("/create")
    public String toCreate(Model model,  @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport,
                           @RequestParam(value="eventId", required = false, defaultValue = "null") String eventId
                            ,@RequestParam(value = "userId") String userId) {

            for (Playground playground : allPlaygroundList) {
                if (playground.getIdplayground().equals(id)) {
                    model.addAttribute("namePlayground", playground.getName() );
                    model.addAttribute("playId", playground.getIdplayground() );
                    model.addAttribute("street", playground.getStreet() );
                    model.addAttribute("house", playground.getHouse() );
                    model.addAttribute("sport", playground.getSport() );
                    model.addAttribute("players", playground.getPlayers() );
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
            List<TemplateGame> list = userService.getTemplatesUserById(userId);
            ArrayList<String> userTemplates = new ArrayList<>();
            if (list != null) {
                userTemplates = getUserTemplates(list);
                logger.info("TemplateGame size " + list.size());
            }
            model.addAttribute("eventJson", gson.toJson(new Event()) );
            model.addAttribute("event", new Event() );
            model.addAttribute("templates", userTemplates);
            model.addAttribute("template", list);
        }
        model.addAttribute("returnBack", "home");
        model.addAttribute("userId", userId);
        model.addAttribute("playgroundId", id);
        return "create";
    }

    @RequestMapping(value = "/home")
    public String toHome(Model model, @RequestParam(value="where", required = false, defaultValue = "home") String where
            , @RequestParam(value="playgroundId", required = false) String id, @RequestParam(value="sport", required = false) String sport
            , @RequestParam(value = "userId") String userId) {
        if (where.equals("group")) {
            addPlaygroundDataToModel(model);
            model.addAttribute("returnBack", where);
            model.addAttribute("sport", sport);
            model.addAttribute("playgroundCoordinate", "empty");
        } else if (where.equals("map")) {
            addPlaygroundDataToModel(model);
            String json = null;
            HashMap<String, Double> map = new HashMap<>();
            Gson gson = new Gson();

                for (Playground p : allPlaygroundList) {
                    if (p.getIdplayground().equals(id)) {
                        map.put("lat", Double.parseDouble(p.getLatitude()));
                        map.put("lng", Double.parseDouble(p.getLongitude()));
                        json = gson.toJson(map);
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

        User user = userService.getUser(userId);
        setUserDataToModel(user, model);
        Gson gson = new Gson();
        List<Event> listEvents = eventsService.getEvents(user.getPlaygroundIdlList());
        model.addAttribute("eventUserActive", getEventUserActive(listEvents, user.getUserId()));
        model.addAttribute("listEventsJson", gson.toJson(listEvents));
        model.addAttribute("listEvents", listEvents);

        model.addAttribute("userId", userId);
        model.addAttribute("user", user);
        model.addAttribute("firstName", user.getFirstName());
        model.addAttribute("lastName", user.getLastName());
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
    public String event(Model model, @RequestParam(name = "eventId") String eventId,
                        @RequestParam(value = "userId") String userId) {
        Gson gson = new Gson();
        User user = userService.getUser(userId);
        List<Event> listEvents = eventsService.getEvents(user.getPlaygroundIdlList());
        Event event = FluentIterable.from(listEvents).firstMatch(new Predicate<Event>() {
            @Override
            public boolean apply(Event event) {
                return event.getIdEvent().equalsIgnoreCase(eventId);
            }
        }).get();
        model.addAttribute("event", event);
        model.addAttribute("eventJson", gson.toJson(event));

        model.addAttribute("userId", userId);
        model.addAttribute("user", user);
        model.addAttribute("eventUserActive", getEventUserActive(listEvents, userId));
        return "event";
    }



    @RequestMapping(value = "/createGame", method = RequestMethod.POST)
    public String createGame(Model model,
                             @RequestParam(name = "descr", required = false, defaultValue = "description") String  descr,
                             @RequestParam(name = "answer", required = false, defaultValue="+") String  answer,
                             @RequestParam(name = "sel2", required = false, defaultValue="Без ограничений") String  sel2,
                             @RequestParam(name = "sel1", required = false, defaultValue="3") String  sel1,
                             @RequestParam(name = "sport", required = false, defaultValue="Футбол") String  sport,
                             @RequestParam(name = "playgroundId", required = false, defaultValue="123") String  playgroundId,
                             @RequestParam(name = "namePlayground") String  namePlayground,
                             @RequestParam(name = "templateId", required = false, defaultValue = "0") String  templateId,
                             @RequestParam(name = "eventId", required = false, defaultValue = "null") String  eventId,
                             @RequestParam(value = "userId") String userId)  throws IOException {
        User user = userService.getUser(userId);
        Event game;
        logger.info("Description Event " + descr);
        if (templateId.equals("empty")) {
            game = new Event();
            game.setDescription(descr);
            game.setAnswer(answer);
            game.setMaxCountAnswer(sel2.equals("Без ограничений") ? 0 : Integer.valueOf(sel2));
            game.setDuration(sel1.substring(0, 1));
            game.setUserIdCreator(userId);
            game.setPlaygroundId(playgroundId);
            game.setSport(sport);
            game.setDateCreation(Timestamp.now());
            game.setPlaygroundName(namePlayground);
            List<User> list = new ArrayList<>();
            list.add(user);
            game.setUserList(list);
        } else {
            game = eventsService.createEventByTemplate(templateId, templateId);
        }

        if (!eventId.equals("null")) {
            game.setIdEvent(eventId);
            eventsService.editEventById(eventId);
        } else {
            eventsService.publishEvent(game);
        }

        model.addAttribute("userId", userId);
        model.addAttribute("user", user);
        return "redirect:/home";
    }


    @RequestMapping(value = "/createGameFromTemplate")
    public String createGameFromTemplate(Model model,
                                         @RequestParam(name = "templateId") String  templateId,
                                         @RequestParam(value = "userId") String userId,
                                         @RequestParam(value = "playgroundId") String playgroundId,
                                         @RequestParam(name = "sport", required = false, defaultValue="Футбол")  String  sport,
                                         @RequestParam(name = "namePlayground") String  namePlayground)  throws IOException {
        User user = userService.getUser(userId);
        Event game = eventsService.createEventByTemplate(templateId, userId);
        if (Objects.nonNull(game)) {
            List<User> list = new ArrayList<>();
            list.add(user);
            game.setUserList(list);
            game.setDateCreation(Timestamp.now());
            game.setPlaygroundId(playgroundId);
            game.setSport(sport);
            game.setPlaygroundName(namePlayground);
        }

        eventsService.publishEvent(game);

        model.addAttribute("userId", userId);
        model.addAttribute("user", user);
        return "redirect:/home";
    }

    private Date getDateCreation() {

        return new Date();
    }


    private ArrayList<String> getUserTemplates(List<TemplateGame> list) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> templates = new ArrayList<>();
        for (TemplateGame p : list) {
            map.put("templateId", p.getTemplateId());
            map.put("description", p.getDescription());
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
    private ArrayList<String> getVoleyballInfoList(List<Playground> voleyballPlaygroundList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playground p : voleyballPlaygroundList) {
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
    private ArrayList<String> getBasketInfoList(List<Playground> basketballPlaygroundList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playground p : basketballPlaygroundList) {
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
    private ArrayList<String> getFootInfoList(List<Playground> footballPlaygroundList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playground p : footballPlaygroundList) {
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
    private ArrayList<String> getСoordinateFootPlayground(List<Playground> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playground p : list) {
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
    private ArrayList<String> getСoordinateBasketPlayground(List<Playground> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playground p : list) {
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
    private ArrayList<String> getСoordinateVoleyPlayground(List<Playground> list) {
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        for (Playground p : list) {
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

    public static HttpSession session() {
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        return attr.getRequest().getSession(true); // true == allow create
    }
}
