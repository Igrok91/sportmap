package com.realsport.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.appengine.api.memcache.MemcacheService;
import com.google.cloud.Timestamp;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.entity.LastEditData;
import com.realsport.model.entity.Template;
import com.realsport.model.entityDao.*;
import com.realsport.model.service.CacheService;
import com.realsport.model.service.EventsService;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.UserService;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.cache.Cache;
import java.io.IOException;
import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.TimeZone;

import static com.realsport.model.cache.CacheObserver.getCacheObserver;
import static com.realsport.model.cache.CacheUser.getCacheUser;

@org.springframework.web.bind.annotation.RestController
public class RestController {

    private Log logger = LogFactory.getLog(RestController.class);
    public static final String FOOTBALL = "Футбол";
    public static final String BASKETBALL = "Баскетбол";
    public static final String VOLEYBALL = "Волейбол";
    public static final String ERROR = "error";
    public static final String TRUE = "true";
    public static final String FALSE = "false";
    public static final String MAX_COUNT_ANSWER = "max_count_answer";

    @Autowired
    private UserService userService;

    @Autowired
    private EventsService eventsService;

    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private CacheService cacheService;

    @RequestMapping("removeTemplate")
    public void removeTemplate(@RequestParam(value="templateId", required=false, defaultValue="World") String templateId
                                , @RequestParam(value = "userId") String userId) {
        userService.removeTemplateUser(templateId, userId);
        User user = getUser(userId);
        user.getTemplateGames().removeIf(new Predicate<TemplateGame>() {
            @Override
            public boolean apply(TemplateGame templateGame) {
                return templateGame.getTemplateId().equals(templateId);
            }
        });
        putToCacheUser(user);
    }

    @RequestMapping(value = "sendCommentUser", method = RequestMethod.POST)
    @ResponseBody
    public Comment sendCommentUser( @RequestParam(value="message", required=false, defaultValue="World") String message,
                                         @RequestParam(value="eventId", required=false, defaultValue="5") String eventId,
                                         @RequestParam(value = "userId") String userId,
                                         @RequestParam(value="playgroundId") String playgroundId) throws Exception {
        User user = getUser(userId);
        Comment comment = new Comment();
        comment.setUserId(userId);
        comment.setMessage(message);
        comment.setFirstName(user.getFirstName());
        comment.setLastName(user.getLastName());
        comment.setDateCreation(Timestamp.of(new Date()));
        comment.setDate(getDateFormat());
        String commentId =  eventsService.addCommentToEvent(eventId, comment);
        if (commentId != null) {
            comment.setCommentId(commentId);
            cacheService.putToCache(playgroundId, userId);
            comment.setSuccess(true);
            return comment;
        }
        comment.setSuccess(false);
        return comment;
    }



    @RequestMapping("/deleteComment")
    public void deleteComment(@RequestParam(value="commentId", required=false, defaultValue="World") String commentId,
                              @RequestParam(value="eventId", required=false, defaultValue="World") String eventId,
                              @RequestParam(value="playgroundId") String playgroundId,
                              @RequestParam(value = "userId") String userId) throws Exception {
        eventsService.deleteCommentFromEvent(commentId, eventId);
        cacheService.putToCache(playgroundId, userId);
    }

    @RequestMapping(value = "/editUserInfo", method = RequestMethod.POST)
    public void editUserInfo(@RequestParam(value="userInfo", required=false) String userInfo,
                             @RequestParam(value = "userId") String userId) {
        User user = getUser(userId);
        user.setInfo(userInfo);
        putToCacheUser(user);
        userService.editUserInfo(userInfo, userId);
    }

    @RequestMapping("/handleAnswerMain")
    @ResponseBody
    public String handleAnswerMain(@RequestParam(value="eventId", required=false, defaultValue="World") String eventId
                                , @RequestParam(value = "userId") String userId) throws Exception {

        User user = getUser(userId);

        Event event = eventsService.getEventById(eventId);
        if (user != null && event != null) {
            int countUser = getCountUserFromEvent(event.getUserList());

                Boolean b = FluentIterable.from(event.getUserList()).firstMatch(new Predicate<User>() {
                    @Override
                    public boolean apply(User user) {
                         return user.getUserId().equals(userId);
                    }
                }).isPresent();

                    if (b == null || b.equals(Boolean.FALSE)) {
                        if (countUser>= event.getMaxCountAnswer()) {
                            return MAX_COUNT_ANSWER;
                        }
                        cacheService.putToCache(event.getPlaygroundId(), userId);
                        eventsService.addUserToEvent(eventId, user, false);
                        logger.info("Пользователь " + user + " поставил плюс");
                        return TRUE;
                    } else {
                        eventsService.deleteUserFromEvent(eventId, userId);
                        cacheService.putToCache(event.getPlaygroundId(), userId);
                        logger.info("Пользователь " + user + " поставил минус");
                        return FALSE;
                    }


        }
        return ERROR;
    }



