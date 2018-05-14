<%--
  Created by IntelliJ IDEA.
  User: Igor
  Date: 10.08.2017
  Time: 20:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>SportMap</title>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <style>
        .error {
            background: no-repeat center;
            margin-top: 200px;
        }

    </style>
</head>
<body>
<main>
    <div class="container-fluid text-center">
        <div class="row content">
            <div class="text-center error">
                <p style="color: gray" id="smallError"> Произошла ошибка</p>
                <div id="bigError" class="hide">
                    <p class="hide">Произошла критическая ошибка</p>
                    <p style="color: gray" class="hide">Мы уже исправляем ошибку</p>
                </div>

                <a href="start?viewer_id=${userId}" class="btn" id="reboot">Перезагрузить приложение</a>
            </div>
        </div>
    </div>
</main>
<script>
    var userId = '${userId}';
    if (userId.length == 0) {
        $('#reboot').addClass('hide');
        $('#smallError').addClass('hide');
        $('#reboot').removeClass('hide');

    }
</script>
</body>
</html>
