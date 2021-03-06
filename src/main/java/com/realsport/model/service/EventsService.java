package com.realsport.model.service;

import com.google.common.base.Function;
import com.google.common.base.Predicate;
import com.google.common.collect.FluentIterable;
import com.realsport.model.dao.DatastoreService;
import com.realsport.model.entityDao.Comment;
import com.realsport.model.entityDao.Event;
import com.realsport.model.entityDao.EventUser;
import com.realsport.model.entityDao.MinUser;
import com.realsport.model.entityDao.User;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;

@Service
public class EventsService {
    private Log logger = LogFactory.getLog(EventsService.class);

    @Autowired
    private DatastoreService databaseService;

    public void publishEvent(Event game) {
        databaseService.publishEvent(game);
    }

    public List<Event> getEvents(List<String> playgroundUser) {
        List<Event> eventOfGroupUser = new ArrayList<>();
        // Достаем из бд активные события.
        if (playgroundUser.size() != 0) {
            List<Event> allActiveEventList = databaseService.getAllEvents();


            if (allActiveEventList.size() != 0) {
                for (String id : playgroundUser) {
                    List<Event> event = FluentIterable.from(allActiveEventList).filter(new Predicate<Event>() {
                        @Override
                        public boolean apply(Event event) {
                            return event.getPlaygroundId().equals(id);
                        }
                    }).toList();
                    if (Objects.nonNull(event)) {
                        eventOfGroupUser.addAll(event);
                    }
                }
            }
            sortEvents(eventOfGroupUser);
        }

        return eventOfGroupUser;
    }

    private List<User> sortUserListEvents(List<User> userList) {
        List<User> list = new ArrayList<>();
        if (userList.size() > 0) {
            List<User> listWithFake = FluentIterable.from(userList).filter(new Predicate<User>() {
                @Override
                public boolean apply(User u) {
                    return u.isFake();
                }
            }).toList();

            List<User> listWithOutFake = FluentIterable.from(userList).filter(new Predicate<User>() {
                @Override
                public boolean apply(User u) {
                    return !u.isFake();
                }
            }).toList();
            for (User us : listWithOutFake) {
                list.add(us);
                User fake = FluentIterable.from(listWithFake).firstMatch(new Predicate<User>() {
                    @Override
                    public boolean apply(User user) {
                        return user.getUserId().equals(us.getUserId());
                    }
                }).orNull();
                if (Objects.nonNull(fake)) {
                    list.add(fake);
                }
            }
        }
        return list;
    }

    public Event getEventById(String eventId) {
        Event event = databaseService.getEventById(eventId);
        List<User> userList = event.getUserList();
        event.setUserList(sortUserListEvents(userList));
        return event;
    }

    public void editEventById(String eventId, String description, int maxCountAnswer, String duration) {
        databaseService.editEventById(eventId, description, maxCountAnswer, duration);
    }

    public void deleteGame(String eventId) {
        databaseService.deleteGame(eventId);
    }

    public void deleteUserFromEvent(String eventId, String userId) {
        databaseService.deleteUserFromEvent(eventId, userId);
    }

    public String addCommentToEvent(String eventId, Comment message) {
        return databaseService.addCommentToEvent(eventId, message);
    }

    public void deleteCommentFromEvent(String commentId, String eventId) {
        databaseService.deleteCommentFromEvent(commentId, eventId);
    }


    public void endGame(String eventId) {
        databaseService.endGame(eventId);
    }

    public List<Event> getEventsByIdGroup(String id) {
        List<Event> list = databaseService.getEventsByIdGroup(id);
        sortEvents(list);
        return list;

    }

    private void sortEvents(List<Event> list) {
        Comparator<Event> comparator = new Comparator<Event>() {
            @Override
            public int compare(Event o1, Event o2) {
                Timestamp t1 = o1.getDateCreation().toSqlTimestamp();
                Timestamp t2 = o2.getDateCreation().toSqlTimestamp();
                return t2.compareTo(t1);
            }
        };
        for (Event e : list) {
            List<User> userList = e.getUserList();
            e.setUserList(sortUserListEvents(userList));
        }
        Collections.sort(list, comparator);
    }

    public void addUserToEvent(String eventId, User user, boolean isFake) {
        databaseService.addUserToEvent(eventId, user, isFake);
    }

    public Event createEventByTemplate(String templateId, String id) {
        return databaseService.createEventByTemplate(templateId, id);
    }

    public List<MinUser> getUserListEvent(List<User> userList) {
        List<MinUser> minUserList = new ArrayList<>();
        List<MinUser> withoutFake = FluentIterable.from(userList).filter(new Predicate<User>() {
            @Override
            public boolean apply(User user) {
                return !user.isFake();
            }
        }).transform(new Function<User, MinUser>() {
            @Override
            public MinUser apply(User user) {
                MinUser minUser = new MinUser();
                minUser.setUserId(user.getUserId());
                minUser.setFirstName(user.getFirstName());
                minUser.setLastName(user.getLastName());
                minUser.setPhoto_50(user.getPhoto_50());
                return minUser;
            }
        }).toList();
        minUserList.addAll(withoutFake);
        for (MinUser u : minUserList) {
            User user = FluentIterable.from(userList).firstMatch(new Predicate<User>() {
                @Override
                public boolean apply(User user) {
                    return user.getUserId().equals(u.getUserId()) && user.isFake();
                }
            }).orNull();
            if (Objects.nonNull(user)) {
                u.setCountFake(user.getCountFake());
            }
        }
        return minUserList;
    }

    public List<Event> getActiveEventsByIdGroup(String playgroundId) {
        List<Event> list = databaseService.getActiveEventsByIdGroup(playgroundId);
        sortEvents(list);
        return list;
    }

    public List<Event> getEventUserParticipantOrOrganize(List<EventUser> listParticipant) {
        List<Event> events = databaseService.getEventUserParticipantorOrganize(listParticipant);
        sortEvents(events);

        return events;
    }
}
