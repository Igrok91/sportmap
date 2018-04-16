package com.realsport.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.entity.Template;
import com.realsport.model.entityDao.*;
import com.realsport.model.service.EventsService;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.UserService;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@org.springframework.web.bind.annotation.RestController
public class RestController {

    private Log logger = LogFactory.getLog(RestController.class);
    public static final String FOOTBALL = "Футбол";
    public static final String BASKETBALL = "Баскетбол";
    public static final String VOLEYBALL = "Волейбол";
    public static final String SESSION_NULL = "sessionNull";

    @Autowired
    private UserService userService;

    @Autowired
    private EventsService eventsService;

    @Autowired
    private PlaygroundService playgroundService;

    @RequestMapping("removeTemplate")
    public void removeTemplate(@RequestParam(value="templateId", required=false, defaultValue="World") String templateId
                                , @RequestParam(value = "userId") String userId) {
        userService.removeTemplateUser(templateId, userId);
    }

    @RequestMapping(value = "sendCommentUser", method = RequestMethod.POST)
    @ResponseBody
    public List<Comment> sendCommentUser( @RequestParam(value="message", required=false, defaultValue="World") String message,
                                          @RequestParam(value="eventId", required=false, defaultValue="5") String eventId
                                        , @RequestParam(value = "userId") String userId) {
        User user = userService.getUser(userId);
        Comment comment = new Comment();
        comment.setUserId(userId);
        comment.setMessage(message);
        comment.setFirstName(user.getFirstName());
        comment.setLastName(user.getLastName());
        comment.setDate(new Date().toString());
        int commentId =  eventsService.addCommentToEvent(eventId, comment);
        comment.setCommentId(String.valueOf(commentId));
        List<Comment> list = eventsService.getCommentFromEventById(eventId);
        list.add(comment);

        return list;
    }



    @RequestMapping("/deleteComment")
    public void deleteComment(@RequestParam(value="commentId", required=false, defaultValue="World") String commentId,
                              @RequestParam(value="eventId", required=false, defaultValue="World") String eventId) {
        eventsService.deleteCommentFromEvent(commentId, eventId);
    }

    @RequestMapping("/editUserInfo")
    public void editUserInfo(@RequestParam(value="userInfo", required=false, defaultValue="World") String userInfo) {
        userService.editUserInfo(userInfo);
    }

    @RequestMapping("/handleAnswerMain")
    @ResponseBody
    public String handleAnswerMain(@RequestParam(value="eventId", required=false, defaultValue="World") String eventId
                                , @RequestParam(value = "userId") String userId) {

        User user = userService.getUser(userId);

        Event event = eventsService.getEventById(eventId);
        if (user != null && event != null) {
                Boolean b = FluentIterable.from(event.getUserList()).firstMatch(new Predicate<User>() {
                    @Override
                    public boolean apply(User user) {
                         return user.getUserId().equals(userId);
                    }
                }).isPresent();

                    if (b == null || b.equals(Boolean.FALSE)) {
                        eventsService.addUserToEvent(eventId, user, false);
                        logger.info("Пользователь " + user + " поставил плюс");
                        return "true";
                    } else {
                        eventsService.deleteUserFromEvent(eventId, userId);
                        logger.info("Пользователь " + user + " поставил минус");
                        return "false";
                    }


        }
        return SESSION_NULL;
    }

    @RequestMapping("/handleAnswer")
    @ResponseBody
    public String handleAnswer(@RequestParam(value="eventId", required=false, defaultValue="World") String eventId,
                               @RequestParam(value = "userId") String userId) {
        User user = userService.getUser(userId);
        Event event = eventsService.getEventById(eventId);
        if (user != null && event != null) {

            Boolean b = FluentIterable.from(event.getUserList()).firstMatch(new Predicate<User>() {
                @Override
                public boolean apply(User user) {
                    return user.getUserId().equals(userId);
                }
            }).isPresent();
                if (b == null || b.equals(Boolean.FALSE)) {
                    eventsService.addUserToEvent(eventId, user, false);
                    logger.info("Boolean.TRUE.toString() " + Boolean.TRUE.toString());
                    return "true";
                } else {
                    return "false";
                }
            }


        return SESSION_NULL;
    }

    @RequestMapping("/handleGroup")
    @ResponseBody
    public Boolean handleGroup(@RequestParam(value="playgroundId", required=false, defaultValue="1") String playgroundId,
                               @RequestParam(value="sport", required=false, defaultValue=" Футбол") String sport,
                               @RequestParam(value = "userId") String userId) {

        User user = userService.getUser(userId);
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
     return isParticipant;
    }

    private MinUser getUserMin(User user) {
        MinUser userMin = new MinUser();
        userMin.setUserId(user.getUserId());
        userMin.setFirstName(user.getFirstName());
        userMin.setLastName(user.getLastName());
        return userMin;
    }

    @RequestMapping("/addIgrok")
    public void addIgrok(@RequestParam(value="eventId", required=false, defaultValue="World") String eventId,
                         @RequestParam(value="count", required=false, defaultValue="1") String count,
                         @RequestParam(value = "userId") String userId) {
        User user = userService.getUser(userId);
        logger.info("Добавляем " + count + " игроков от пользователя" );
        if (Objects.nonNull(user)) {
            user.setFake(true);
            user.setCountFake(Integer.parseInt(count));
            eventsService.addUserToEvent(eventId, user, true);
        }
    }


    @RequestMapping(value = "saveTemplate", method = RequestMethod.POST)
    @ResponseBody
    public String saveTemplate(@RequestParam(name = "descr") String  descr, @RequestParam(name = "answer") String  answer,
                               @RequestParam(name = "sel2") String  sel2,
                               @RequestParam(name = "sel1") String  sel1,
                               @RequestParam(value = "userId") String userId) throws IOException {
        TemplateGame game = new TemplateGame();
        game.setDescription(descr);
        game.setListAnswer(Collections.singletonList(answer));
        game.setCountAnswer(sel2.equals("infinity") ? 0 : Integer.valueOf(sel2));
        game.setDuration(sel1.substring(0, 1));

        String minText = getMinText(descr);
        int id = userService.saveTemplateUser(game, userId);
        Template resp = new Template();
        resp.setDescription(minText);
        resp.setTemplateId(id);
        return toJson(resp);
    }



    private String getMinText(String description) {
        String minText = description;
        if (description.length() > 35) {
            minText = description.substring(0, 30) + "...";
        }
        return minText;
    }

    private String toJson(Template template) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            String value = mapper.writeValueAsString(template);
            return value;
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return null;
        }
    }

}
