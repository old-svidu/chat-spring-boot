package spring.models;

public class User {
    private String name;
    private String color;
    private String message;
    private String socketId;

    public User() {
    }

    public User(String name, String color) {
        this.name = name;
        this.color = color;
    }

    public User(String name, String color, String message, String socketId) {
        this.name = name;
        this.color = color;
        this.message = message;
        this.socketId = socketId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getSocketId() {
        return socketId;
    }

    public void setSocketId(String socketId) {
        this.socketId = socketId;
    }
}