    @RequestMapping("/handleAnswer")
    @ResponseBody
    public String handleAnswer(@RequestParam(value="eventId", required=false, defaultValue="World") String eventId,
                               @RequestParam(value = "userId") String userId) throws Exception {
        User user = getUser(userId);
        Event event = eventsService.getEventById(eventId);

        if (user != null && event != null) {
            int countUser = getCountUserFromEvent(event.getUserList());
            if (countUser >= event.getMaxCountAnswer()) {
                return MAX_COUNT_ANSWER;
            }
            Boolean b = FluentIterable.from(event.getUserList()).firstMatch(new Predicate<User>() {
                @Override
                public boolean apply(User user) {
                    return user.getUserId().equals(userId);
                }
            }).isPresent();
                if (b == null || b.equals(Boolean.FALSE)) {
                    eventsService.addUserToEvent(eventId, user, false);
                    cacheService.putToCache(event.getPlaygroundId(), userId);
                    logger.info("Boolean.TRUE.toString() " + Boolean.TRUE.toString());
                    return TRUE;
                } else {
                    return FALSE;

                }
            }


        return ERROR;
    }

    private int getCountUserFromEvent(List<User> userList) {
        int count = 0;
        for (User user : userList) {
            if (user.isFake()) {
                count = count + user.getCountFake();
            } else {
                count++;
            }
        }
        return count;
    }

    @RequestMapping("/handleGroup")
    @ResponseBody
    public Boolean handleGroup(@RequestParam(value="playgroundId", required=false, defaultValue="1") String playgroundId,
                               @RequestParam(value="sport", required=false, defaultValue=" Футбол") String sport,
                               @RequestParam(value = "userId") String userId) {

        User user = getUser(userId);
        Boolean isParticipant = false;
            String id = FluentIterable.from(user.getPlaygroundIdlList()).filter(new Predicate<String>() {
                @Override
                public boolean apply(String id) {
                    return id.equals(playgroundId);
                }
            }).first().orNull();
            System.out.println("id= " + id);
            if (id == null) {
                logger.info("User c id " + userId + " вступил в группу " + playgroundId);
                user.getPlaygroundIdlList().add(playgroundId);
                playgroundService.addUserToPlayground(getUserMin(user), playgroundId);
                userService.addPlaygroundToUser(userId, playgroundId);
                isParticipant = Boolean.TRUE;
            } else {
                logger.info("User c id " + userId + " вышел из группы " + playgroundId);
                user.getPlaygroundIdlList().remove(id);
                playgroundService.deleteUserFromPlayground(userId, playgroundId);
                userService.deletePlaygroundFromUser(userId, playgroundId);
                isParticipant = Boolean.FALSE;
            }
            putToCacheUser(user);
     return isParticipant;
    }

    private void putToCacheUser(User user) {
        getCacheUser().put(user.getUserId(), user);
    }

