package spring.controlles;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import spring.models.User;

import java.util.LinkedHashMap;
import java.util.Map;

@Controller
public class ServerSocketController {
    private Map<String,User> users = new LinkedHashMap<>();

    @MessageMapping("/message")
    @SendTo("/res/message")
    public User sendMessage(User user){
        return user;
    }

    @MessageMapping("/new")
    @SendTo("/res/users")
    public Map<String, User> sendUsers(User user){
        users.put(user.getSocketId(),user);
        return users;
    }

    @MessageMapping("/disc")
    @SendTo("/res/remove")
    public String sendRemainingUsers(String id){
        users.remove(id);
        return id;
    }


}
