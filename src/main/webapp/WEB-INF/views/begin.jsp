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
    <meta http-equiv="refresh" content="5; URL='start?viewer_id=${userId}'" />
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
            <p style="color: gray">Регистрация пользователя</p>
            <div  class="load" id ="loader" >
                <img src="resources/images/errorgif.gif">
            </div>
        </div>
    </div>
</main>
</body>
</html>
