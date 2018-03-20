package com.realsport.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.realsport.model.entity.Template;
import com.realsport.model.entityDao.Playfootball;
import com.realsport.model.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;

@org.springframework.web.bind.annotation.RestController
public class RestController {

    @Autowired
    private UserService userService;

    @Autowired
    HttpSession httpSession;

    @RequestMapping("removeTemplate")
    public void removeTemplate(@RequestParam(value="templateId", required=false, defaultValue="World") String templateId) {
        String userId = (String)httpSession.getAttribute("userId");
        userService.removeTemplateUser(templateId, userId);
    }

    @RequestMapping(value = "saveTemplate", method = RequestMethod.POST)
    public void saveTemplate(@RequestBody String template) throws IOException {
        ObjectMapper mapper = new ObjectMapper();
        Template requesValue = mapper.readValue(template,
                Template.class);
        String userId = (String)httpSession.getAttribute("userId");
        userService.saveTemplateUser(template, userId);
    }

}
