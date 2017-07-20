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
import org.apache.commons.collections4.FluentIterable;
import org.apache.http.HttpRequest;
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

    public static  final String FOOTBALL = "foot";
    public static  final String BASKETBALL = "basket";
    public static  final String VOLEYBALL = "voley";



    @Autowired
    private PlaygroundService playgroundService;

    @Autowired
    private VkMessageService messageService;

 /*   @RequestMapping(value = "/sendMessage/{id}/{userId}")
    public  String sendMessageToUser(HttpServletRequest request, @PathVariable String id,  @PathVariable String userId){
        //String userId = (String) request.getSession().getAttribute(USER_ID);
        try {

        String links = playgroundService.getFootballById(id).getLinks();
        messageService.sendMessage(Integer.parseInt(userId), links);
            System.out.println("sendMessage " + links);
            System.out.println("sendMessage " + userId);
        } catch (DataBaseException e) {
            e.printStackTrace();
        }

        //return "redirect:/maps?viewer_id="+userId ;
        return "successs";
    }*/

    @RequestMapping(value = "/sendMessage")
    public @ResponseBody String sendMessageToUser( @RequestParam String idFoot,  @RequestParam String userID){
        try {
            if (userID == null || idFoot == null ) {
                return "fail";
            }
            User user = Users.getUsers().get(Integer.parseInt(userID));
            if (user.getCountSendMessage() >= 10){
                messageService.sendMessage(Integer.parseInt(userID), "Вы использовали 10 сообщений для вашего сеанса");
                return "stopMessage";
            } else {
                String links = playgroundService.getFootballById(idFoot).getLinks();
                messageService.sendMessage(Integer.parseInt(userID), links);
            }
        } catch (DataBaseException e) {
            e.printStackTrace();
        }
        return "success";
    }


    @RequestMapping(value = "/info")
    public String info(Model model, HttpServletRequest request){
        String userId = "id";
        model.addAttribute("test", userId);
        return "info";
    }

    @RequestMapping(value = "/maps")
    public String onMap(Model model, @RequestParam(value = "viewer_id", required = false) String id){
        try {
            if (id != null) {
                User user = new User();
                user.setId(Integer.parseInt(id));
                user.setCountSendMessage(0);
                Users.getUsers().put(user.getId(), user);
            } else {
                model.addAttribute("errorID", "Невозможно распознать id пользователя");

            }

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
            model.addAttribute("userId", id);

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
