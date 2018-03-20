package com.realsport.controller;

import com.google.gson.Gson;
import com.realsport.model.dao.daoException.DataBaseException;
import com.realsport.model.entityDao.*;
import com.realsport.model.service.UserService;
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

    public static final String FOOTBALL = "football";
    public static final String BASKETBALL = "basketball";
    public static final String VOLEYBALL = "voleyball";

    private static final Integer ADMIN = 172924708;


    @Autowired
    private PlaygroundService playgroundService;

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
                    setUserDataToModel(user);
                } else {
                    user = userService.registerUser(id);
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
        model.addAttribute("playgroundCoordinate", "empty");
        return !isFirst ? "main" : "begin";
    }

    private void setUserDataToModel(User user) {
        HashMap<String, Object> map = new HashMap<>();
        Gson gson = new Gson();
        ArrayList<String> mapArrayList = new ArrayList<>();
        map.put("isAdmin", user.isAdmin());
        map.put("playgroundFoottUser", user.getPlaygroundFootballList());
        map.put("playgroundBasketUser", user.getPlaygroundBasketList());
        map.put("playgroundVoleyUser", user.getPlaygroundVoleyList());
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

    @RequestMapping("/groupFromMap")
    public String toGroup(Model model, @RequestParam(value="playgroundId", required=false, defaultValue="5") String id, @RequestParam(value="sport", required=false, defaultValue=FOOTBALL) String sport) {
        if (sport.equalsIgnoreCase(FOOTBALL)) {
            for (Playfootball playfootball : playfootballList) {
                if (playfootball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", playfootball.getName() );
                    model.addAttribute("street", playfootball.getStreet() );
                    model.addAttribute("house", playfootball.getHouse() );
                    model.addAttribute("sport", playfootball.getSubject() );
                    model.addAttribute("players", playgroundService.getFootballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getFootballPlayById(id) );
                }
            }
        } else if (sport.equalsIgnoreCase(BASKETBALL)) {
            for (Basketball basketball : basketballList) {
                if (basketball.getIdbasketball() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", basketball.getName() );
                    model.addAttribute("street", basketball.getStreet() );
                    model.addAttribute("house", basketball.getHouse() );
                    model.addAttribute("sport", basketball.getSubject() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getBasketballPlayById(id) );
                }
            }
        } else if (sport.equalsIgnoreCase(VOLEYBALL)) {
            for (Voleyball voleyball : voleyballList) {
                if (voleyball.getIdvoleyball() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", voleyball.getName() );
                    model.addAttribute("street", voleyball.getStreet() );
                    model.addAttribute("house", voleyball.getHouse() );
                    model.addAttribute("sport", voleyball.getSubject() );
                    model.addAttribute("players", playgroundService.getVoleyPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getVoleyPlayById(id) );
                }
            }
        }

        model.addAttribute("returnBack", "map");
        model.addAttribute("playgroundId", id);
        return "playground";
    }

    @RequestMapping("/group")
    public String toGroupUser(Model model, @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport) {

        if (sport.equals("Футбол")) {
            for (Playfootball playfootball : playfootballList) {
                if (playfootball.getIdplayground() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", playfootball.getName() );
                    model.addAttribute("street", playfootball.getStreet() );
                    model.addAttribute("house", playfootball.getHouse() );
                    model.addAttribute("sport", playfootball.getSubject() );
                    model.addAttribute("players", playgroundService.getFootballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getFootballPlayById(id) );
                }
            }
        } else if (sport.equals("Баскетбол")) {
            for (Basketball basketball : basketballList) {
                if (basketball.getIdbasketball() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", basketball.getName() );
                    model.addAttribute("street", basketball.getStreet() );
                    model.addAttribute("house", basketball.getHouse() );
                    model.addAttribute("sport", basketball.getSubject() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getBasketballPlayById(id) );
                }
            }
        } else if (sport.equals("Волейбол")) {
            for (Voleyball voleyball : voleyballList) {
                if (voleyball.getIdvoleyball() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", voleyball.getName() );
                    model.addAttribute("street", voleyball.getStreet() );
                    model.addAttribute("house", voleyball.getHouse() );
                    model.addAttribute("sport", voleyball.getSubject() );
                    model.addAttribute("players", playgroundService.getVoleyPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getVoleyPlayById(id) );
                }
            }
        }

        model.addAttribute("returnBack", "group");
        model.addAttribute("playgroundId", id);
        return "playground";
    }

    @RequestMapping("/create")
    public String toCreate(Model model, @RequestParam(value="playgroundId") String id, @RequestParam(value="sport") String sport) {
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
                if (basketball.getIdbasketball() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", basketball.getName() );
                    model.addAttribute("playId", basketball.getIdbasketball() );
                    model.addAttribute("street", basketball.getStreet() );
                    model.addAttribute("house", basketball.getHouse() );
                    model.addAttribute("sport", basketball.getSubject() );
                    model.addAttribute("players", playgroundService.getBasketballPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getBasketballPlayById(id) );
                }
            }
        } else if (sport.equals("Волейбол")) {
            for (Voleyball voleyball : voleyballList) {
                if (voleyball.getIdvoleyball() == Integer.parseInt(id)) {
                    model.addAttribute("namePlayground", voleyball.getName() );
                    model.addAttribute("playId", voleyball.getIdvoleyball() );
                    model.addAttribute("street", voleyball.getStreet() );
                    model.addAttribute("house", voleyball.getHouse() );
                    model.addAttribute("sport", voleyball.getSubject() );
                    model.addAttribute("players", playgroundService.getVoleyPlayersById(id) );
                    model.addAttribute("plays", playgroundService.getVoleyPlayById(id) );
                }
            }
        }
        String userId = (String)httpSession.getAttribute("userId");
        List<TemplateGame> list = userService.getTemplatesUserById(userId);
        ArrayList<String> userTemplates = new ArrayList<>();
        if (list != null) {
            userTemplates = getUserTemplates(list);
        }

        model.addAttribute("returnBack", "home");
        model.addAttribute("templates", userTemplates);
        model.addAttribute("playgroundId", id);
        return "create";
    }

    @RequestMapping(value = "/home")
    public String toHome(Model model, @RequestParam(value="where", required = false) String where, @RequestParam(value="playgroundId", required = false) String id, @RequestParam(value="sport", required = false) String sport ) {
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
                    if (p.getIdbasketball() == Integer.parseInt(id)) {
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
                    if (p.getIdvoleyball() == Integer.parseInt(id)) {
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
        return "main";
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
            map.put("id", p.getIdvoleyball());
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
            map.put("id", p.getIdbasketball());
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
