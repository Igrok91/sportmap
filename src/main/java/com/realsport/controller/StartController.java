package com.realsport.controller;

import com.google.gson.Gson;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.Basketball;
import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.entityDao.Voleyball;
import com.realsport.model.service.PlaygroundService;
import com.realsport.model.service.VkMessageService;
import com.realsport.model.utils.Users;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Igor on 31.03.2017.
 */
@Controller
public class StartController {

    public static final String USER_ID = "user_id";

    @Autowired
    HttpSession session;

    private List<Playfootball> playfootballList;
    private List<Voleyball> voleyballList;
    private List<Basketball> basketballList;

    public static  final String FOOTBALL = "foot";
    public static  final String BASKETBALL = "basket";
    public static  final String VOLEYBALL = "voley";


    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private VkMessageService messageService;

    @RequestMapping(value = "/sendMessage/${id}")
    public String sendMessageToUser(HttpServletRequest request, @PathVariable String id){
        try {
        Integer userId = (Integer) request.getSession().getAttribute(USER_ID);
        String links = playgroundService.getFootballById(id).getLinks();
        messageService.sendMessage(userId, links);
            System.out.println("sendMessage" + links);
            System.out.println("sendMessage" + userId);
        } catch (DataBaseException e) {
            e.printStackTrace();
        }

        return "maps";
    }

    @RequestMapping(value = "/info")
    public String info(Model model){

        return "info";
    }

    @RequestMapping(value = "/maps")
    public String onMap(Model model, @RequestParam(value = "viewer_id", required = false) String id){
        try {
            session.setAttribute(USER_ID, id);
            Users.getUsers().add(Integer.parseInt(id));

            voleyballList = playgroundService.getVoleyballPlayground();
            playfootballList = playgroundService.getFootballPlayground();
            basketballList = playgroundService.getBasketballPlayground();

            ArrayList<String> footLocationList = getFootPlayground(playfootballList);
            ArrayList<String> basketLocationList = getBasketPlayground(basketballList);
            ArrayList<String> voleyLocationList = getVoleyPlayground(voleyballList);

            ArrayList<String> footInfoList = getFootInfoList(playfootballList);
            ArrayList<String> basketInfoList = getBasketInfoList(basketballList);
            ArrayList<String> voleyballInfoList = getVoleyballInfoList(voleyballList);

            model.addAttribute("footLocation", footLocationList);
            model.addAttribute("basketLocation", basketLocationList);
            model.addAttribute("voleyLocation", voleyLocationList);

            model.addAttribute("footInfo", footInfoList);
            model.addAttribute("basketInfo", basketInfoList);
            model.addAttribute("voleyballInfo", voleyballInfoList);

        } catch (DataBaseException e) {
            e.printStackTrace();
        }

        return "maps";
    }

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


    private static ArrayList<String> getVoleyballInfoList(List<Voleyball> voleyballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
        for (Voleyball p : voleyballList) {
            map.put("namePlayground", p.getName());
            map.put("house", p.getHouse());
            map.put("link", p.getLinks());
            map.put("creator", p.getСreator());
            map.put("id", p.getIdvoleyball());
            String json = gson.toJson(map);
            mapArrayList.add(json);

        }
        return mapArrayList;
    }

    private static ArrayList<String> getBasketInfoList(List<Basketball> basketballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
        for (Basketball p : basketballList){
            map.put("namePlayground", p.getName());
            map.put("house", p.getHouse());
            map.put("link", p.getLinks());
            map.put("creator", p.getСreator());
            map.put("id", p.getIdbasketball());
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }

        return mapArrayList;
    }


    private static ArrayList<String> getFootInfoList(List<Playfootball> playfootballList) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList= new ArrayList<>();
        for (Playfootball p : playfootballList){
            map.put("namePlayground", p.getName());
            map.put("house", p.getHouse());
            map.put("link", p.getLinks());
            map.put("creator", p.getСreator());
            map.put("id", p.getIdplayground());
            String json = gson.toJson(map);
            mapArrayList.add(json);
        }
        return mapArrayList;
    }


    private static ArrayList<String> getFootPlayground(List<Playfootball> list){
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

    private static ArrayList<String> getBasketPlayground(List<Basketball> list){
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

    private static ArrayList<String> getVoleyPlayground(List<Voleyball> list){
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

}
