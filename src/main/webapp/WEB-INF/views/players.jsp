<%--
  Created by IntelliJ IDEA.
  User: Igor
  Date: 03.04.2017
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <title>Поиск спортивной площадки</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>

        /* Set black background color, white text and some padding */

        .borderless {
            border: 0 none;

            box-shadow: none;

        }

        .round {
            border-radius: 50%;
        }
    </style>
</head>
<body>
<nav class="nav  navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand btn" id="returnBack"><span class="glyphicon glyphicon-menu-left"
                                                              aria-hidden=""></span></a>
            <a class="navbar-brand" href="#">Участники</a>
        </div>
    </div>
</nav>


<main>

    <div class="container " style="margin-top: 5px">


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="list-group" id="listGroupsUser">
                    <c:forEach var="user" items="${userList}">
                        <a href="user?playerId=${user.userId}&userId=${userId}" class="list-group-item borderless">
                            <div class="media">
                                <div class="pull-left">
                                    <img class="media-object round" src="${user.photo_50}" alt="Футбол" width="50"
                                         height="50"/>
                                </div>
                                <div class="pull-right" style="padding-top: 12px;">
                                    <c:if test="${user.countFake > 0}">
                                        +${user.countFake}
                                    </c:if>
                                </div>
                                <div class="media-body " style="padding-top: 12px;padding-left: 10px">
                                        <%--       <h4 class="media-heading"
                                                   style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">${user.firstName}</h4>--%>
                                    <span style="font-size: medium">${user.firstName} ${user.lastName} <span
                                            style="padding-left: 10px">

                                    </span></span>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>

            <div class="col-sm-2">

            </div>
        </div>
    </div>
</main>
<script src="https://vk.com/js/api/xd_connection.js?2" type="text/javascript"></script>
<script>
    var back = '${returnBack}';
    var returnBack;
    if (back === 'playground') {
        returnBack = 'playground?playgroundId=' + '${playgroundId}' + '&userId=' + ${userId};
    } else {
        returnBack = 'home?where=' + '${returnBack}' + '&userId=' + ${userId};
    }
    $('#returnBack').attr('href', returnBack);


</script>
</body>
</html>