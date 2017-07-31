package com.realsport.controller;

import com.google.gson.Gson;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.Basketball;
import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.entityDao.Voleyball;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.VkMessageService;
import com.realsport.model.utils.User;
import com.realsport.model.utils.Users;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Igor on 31.03.2017.
 */
@Controller
public class StartController {

    private List<Playfootball> playfootballList;
    private List<Voleyball> voleyballList;
    private List<Basketball> basketballList;

    public static final String FOOTBALL = "foot";
    public static final String BASKETBALL = "basket";
    public static final String VOLEYBALL = "voley";

    private static final Integer ADMIN = 172924708;

    private static final Long TIME = 3000000L;



    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private VkMessageService messageService;



    @RequestMapping(value = "/info")
    public String info(Model model, HttpServletRequest request){
        String userId = "id";
        model.addAttribute("test", userId);
        return "info";
    }

    /**
     * Возвращает представление карты Google со всеми данными
     * @param model
     * @param id
     * @return
     */
    @RequestMapping(value = "/maps")
    public String onMap(Model model, @RequestParam(value = "viewer_id", required = false) String id) throws Exception {
        try {
            if (id != null) {
                Integer idUser = Integer.parseInt(id);
                if (Users.getUsers().get(idUser) == null) {
                    User user = new User();
                    user.setId(idUser);
                    user.setCountSendMessage(0);
                    user.setDate(new Date());
                    Users.getUsers().put(user.getId(), user);
                }
                model.addAttribute("userId", id);
            } else {
                model.addAttribute("userId", "error");
                messageService.sendMessage(ADMIN, "Невозможно распознать пользователя " +  id);
            }
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
     * Возвращает изображение по id
     * @param type
     * @param id
     * @return
     */
    @RequestMapping("/images/{type}/{id}")
    public @ResponseBody byte[] getImage(@PathVariable String type, @PathVariable String id) {
        byte[] bytes = null;
        if(type.equals(FOOTBALL)) {
            bytes = playfootballList.get(Integer.parseInt(id)).getImage();
        } else if(type.equals(BASKETBALL)) {
            bytes = basketballList.get(Integer.parseInt(id)).getImage();
        } else if(type.equals(VOLEYBALL)) {
            bytes = voleyballList.get(Integer.parseInt(id)).getImage();
        }

        return bytes;
    }

    /**
     * Получение основных данных по площадкам и конвертация данных в формат JSON
     * @param voleyballList
     * @return
     */
    private ArrayList<String> getVoleyballInfoList(List<Voleyball> voleyballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
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
     * @param basketballList
     * @return
     */
    private  ArrayList<String> getBasketInfoList(List<Basketball> basketballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
        for (Basketball p : basketballList){
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
     * @param playfootballList
     * @return
     */
    private  ArrayList<String> getFootInfoList(List<Playfootball> playfootballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
        for (Playfootball p : playfootballList){
            map.put("namePlayground", p.getName());
            map.put("street", p.getStreet());
            map.put("house", p.getHouse());
            map.put("link", p.getLinks());
            map.put("creator", p.getСreator());
            map.put("id", p.getIdplayground());
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }
        return mapArrayList;
    }

    /**
     * Получение координат площадок и конвертация в JSON
     * @param list
     * @return
     */
    private  ArrayList<String> getСoordinateFootPlayground(List<Playfootball> list){
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
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
     * @param list
     * @return
     */
    private  ArrayList<String> getСoordinateBasketPlayground(List<Basketball> list){
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
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
     * @param list
     * @return
     */
    private  ArrayList<String> getСoordinateVoleyPlayground(List<Voleyball> list){
        HashMap<String, Double> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
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

    private String errorCreateMaps(String userID,  Exception e) {
        String error = "Произошла ошибка при создании карты пользователю с Id " + userID + ". Error: " + e.getMessage();
        return error;
    }

}
