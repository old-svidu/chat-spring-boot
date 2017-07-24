<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=utf-8" %>
<html lang="en">

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js"></script>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font: 13px Helvetica, Arial;
        }

        form {
            background: #000;
            padding: 3px;
            position: fixed;
            bottom: 0;
            width: 100%;
        }

        form input {
            border: 0;
            padding: 10px;
            width: 90%;
            margin-right: .5%;
        }

        form button {
            width: 9%;
            border: none;
            padding: 10px;
        }

        #messages {
            list-style-type: none;
            position: relative;
            float: left;
            width: 50%;
        }

        #users {
            list-style-type: none;
            position: relative;
            float: right;
            width: 50%;
        }

    </style>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>

<ul id="messages">Messages</ul>
<ul id="users">Users</ul>

<form id="form" >
    <input id="text"/>
    <button id="name" hidden><c:out value="${user.name}"></c:out></button>
    <button id="color" hidden><c:out value="${user.color}"></c:out></button>
    <button id="send">Отправить</button>
</form>
</body>

<script>
    var socket = new SockJS('/socket');

    var name = document.getElementById('name').innerText;
    var color = document.getElementById('color').innerText;
    var id = Math.random().toString(36).substring(5);

    stompClient = Stomp.over(socket);
    stompClient.connect({}, function(frame) {
        $(document).ready(function () {
            stompClient.send("/req/new",{},JSON.stringify({'name' : name, 'color': color,'socketId':id}));
        });

        stompClient.subscribe('/res/message', function(data){
            var user = JSON.parse(data.body);
            var message = document.createElement('li');
            var fontMessage = document.createElement('font');
            fontMessage.setAttribute('color', user.color);
            fontMessage.textContent = user.name + " : " + user.message;
            message.appendChild(fontMessage);
            document.getElementById("messages").appendChild(message);
        });

        stompClient.subscribe('/res/users', function(data){
            var people = JSON.parse(data.body);
            for (var key in people) {
                var man = people[key];
                if (document.getElementById(key) == null) {
                    var user = document.createElement('li');
                    user.setAttribute('id', key);
                    var fontUser = document.createElement('font');
                    fontUser.setAttribute('color', man.color);
                    fontUser.textContent = man.name;
                    user.appendChild(fontUser);
                    document.getElementById("users").appendChild(user);
                }
            };
        });

        stompClient.subscribe('/res/remove', function(data){
            document.getElementById('users').removeChild(document.getElementById(data.body));
        });
    });

    document.getElementById("form").addEventListener('submit', function (event) {
        event.preventDefault();
        var elem = document.getElementById('text');
        var message = elem.value;
        stompClient.send("/req/message", {}, JSON.stringify({'name' : name, 'color': color, 'message': message }));
        elem.value="";
    });
    $(window).on("beforeunload", function() {
        stompClient.send("/req/disc",{},id);
    });
</script>

</html>