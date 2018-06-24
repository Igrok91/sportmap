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
    <script src="resources/js/xd_connection.js" type="text/javascript"></script>
    <script src="resources/js/device.js"></script>
    <style>

        /* Set black background color, white text and some padding */

        .borderless {
            border: 0 none;

        }

        hr {
            margin-top: 5px;
            margin-bottom: 0px;
        }

    </style>
</head>
<body id="bodyGroups">

<nav class="nav navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand btn" id="returnBack"><span class="glyphicon glyphicon-menu-left"
                                                              aria-hidden=""></span></a>
        </div>

    </div>
</nav>
<main>

    <div class="container-fluid ">


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <c:choose>
                    <c:when test="${allPlaygroundUser.size() == 0}">
                        <div class="text-center" style="padding-top: 20px">
                            <span style="color: gray">У вас пока нет групп <br> Чтобы вступить в группу перейдите в посик <span
                                    class="glyphicon glyphicon-search" aria-hidden=""></span></span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="list-group" id="listGroupsUser" style="padding-top: 7px">
                            <c:forEach var="group" items="${allPlaygroundUser}">
                                <a href="group?playgroundId=${group.idplayground}&sport=${group.getSport()}&userId=${userId}"
                                   class="list-group-item borderless">
                                    <div class="media">
                                        <div class="pull-left">
                                            <c:if test="${group.getSport() == 'Футбол'}">
                                                <img class="media-object" src="resources/image/стадион3.png"
                                                     alt="Футбол" width="50"
                                                     height="50"/>
                                            </c:if>
                                            <c:if test="${group.getSport() == 'Баскетбол'}">
                                                <img class="media-object" src="resources/image/площадка2.png"
                                                     alt="Баскетбол" width="50"
                                                     height="50"/>
                                            </c:if>
                                            <c:if test="${group.getSport() == 'Волейбол'}">
                                                <img class="media-object" src="resources/image/спортивная-сетка.png"
                                                     alt="Волейбол" width="50"
                                                     height="50"/>
                                            </c:if>

                                        </div>


                                        <div class="media-body ">
                                            <h4 class="media-heading"
                                                style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">${group.getName()}</h4>
                                            <span style="color: gray">${group.getSport()}</span>
                                            <hr>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>


            </div>


            <div class="col-sm-8">

            </div>

        </div>
    </div>

</main>
<script>

    var back = '${where}';
    var returnBack;
    if (back === 'profile') {
        returnBack = 'user?userId=${userId}&playerId=${playerId}';
    } else if (back === 'profileMain') {
        returnBack = 'home?&userId=' + ${userId} +'&where=profileMain';
    }

    $('#returnBack').attr('href', returnBack);

    function resizeGroups() {
        if (device.desktop()) {
            var height = $('#bodyGroups').height();
            if (height < 650) {
                VK.callMethod('resizeWindow', 900, 650);
            } else {
                VK.callMethod('resizeWindow', 900, height + 10);
            }
        }
    }

    setTimeout('resizeGroups()', 300);


</script>
</body>
</html>