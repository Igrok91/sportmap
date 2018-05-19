package com.realsport.controller;


import com.google.cloud.Timestamp;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.google.gson.Gson;

import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.EventUser;
import com.realsport.model.entityDao.MinUser;
import com.realsport.model.entityDao.Playground;
import com.realsport.model.entityDao.TemplateGame;
import com.realsport.model.entityDao.User;

import com.realsport.model.service.CacheService;
import com.realsport.model.service.EventsService;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.UserService;
import com.realsport.model.service.VkService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.cache.Cache;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;

import static com.realsport.model.cache.CacheUser.getCacheUser;

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

    public static final String EVENTS = "events";
    public static final String EVENT = "event";
    public static final String PLAYGROUND = "playground";
    public static final Integer COUNT = 5;

    private static final Integer ADMIN = 172924708;


    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private EventsService eventsService;

    @Autowired
    private VkService vkService;

    @Autowired
    private UserService userService;

    @Autowired
    private CacheService cacheService;


    @RequestMapping(value = "/error2")
    public String error() {
        return "error2";
    }

    @RequestMapping(value = "/start")
    public String onStart(Model model, @RequestParam(value = "viewer_id") String userId,
                          @RequestParam(value = "access_token", required = false) String access_token,
                          @RequestParam(value = "hash", required = false) String hash) throws Exception {
        User user = null;
        boolean isFirst = false;
        logger.info("Зашел пользователь с id " + userId + ", access_token: " + access_token);
        if (userId != null) {
            try {
                user = getUser(userId);
                if (user != null) {
                    setPlaygroundDataToModel(model, userId);
                    setUserDataToModel(user, model);
                    Gson gson = new Gson();
                    List<Event> listEvents = eventsService.getEvents(user.getPlaygroundIdlList());
                    model.addAttribute("listEventsJson", gson.toJson(listEvents));
                    model.addAttribute("listEvents", listEvents);
                    model.addAttribute("playgroundCoordinate", "empty");
                    // События в которых пользователь поставил плюс
                    model.addAttribute("eventUserActive", getEventUserActive(listEvents, userId));
                } else {
                    model.addAttribute("userId", userId);
                    if (Objects.nonNull(hash) && !hash.isEmpty()) {
                        model.addAttribute("hash", hash);
                    } else {
                        model.addAttribute("hash", null);
                    }
                    return "begin";
                }
                if (Objects.nonNull(hash) && !hash.isEmpty()) {
                    logger.info("hash " + hash);
                /*    String[] s = hash.split("=");
                    String value;
                    if (s.length > 1) {
                         value = s[1];
                    } else {
                        logger.error("Нет значения id для event");
                        model.addAttribute("userId", userId);
                        return "error";
                    }
                    logger.info("value " + value);
                    switch (s[0].trim()) {
                        case EVENT_ID:
                            logger.info("redirect:/event");
                            return "redirect:/event?eventId=" + value.trim() + "&userId=" + userId;
                    }*/
                    //return "redirect:/event?eventId=" + hash.trim() + "&userId=" + userId;
                    Gson gson = new Gson();
                    Event event;
                    if (hash.contains("&")) {
                        String[] idev = hash.split("&");
                        event = eventsService.getEventById(idev[0].trim());
                    } else {
                        event = eventsService.getEventById(hash.trim());
                    }
                    if (Objects.isNull(event)) {
                        model.addAttribute("userId", userId);
                        return "error";
                    }
                    model.addAttribute("event", event);
                    model.addAttribute("eventJson", gson.toJson(event));

                    model.addAttribute("userId", userId);
                    model.addAttribute("user", user);
                    return "event";
                }

                model.addAttribute("user", user);
                MinUser minUser = new MinUser();
                minUser.setUserId(userId);
                minUser.setFirstName(user.getFirstName());
                minUser.setLastName(user.getLastName());
                model.addAttribute("userId", userId);
                model.addAttribute("firstName", user.getFirstName());
                model.addAttribute("lastName", user.getLastName());
                model.addAttribute("minUser", minUser);

            } catch (Exception e) {
                logger.error(e);
                model.addAttribute("userId", userId);
                return "error";
            }
        } else {
            model.addAttribute("userId", userId);
            return "error";
        }
        //vkService.sendMessage(Integer.valueOf(userId), "edwedwedw");
        return "main";
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
        map.put("info", user.getInfo());

        map.put("allPlaygroundUser", getAllPlaygroundUser(user));
        String jsonUser = gson.toJson(map);
        model.addAttribute("jsonUser", jsonUser);
        int countOrganize = 0;
        if (user.getListParticipant().size() > 0) {
            countOrganize = FluentIterable.from(user.getListParticipant()).filter(new Predicate<EventUser>() {
                @Override
                public boolean apply(EventUser eventUser) {
                    return eventUser.isOrganize();
                }
            }).size();
        }

        List<Playground> listPlygrounds = getAllPlaygroundUser(user);
        if (listPlygrounds.isEmpty()) {
            model.addAttribute("start", true);
        } else {
            model.addAttribute("start", false);
        }
        model.addAttribute("allPlaygroundUser", listPlygrounds);
        model.addAttribute("allowSendMessage", vkService.isAllowSendMessages(Integer.parseInt(user.getUserId())));
        model.addAttribute("countOrganize", countOrganize);
    }

    private List<Playground> getAllPlaygroundUser(User user) {
        List<Playground> allList = new ArrayList<>();
        if (user.getPlaygroundIdlList().size() != 0) {
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
            vkService.sendMessage(ADMIN, "В приложение зашел пользователь https://vk.com/id" + id);
            allPlaygroundList = playgroundService.getAllPlayground();
            logger.info("allPlaygroundList " + allPlaygroundList.size());
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
            vkService.sendMessage(ADMIN, errorCreateMaps(id, e));
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

    @RequestMapping("/groupFromMap")
    public String toGroup(Model model, @RequestParam(value = "playgroundId") String id
            , @RequestParam(value = "userId") String userId,
                          @RequestParam(value = "endList", required = false) String endList) {
        try {
            User user = getUser(userId);

            if (user == null) {
                model.addAttribute("userId", userId);
                return "error";
            }

            int size;
            if (Objects.nonNull(endList) && !endList.isEmpty()) {
                int end = Integer.parseInt(endList);
                size = end * 2;
            } else {
                size = COUNT;
            }
            logger.info("Переход в группу " + id);
            addGroupToModel(model, id, user, size);
            model.addAttribute("returnBack", "map");
            model.addAttribute("userId", userId);
            model.addAttribute("userPhoto", user.getPhoto_50());
            model.addAttribute("endList", size);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "playground";
    }

    private User getUser(String userId) {
        Cache cache = getCacheUser();
        User user = (User) cache.get(userId);
        if (Objects.isNull(user)) {
            logger.info("Достаем пользователя " + userId + " из бд и кладем в кеш");
            user = userService.getUser(userId);
            cache.put(userId, user);
        }
        return user;
    }

    private User getPlayers(String userId) {
        logger.info("Достаем пользователя " + userId + " из бд и кладем в кеш");
        return userService.getUser(userId);
    }


    private void addGroupToModel(Model model, String idGroup, User user, int size) {
        Playground playground = playgroundService.getPlaygroundById(idGroup);
        if (playground != null) {
            addGroupDataToModel(model, playground, idGroup, size);
        }
        model.addAttribute("firstName", user.getFirstName());
        model.addAttribute("lastName", user.getLastName());
        model.addAttribute("allowSendMessage", vkService.isAllowSendMessages(Integer.parseInt(user.getUserId())));

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

    private void addGroupDataToModel(Model model, Playground playground, String idGroup, int size) {
        model.addAttribute("playgroundId", playground.getIdplayground());
        model.addAttribute("namePlayground", playground.getName());
        model.addAttribute("street", playground.getStreet());
        model.addAttribute("house", playground.getHouse());
        model.addAttribute("sport", playground.getSport());
        model.addAttribute("players", playground.getPlayers());
        Gson gson = new Gson();
        List<Event> list = eventsService.getEventsByIdGroup(idGroup);
        List<Event> newList = null;
        if (Objects.nonNull(list)) {
            newList = FluentIterable.from(list).limit(size).toList();
        }
        model.addAttribute("listEvents", newList);
        model.addAttribute("listEventsJson", gson.toJson(newList));
        model.addAttribute("listSize", list.size());
    }

    @RequestMapping("/group")
    public String toGroupUser(Model model, @RequestParam(value = "playgroundId") String id
            , @RequestParam(value = "userId") String userId, @RequestParam(value = "endList", required = false) String endList) {
        try {
            User user = getUser(userId);
            if (user == null) {
                model.addAttribute("userId", userId);
                return "error";
            }
            int size;
            if (Objects.nonNull(endList) && !endList.isEmpty()) {
                int end = Integer.parseInt(endList);
                size = end * 2;
            } else {
                size = COUNT;
            }
            addGroupToModel(model, id, user, size);

            model.addAttribute("returnBack", "group");
            model.addAttribute("userId", userId);
            model.addAttribute("userPhoto", user.getPhoto_50());
            model.addAttribute("endList", size);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "playground";
    }

    @RequestMapping("/playground")
    public String toGroupFromEvent(Model model, @RequestParam(value = "playgroundId") String id,
                                   @RequestParam(value = "userId") String userId,
                                   @RequestParam(value = "endList", required = false) String endList) {
        try {
            User user = getUser(userId);
            if (user == null) {
                model.addAttribute("userId", userId);
                return "error";
            }
            int size;
            if (Objects.nonNull(endList) && !endList.isEmpty()) {
                int end = Integer.parseInt(endList);
                size = end * 2;
            } else {
                size = COUNT;
            }
            logger.info("size list event " + size);
            addGroupToModel(model, id, user, size);
            model.addAttribute("returnBack", "home");
            model.addAttribute("userPhoto", user.getPhoto_50());
            model.addAttribute("endList", size);
            model.addAttribute("userId", userId);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "playground";
    }

    @RequestMapping("/create")
    public String toCreate(Model model, @RequestParam(value = "playgroundId") String id, @RequestParam(value = "sport") String sport,
                           @RequestParam(value = "eventId", required = false, defaultValue = "null") String eventId,
                           @RequestParam(value = "userId") String userId) {
        try {
            for (Playground playground : playgroundService.getAllPlayground()) {
                if (playground.getIdplayground().equals(id)) {
                    model.addAttribute("namePlayground", playground.getName());
                    model.addAttribute("playId", playground.getIdplayground());
                    model.addAttribute("street", playground.getStreet());
                    model.addAttribute("house", playground.getHouse());
                    model.addAttribute("sport", playground.getSport());
                    model.addAttribute("players", playground.getPlayers());
                }
            }


            Gson gson = new Gson();
            if (!eventId.equals("null")) {

                Event event = eventsService.getEventById(eventId);
                model.addAttribute("eventJson", gson.toJson(event));
                model.addAttribute("event", event);
                model.addAttribute("templates", new ArrayList<>());
                model.addAttribute("template", new ArrayList<>());
            } else {
                User user = getUser(userId);
                List<TemplateGame> list = user.getTemplateGames();
                ArrayList<String> userTemplates = new ArrayList<>();
                if (list != null) {
                    userTemplates = getUserTemplates(list);
                    logger.info("TemplateGame size " + list.size());
                }
                model.addAttribute("eventJson", gson.toJson(new Event()));
                model.addAttribute("event", new Event());
                model.addAttribute("templates", userTemplates);
                model.addAttribute("template", list);
            }
            model.addAttribute("returnBack", "home");
            model.addAttribute("userId", userId);
            model.addAttribute("playgroundId", id);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "create";
    }

    @RequestMapping(value = "/home")
    public String toHome(Model model, @RequestParam(value = "where", required = false, defaultValue = "home") String where
            , @RequestParam(value = "playgroundId", required = false) String id, @RequestParam(value = "sport", required = false) String sport
            , @RequestParam(value = "userId") String userId) {
        try {
            if (where.equals("group")) {

                model.addAttribute("returnBack", where);
                model.addAttribute("sport", sport);
                model.addAttribute("playgroundCoordinate", "empty");
            } else if (where.equals("map")) {

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
            } else if (where.equals("profileMain")) {
                model.addAttribute("returnBack", "profileMain");
                model.addAttribute("playgroundCoordinate", "empty");
            } else {
                model.addAttribute("returnBack", "home");
                model.addAttribute("playgroundCoordinate", "empty");
            }
            addPlaygroundDataToModel(model);
            User user = getUser(userId);
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
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "main";
    }

    // Удаляем атрибут active
    @RequestMapping(value = "/deleteGame")
    public String deleteGame(Model model, @RequestParam(name = "eventId", required = false) String eventId,
                             @RequestParam(value = "userId") String userId,
                             @RequestParam(value = "playgroundId", required = false) String id,
                             @RequestParam(value = "where", required = false, defaultValue = "empty") String where) throws Exception {
        try {
            if (eventId != null) {
                Event event = eventsService.getEventById(eventId);
                eventsService.deleteGame(eventId);
                vkService.notifyDeleteUsersEvent(event, userId);
                cacheService.putToCache(eventId, userId, false);
            }
            if (where.equals("playground")) {
                return "redirect:/playground?playgroundId=" + id + "&userId=" + userId;
            }
            model.addAttribute("userId", userId);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "redirect:/home";
    }

    @RequestMapping(value = "/toPlayers")
    public String toPlayers(Model model, @RequestParam(name = "eventId") String eventId,
                            @RequestParam(value = "userId") String userId) throws Exception {
        try {
            if (eventId != null) {
                Event event = eventsService.getEventById(eventId);
                List<MinUser> list = eventsService.getUserListEvent(event.getUserList());

                model.addAttribute("userId", userId);
                model.addAttribute("userList", list);
                model.addAttribute("returnBack", "home");

            }
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "players";
    }

    @RequestMapping(value = "/toPlayersGroups")
    public String toPlayersGroups(Model model, @RequestParam(name = "playgroundId") String playgroundId,
                                  @RequestParam(value = "userId") String userId) throws Exception {
        try {
            if (playgroundId != null) {
                Playground playground = playgroundService.getPlaygroundById(playgroundId);
                List<MinUser> list = playground.getPlayers();

                model.addAttribute("userId", userId);
                model.addAttribute("playgroundId", playgroundId);
                model.addAttribute("userList", list);
                model.addAttribute("returnBack", "playground");
            }
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "players";
    }


    @RequestMapping(value = "/endGame")
    public String endGame(Model model, @RequestParam(name = "eventId", required = false) String eventId,
                          @RequestParam(value = "userId") String userId,
                          @RequestParam(value = "playgroundId", required = false) String id,
                          @RequestParam(value = "where", required = false, defaultValue = "empty") String where) throws Exception {
        try {
            if (eventId != null) {
                Event event = eventsService.getEventById(eventId);
                eventsService.endGame(eventId);
                if (event.getUserList().size() > 0) {
                    Long evId = Long.valueOf(eventId);
                    User user = getUser(userId);
                    user.getListParticipant().add(new EventUser(evId, true));
                    putToCacheUser(user);
                    userService.addEventToUserParticipant(event.getUserList(), evId, userId);
                    vkService.notifyEndUsersEvent(event, userId);
                }
            }

            cacheService.putToCache(eventId, userId,false);
            if (where.equals("playground")) {
                return "redirect:/playground?playgroundId=" + id + "&userId=" + userId;
            }
            model.addAttribute("userId", userId);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "redirect:/home";
    }


    @RequestMapping(value = "/event")
    public String event(Model model, @RequestParam(name = "eventId") String eventId,
                        @RequestParam(value = "userId") String userId,
                        @RequestParam(value = "where", required = false, defaultValue = "home") String where) {
        try {
            Gson gson = new Gson();
            User user = getUser(userId);
            Event event = eventsService.getEventById(eventId);
            if (Objects.isNull(event)) {
                model.addAttribute("userId", userId);
                return "error";
            }
            model.addAttribute("event", event);
            model.addAttribute("eventJson", gson.toJson(event));

            model.addAttribute("userId", userId);
            model.addAttribute("user", user);
            model.addAttribute("where", where);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "event";
    }

    @RequestMapping(value = "/user")
    public String toUser(Model model,
                         @RequestParam(value = "userId") String userId,
                         @RequestParam(value = "playerId") String playerId,
                         @RequestParam(name = "eventId", required = false) String eventId,
                         @RequestParam(value = "playgroundId", required = false) String playgroundId) {
        try {
            User user = getPlayers(playerId);
            Gson gson = new Gson();
            int countOrganize = FluentIterable.from(user.getListParticipant()).filter(new Predicate<EventUser>() {
                @Override
                public boolean apply(EventUser eventUser) {
                    return eventUser.isOrganize();
                }
            }).size();
            model.addAttribute("userlastName", user.getLastName());
            model.addAttribute("userfirstName", user.getFirstName());
            model.addAttribute("userPhoto", user.getPhoto_100());
            model.addAttribute("countGroup", user.getPlaygroundIdlList().size());
            model.addAttribute("countOrganize", countOrganize);
            model.addAttribute("countParticipant", user.getListParticipant().size());

            model.addAttribute("userId", userId);
            model.addAttribute("playerId", playerId);
            model.addAttribute("userInfoJson", gson.toJson(user.getInfo()));
            model.addAttribute("userInfo", user.getInfo());
            String where = EVENTS;
            if (eventId != null) {
                where = EVENT;
            } else if (playgroundId != null) {
                where = PLAYGROUND;
            }
            model.addAttribute("where", where);
            model.addAttribute("eventId", eventId);
            model.addAttribute("playgroundId", playgroundId);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "user";
    }

    @RequestMapping(value = "/userParticipant")
    public String userParticipant(Model model,
                                  @RequestParam(value = "userId") String userId,
                                  @RequestParam(value = "playerId") String playerId,
                                  @RequestParam(value = "where", required = false, defaultValue = "profileMain") String where,
                                  @RequestParam(value = "endList", required = false) String endList) {

        try {
            User user;
            if (where.equals("profile")) {
                where = "profile";
                user = getPlayers(playerId);
            } else {
                user = getUser(userId);
            }
            int size;
            if (Objects.nonNull(endList) && !endList.isEmpty()) {
                int end = Integer.parseInt(endList);
                size = end * 2;
            } else {
                size = COUNT;
            }
            Gson gson = new Gson();
            List<Event> list = eventsService.getEventUserParticipantOrOrganize(user.getListParticipant());
            List<Event> newList = null;
            if (Objects.nonNull(list)) {
                newList = FluentIterable.from(list).limit(size).toList();
            }
            logger.info("newList " + newList.size());
            // List<Event> list = eventsService.getEvents(user.getPlaygroundIdlList());
            model.addAttribute("listEvents", newList);
            model.addAttribute("listSize", list.size());
            model.addAttribute("listEventsJson", gson.toJson(newList));
            model.addAttribute("userId", userId);
            model.addAttribute("playerId", playerId);
            model.addAttribute("where", where);
            model.addAttribute("parameter", "userParticipant");
            model.addAttribute("endList", size);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "userParticipation";
    }

    @RequestMapping(value = "/groupsUser")
    public String groupsUser(Model model,
                             @RequestParam(value = "userId") String userId,
                             @RequestParam(value = "playerId") String playerId,
                             @RequestParam(value = "where", required = false, defaultValue = "profileMain") String where) {
        User user;
        if (where.equals("profile")) {
            where = "profile";
            user = getPlayers(playerId);
        } else {
            user = getUser(userId);
        }

        model.addAttribute("allPlaygroundUser", getAllPlaygroundUser(user));
        model.addAttribute("userId", userId);
        model.addAttribute("playerId", playerId);
        model.addAttribute("where", where);

        return "groupsUser";
    }

    @RequestMapping(value = "/userOrganize")
    public String userOrganize(Model model,
                               @RequestParam(value = "userId") String userId,
                               @RequestParam(value = "playerId") String playerId,
                               @RequestParam(value = "where", required = false, defaultValue = "profileMain") String where,
                               @RequestParam(value = "endList", required = false) String endList) {
        try {
            User user;
            if (where.equals("profile")) {
                where = "profile";
                user = getPlayers(playerId);
            } else {
                user = getUser(userId);
            }
            int size;
            if (Objects.nonNull(endList) && !endList.isEmpty()) {
                int end = Integer.parseInt(endList);
                size = end * 2;
            } else {
                size = COUNT;
            }
            Gson gson = new Gson();
            List<Event> list = eventsService.getEventUserParticipantOrOrganize(user.getListParticipant());
            List<Event> listOrganize = null;
//          List<Event> list = eventsService.getEvents(user.getPlaygroundIdlList());
            if (where.equals("profile")) {
                listOrganize = FluentIterable.from(list).filter(new Predicate<Event>() {
                    @Override
                    public boolean apply(Event event) {
                        return event.getUserIdCreator().equals(playerId);
                    }
                }).toList();
            } else {
                listOrganize = FluentIterable.from(list).filter(new Predicate<Event>() {
                    @Override
                    public boolean apply(Event event) {
                        return event.getUserIdCreator().equals(userId);
                    }
                }).toList();
            }

            List<Event> newList = null;
            if (Objects.nonNull(list)) {
                newList = FluentIterable.from(listOrganize).limit(size).toList();
            }
            model.addAttribute("listEvents", newList);
            model.addAttribute("listEventsJson", gson.toJson(newList));
            model.addAttribute("listSize", list.size());
            model.addAttribute("userId", userId);
            model.addAttribute("playerId", playerId);
            model.addAttribute("where", where);
            model.addAttribute("endList", size);
            model.addAttribute("parameter", "userOrganize");
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "userParticipation";
    }


    @RequestMapping(value = "/createGame", method = RequestMethod.POST)
    public String createGame(Model model,
                             @RequestParam(name = "descr", required = false, defaultValue = "description") String description,
                             @RequestParam(name = "answer", required = false, defaultValue = "+") String answer,
                             @RequestParam(name = "sel2", required = false, defaultValue = "Без ограничений") String sel2,
                             @RequestParam(name = "sel1", required = false, defaultValue = "3") String sel1,
                             @RequestParam(name = "sport", required = false, defaultValue = "Футбол") String sport,
                             @RequestParam(name = "playgroundId", required = false, defaultValue = "123") String playgroundId,
                             @RequestParam(name = "namePlayground") String namePlayground,
                             @RequestParam(name = "templateId", required = false, defaultValue = "0") String templateId,
                             @RequestParam(name = "eventId", required = false, defaultValue = "null") String eventId,
                             @RequestParam(value = "userId") String userId) throws Exception {
        try {
            User user = getUser(userId);
            Event game;
            logger.info("Description Event " + description);
            game = new Event();
            game.setDescription(description);
            game.setAnswer(answer);
            game.setMaxCountAnswer(sel2.equals("Без ограничений") ? 1000 : Integer.valueOf(sel2));
            game.setDuration(sel1.substring(0, 1).trim());
            game.setUserIdCreator(userId);
            game.setUserFirtsNameCreator(user.getFirstName());
            game.setUserLastNameCreator(user.getLastName());
            game.setUserCreatorPhoto(user.getPhoto_50());
            game.setPlaygroundId(playgroundId);
            game.setSport(sport);
            game.setDateCreation(Timestamp.of(new Date()));
            game.setPlaygroundName(namePlayground);
            List<User> list = new ArrayList<>();
            list.add(user);
            game.setUserList(list);


            if (!eventId.equals("null")) {
                logger.info("Изменяем событие с id " + eventId);
                game.setIdEvent(eventId);
                eventsService.editEventById(eventId, game.getDescription(), game.getMaxCountAnswer(), game.getDuration());
                cacheService.putToCache(game.getIdEvent(), userId, true);
            } else {
                eventsService.publishEvent(game);
                Playground playground = playgroundService.getPlaygroundById(playgroundId);
                vkService.sendMessagePublishEventToUsersGroup(playground.getPlayers()
                        , user, description, game.getIdEvent(), playground.getName());
                cacheService.putToCache(game.getIdEvent(), userId, false);
            }
            logger.info("event id " + eventId);

            model.addAttribute("userId", userId);
            model.addAttribute("user", user);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "redirect:/home";
    }


    @RequestMapping(value = "/createGameFromTemplate")
    public String createGameFromTemplate(Model model,
                                         @RequestParam(name = "templateId") String templateId,
                                         @RequestParam(value = "userId") String userId,
                                         @RequestParam(value = "playgroundId") String playgroundId,
                                         @RequestParam(name = "sport", required = false, defaultValue = "Футбол") String sport,
                                         @RequestParam(name = "namePlayground") String namePlayground) throws Exception {
        try {
            User user = getUser(userId);
            Event game = eventsService.createEventByTemplate(templateId, userId);
            if (Objects.nonNull(game)) {
                List<User> list = new ArrayList<>();
                list.add(user);
                game.setUserList(list);
                game.setDateCreation(Timestamp.of(new Date()));
                game.setPlaygroundId(playgroundId);
                game.setSport(sport);
                game.setPlaygroundName(namePlayground);
                game.setUserIdCreator(userId);
                game.setUserFirtsNameCreator(user.getFirstName());
                game.setUserLastNameCreator(user.getLastName());
                game.setUserCreatorPhoto(user.getPhoto_50());
                eventsService.publishEvent(game);
                Playground playground = playgroundService.getPlaygroundById(playgroundId);
                vkService.sendMessagePublishEventToUsersGroup(playground.getPlayers()
                        , user, game.getDescription(), game.getIdEvent(), playground.getName());
            }
            cacheService.putToCache(game.getIdEvent(), userId, false);
            model.addAttribute("userId", userId);
            model.addAttribute("user", user);
        } catch (Exception e) {
            logger.error(e);
            model.addAttribute("userId", userId);
            return "error";
        }
        return "redirect:/home";
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

    private void putToCacheUser(User user) {
        getCacheUser().put(user.getUserId(), user);
    }
}