    private MinUser getUserMin(User user) {
        MinUser userMin = new MinUser();
        userMin.setUserId(user.getUserId());
        userMin.setFirstName(user.getFirstName());
        userMin.setLastName(user.getLastName());
        return userMin;
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

    @RequestMapping("/addIgrok")
    @ResponseBody
    public String addIgrok(@RequestParam(value="eventId", required=false, defaultValue="World") String eventId,
                         @RequestParam(value="count", required=false, defaultValue="1") String count,
                         @RequestParam(value = "userId") String userId) throws Exception {
        User user = getUser(userId);
        logger.info("Добавляем " + count + " игроков от пользователя" );
        Event event = eventsService.getEventById(eventId);
        if (Objects.nonNull(user) && Objects.nonNull(event)) {
            int countUser = getCountUserFromEvent(event.getUserList());
            if ((countUser >= event.getMaxCountAnswer()) ||
                    ((Integer.parseInt(count) + countUser ) > event.getMaxCountAnswer())) {
                return MAX_COUNT_ANSWER;
            }
            user.setFake(true);
            user.setCountFake(Integer.parseInt(count));
            eventsService.addUserToEvent(eventId, user, true);
            cacheService.putToCache(event.getPlaygroundId(), userId);
            return TRUE;
        }
        return ERROR;
    }

    @RequestMapping("/getNewDataEvents")
    @ResponseBody
    public List<Event> getNewDataEvents(Model model, @RequestParam(value = "date") long date,
                                  @RequestParam(value = "userId") String userId) throws ParseException {

        Date now = new Date(date);
        logger.info("Date " + now);
        User user = getUser(userId);
        boolean isEditData = false;
        MemcacheService memcacheService = getCacheObserver();
        for (String id : user.getPlaygroundIdlList()) {
            MemcacheService.IdentifiableValue value =  memcacheService.getIdentifiable(id);
            if (Objects.nonNull(value)) {
                LastEditData last = (LastEditData) value.getValue();
                logger.info("Last Date Update " + last.getDate());
                if (!Objects.equals(last.getIdUserEdit(), userId)) {
                    if (now.before(last.getDate())) {
                        logger.info("Данные изменились ");
                        isEditData = true;
                    }
                }

            }
        }
        if (isEditData) {
            List<Event> listEvents = eventsService.getEvents(user.getPlaygroundIdlList());
            return listEvents;
        }
        return null;
    }

    @RequestMapping("/getNewDataEventsPlayground")
    @ResponseBody
    public List<Event> getNewDataEventsPlayground(Model model, @RequestParam(value = "date") long date,
                                        @RequestParam(value = "userId") String userId,
                                                  @RequestParam(value="playgroundId") String playgroundId) throws ParseException {

        Date now = new Date(date);
        logger.info("Date " + now);
        User user = getUser(userId);
        boolean isEditData = false;
        MemcacheService memcacheService = getCacheObserver();
        for (String id : user.getPlaygroundIdlList()) {
            MemcacheService.IdentifiableValue value =  memcacheService.getIdentifiable(playgroundId);
            if (Objects.nonNull(value)) {
                LastEditData last = (LastEditData) value.getValue();
                logger.info("Last Date Update " + last.getDate());
                if (!Objects.equals(last.getIdUserEdit(), userId)) {
                    if (now.before(last.getDate())) {
                        logger.info("Данные изменились ");
                        isEditData = true;
                    }
                }

            }
        }
        if (isEditData) {
            List<Event> listEvents = eventsService.getActiveEventsByIdGroup(playgroundId);
            return listEvents;
        }
        return null;
    }

    @RequestMapping("/getNewDataEvent")
    @ResponseBody
    public Event getNewDataEvent(Model model, @RequestParam(value = "date") long date,
                                       @RequestParam(value = "userId") String userId,
                                       @RequestParam(value="playgroundId") String playgroundId,
                                       @RequestParam(value="eventId") String eventId) throws ParseException {

        Date now = new Date(date);
        logger.info("Date " + now);
        boolean isEditData = false;
        MemcacheService memcacheService = getCacheObserver();
            MemcacheService.IdentifiableValue value =  memcacheService.getIdentifiable(playgroundId);
            if (Objects.nonNull(value)) {
                LastEditData last = (LastEditData) value.getValue();
                logger.info("Last Date Update " + last.getDate());
                if (!Objects.equals(last.getIdUserEdit(), userId)) {
                    if (now.before(last.getDate())) {
                        logger.info("Данные изменились ");
                        isEditData = true;
                    }
                }

            }

        if (isEditData) {
            Event event = eventsService.getEventById(eventId);
            return event;
        }
        return null;
    }


    @RequestMapping(value = "saveTemplate", method = RequestMethod.POST)
    @ResponseBody
    public String saveTemplate(@RequestParam(name = "descr") String  descr, @RequestParam(name = "answer") String  answer,
                               @RequestParam(name = "sel2") String  sel2,
                               @RequestParam(name = "sel1") String  sel1,
                               @RequestParam(value = "userId") String userId) throws IOException {
        TemplateGame game = new TemplateGame();
        game.setDescription(descr);
        game.setCountAnswer(sel2.equals("infinity") ? 1000 : Integer.valueOf(sel2));
        game.setDuration(sel1.substring(0, 1));
        User user = getUser(userId);
        user.addTemplateGames(game);
        logger.info("user Id " + userId);
        String minText = getMinText(descr);
        String id = userService.saveTemplateUser(game, userId);
        Template resp = new Template();
        resp.setDescription(minText);
        resp.setTemplateId(id);
        putToCacheUser(user);
        return toJson(resp);
    }



    private String getMinText(String description) {
        String minText = description;
        if (description.length() > 35) {
            minText = description.substring(0, 30) + "...";
        }
        return minText;
    }

    private String toJson(Object template) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            String value = mapper.writeValueAsString(template);
            return value;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }

    private static DateFormatSymbols myDateFormatSymbols = new DateFormatSymbols(){

        @Override
        public String[] getMonths() {
            return new String[]{"янв", "фев", "мар", "апр", "мая", "июня",
                    "июля", "авг", "сен", "окт", "ноя", "дек"};
        }

    };

    private String getDateFormat() {
        Date date = new Date();
        logger.info("getDateFormat for Comment " + date);
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM в HH:mm ", myDateFormatSymbols );
        SimpleDateFormat dateFormatNow = new SimpleDateFormat("dd MMMM", myDateFormatSymbols );
        dateFormat.setTimeZone(TimeZone.getTimeZone("Europe/Moscow"));
        String d = dateFormat.format(date);
        String dateNow = dateFormatNow.format(new Date());
        logger.info("dateNow " + dateNow);
        if (d.contains(dateNow.trim())) {
            logger.info("replace " + dateNow);
            String d2 = "сегодня в " + d.split("в")[1].trim();
            logger.info("date new " + d2);
            return d2;
        }
        logger.info("dateFormat " + d);
        return d;
    }

}
