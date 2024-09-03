package com.popup.project.chat.controller;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

// 기존 import 문들 유지
@Component
@ServerEndpoint("/websocketendpoint/{username}")
public class WebSocket2 {

    private static final Map<String, Session> clients = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("username") String userName) {
        System.out.println("Open session id: " + session.getId() + " for user: " + userName);

        clients.put(userName, session);

        try {
            session.getBasicRemote().sendText("Connection Established with user: " + userName);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session, @PathParam("username") String userName) {
        System.out.println("Session " + session.getId() + " has ended");
        clients.remove(userName);
    }

    @OnMessage
    public void onMessage(String message, Session session, @PathParam("username") String userName) {
        System.out.println("Message from " + userName + ": " + message);

        // 메시지가 "targetUser|message" 형식인 경우 분할
        String[] parts = message.split("\\|", 2);
        if (parts.length == 2) {
            String targetUser = parts[0];
            String msg = parts[1];

            // 특정 사용자에게 메시지 전달
            sendMessageToUser(userName, targetUser, msg);
        } else {
            try {
                session.getBasicRemote().sendText("Invalid message format. Use 'targetUser|message'.");
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    private void sendMessageToUser(String fromUser, String toUser, String message) {
        Session targetSession = clients.get(toUser);

        if (targetSession != null) {
            try {
                targetSession.getBasicRemote().sendText("From " + fromUser + ": " + message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("User not found: " + toUser);
        }
    }

    @OnError
    public void onError(Throwable e, Session session, @PathParam("username") String userName) {
        System.out.println("Error for user " + userName + ": " + e.getMessage());
    }
}
