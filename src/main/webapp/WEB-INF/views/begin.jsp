<%--
  Created by IntelliJ IDEA.
  User: Igor
  Date: 10.08.2017
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>SportMap</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        .load {
            background: no-repeat center;
            margin-top: 200px;
        }

    </style>
</head>
<body>
<main>
    <div class="container-fluid text-center">
        <div class="row content">
            <div class="load">
                <p style="color: gray" id="error" class="hide">Произошла ошибка</p>
                <div   id ="loader" >
                    <img src="resources/images/errorgif.gif">
                </div>
            </div>

        </div>
    </div>
</main>
<script src="https://vk.com/js/api/xd_connection.js?2"  type="text/javascript"></script>
<script>
    var userId = '${userId}';
    VK.init(function() {
        VK.api("users.get", {"user_ids": "${userId}","fields": "photo_50", "v":"5.74"}, function (data) {

            var user = data.response[0];
            console.log('user ' + user);
            if (user) {
                console.log('Регистрация ' + user);
                registerUser(user.first_name, user.last_name, user.photo_50);
            } else {
                $('#error').removeClass('hide');
                $('#loader').addClass('hide');
            }
        });

    }, function() {
        // API initialization failed
        // Can reload page here
        $('#error').removeClass('hide');
        $('#loader').addClass('hide');
    }, '5.74');

    function registerUser(first_name, last_name, photo_50) {
        $.ajax({
            url: 'registerUser',
            method: "POST",
            data: ({first_name: first_name, last_name: last_name, photo_50: photo_50, userId: userId}),
        }).then(function () {
            setTimeout('replace()', 3000);
        });
    }

    function replace() {
        var replace = "start?viewer_id=" + userId;
        var hash = '${hash}';
        if (hash) {
            replace = "start?viewer_id=" + userId + "&hash=" + hash;
        }
        location.replace(replace);
    }
</script>
</body>
</html>
