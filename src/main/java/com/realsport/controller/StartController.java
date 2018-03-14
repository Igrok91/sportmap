package com.realsport.controller;

import com.google.gson.Gson;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.Basketball;
import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.entityDao.User;
import com.realsport.model.entityDao.Voleyball;
import com.realsport.model.service.AuthService;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.VkMessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

    public static final String FOOTBALL = "foot";
    public static final String BASKETBALL = "basket";
    public static final String VOLEYBALL = "voley";

    private static final Integer ADMIN = 172924708;


    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private VkMessageService messageService;

    @Autowired
    private AuthService authService;

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
                if (authService.isRegister(id)) {
                    user = authService.getUser(id);
                    setPlaygroundDataToModel(model, id);
                    setUserDataToModel(user);
                } else {
                    user = authService.registerUser(id);
                    isFirst = true;
                }

                httpSession.setAttribute("userId", id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            model.addAttribute("userId", "null");
            return "error";
        }
        return !isFirst ? "main" : "begin";
    }

    private void setUserDataToModel(User user) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        map.put("isAdmin", user.isAdmin());
        map.put("playgroundFoottUser", user.getPlaygroundFootballList());
        map.put("playgroundBasketUser", user.getPlaygrounBasketList());
        map.put("playgroundVoleyUser", user.getPlaygrounVoleyList());
        String jsonUser = gson.toJson(map);
        httpSession.setAttribute("sessionUser", jsonUser);

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
            map.put("id", p.getIdvoleyball());
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
            map.put("id", p.getIdbasketball());
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

}
