package com.popup.project.chat.controller;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;

@Controller
public class chatcontroller {

    @RequestMapping("/chatLogin")
    public String chatLoginPage(Model model) {
        return "chatLogin";
    }

    @RequestMapping("/client")
    public String clientPage(Model model) {
        return "client";
    }
    @RequestMapping("/chatRoom")
    public String chatRoom(Model model) {
        return "chatRoom";
    }

    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }
}
