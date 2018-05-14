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

        textarea {
            resize: none;
        }

        .liOptions {
            margin-bottom: 2px;
            margin-top: 2px;
        }

        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }

        .round {
            border-radius: 50%;
        }


    </style>
</head>
<body id="eventBody">
<nav class="nav navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand btn" id="returnBack"><span class="glyphicon glyphicon-menu-left"
                                                              aria-hidden=""></span></a>
        </div>

    </div>
</nav>
<main>

    <div class="container-fluid " style="margin-top: 15px">

        <div class="row content">
            <div class="col-sm-2">
            </div>
            <div class="col-sm-8">
                <div class="list-group">
                    <c:forEach var="event" items="${listEvents}">


                        <div class="panel " id="${event.idEvent}">
                            <div class="panel-heading" style="padding-bottom: 3px; padding-top: 6px">

                                <div>
                                    <a class="pull-left"
                                       href="playground?playgroundId=${event.playgroundId}&sport=${event.sport}&userId=${userId}">
                                        <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                        <img id="${event.idEvent}_imgPlayground" class="media-object"
                                             src="resources/image/playbasket.png"
                                             alt="Баскетбол" width="40" height="40">
                                    </a>


                                    <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                                        <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu5"> <span
                                                class="glyphicon glyphicon-option-vertical"></span></a>
                                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu5">
                                            <c:choose>
                                                <c:when test="${event.userIdCreator == userId}">
                                                    <c:set var="playgroundId" value="${event.playgroundId}"/>
                                                    <c:set var="sport" value="${event.sport}"/>
                                                    <li class="liOptions"><a
                                                            href="playground?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}"> <span
                                                            class="glyphicon glyphicon-home"
                                                            style="margin-right: 20px"></span>К группе</a>
                                                    </li>
                                                    <li class="liOptions"><a
                                                            href="event?eventId=${event.idEvent}&userId=${userId}"> <span
                                                            class="glyphicon glyphicon-share-alt"
                                                            style="margin-right: 20px"></span>К записи</a>
                                                    </li>


                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="playgroundId" value="${event.playgroundId}"/>
                                                    <c:set var="sport" value="${event.sport}"/>

                                                    <li class="liOptions"><a
                                                            href="playground?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}">
                                                        <span class="glyphicon glyphicon-home"
                                                              style="margin-right: 20px"></span>К группе</a>
                                                    </li>
                                                    <li class="liOptions"><a
                                                            href="event?eventId=${event.idEvent}&userId=${userId}">
                                                        <span class="glyphicon glyphicon-share-alt"
                                                              style="margin-right: 20px"></span>К записи</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>

                                        </ul>
                                    </div>
                                    <div class="media-body" style="padding-left: 10px">

                                        <h4 class="media-heading"
                                            style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">${event.playgroundName}</h4>


                                        <span style="color: gray">${event.date}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body" style="padding-bottom: 0px">
                                <div style="padding-bottom: 12px">
                                    <a class="pull-left" href="user?playerId=${event.userIdCreator}&userId=${userId}">
                                        <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                        <img id="${event.idEvent}_imgPlayground" class="media-object round"
                                             src="${event.userCreatorPhoto}"
                                             alt="Баскетбол" width="40" height="40">

                                    </a>
                                    <div class="media-body">
                                        <a href="user?playerId=${event.userIdCreator}&userId=${userId}"
                                           style="margin-left: 3px;"
                                           class="btn"> ${event.userFirtsNameCreator} ${event.userLastNameCreator}
                                        </a>
                                    </div>

                                </div>
                                <div style="padding-bottom: 12px;">
                                    <span style="color: black;" id="descrEvent_${event.idEvent}"></span>
                                </div>


                                <div class="list-group" style="margin-bottom: 5px">
                                    <a class="list-group-item disabled"
                                       onclick="handleAnswer(${event.maxCountAnswer}, ${event.idEvent}, ${userId})"
                                       id="answerButton_${event.idEvent}">
                                        <c:choose>
                                            <c:when test="${event.maxCountAnswer == 1000}">
                                                <span class="badge"
                                                      id="badge1_${event.idEvent}">${event.userList.size()}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge"
                                                      id="badge2_${event.idEvent}">${event.userList.size()} / ${event.maxCountAnswer} </span>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="pull-left hide" id="answerOk_${event.idEvent}">
                                            <span class="glyphicon glyphicon-ok "></span>
                                        </div>
                                        <div class="text-center">
                                            +
                                        </div>
                                    </a>
                                </div>

                                <div class="btn-group " style="margin-top: 5px">
                                    <div class="container-fluid">
                                        <div class="row" id="imgUserList_${event.idEvent}">
                                            <c:forEach var="user" items="${event.userList}">
                                                <c:choose>
                                                    <c:when test="${user.isFake() == true}">
                                                        <a href="user?playerId=${user.userId}&userId=${userId}"
                                                           class="btn" style="padding: 0px"
                                                           id="${user.userId}_imgUser_${event.idEvent}_fake">
                                                            <span id="${user.userId}_add_${event.idEvent}"
                                                                  count="${user.countFake}">+${user.countFake}</span>

                                                        </a>

                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="user?playerId=${user.userId}&userId=${userId}"
                                                           class="btn" style="padding: 0px"
                                                           id="${user.userId}_imgUser_${event.idEvent}">
                                                            <img src="${user.photo_50}" alt="Баскетбол" width="35"
                                                                 class="round"
                                                                 height="35" id="${user.userId}_img_${event.idEvent}">
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>

                                            </c:forEach>
                                            <a href="toPlayers?eventId=${event.idEvent}&userId=${userId}"
                                               id="watch_${event.idEvent}" class="btn hide"> <span
                                                    class="glyphicon glyphicon-eye-open"
                                                    style="margin-right: 5px"></span></a>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a href="#" class="btn disabled"
                               style=" margin-left: 5px;margin-top: 4px; margin-bottom: 4px" id="commentEvents"><span
                                    class="glyphicon glyphicon-comment " aria-hidden="Комментировать"
                                    style="color: #77A5C5;margin-right: 5px"></span>
                                <span id="countComment_${event.idEvent}" style="font-size: medium">
                                        <c:if test="${event.commentsList.size() > 0}">
                                            ${event.commentsList.size()}
                                        </c:if>
                                    </span>
                            </a>
                        </div>

                    </c:forEach>

                </div>
                <c:if test="${listSize >=  2}">
                    <c:if test="${listSize >  endList}">
                        <c:choose>
                            <c:when test="${parameter == 'userParticipant'}">
                                <div class="text-center" style="padding-bottom: 10px">
                                    <a href="userParticipant?where=profile&playerId=${playerId}&userId=${userId}&endList=${endList}"
                                       class="btn">Загрузить еще</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center" style="padding-bottom: 10px">
                                    <a href="userOrganize?where=profile&playerId=${playerId}&userId=${userId}&endList=${endList}"
                                       class="btn">Загрузить еще</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:if>
                </c:if>
            </div>
            <div class="col-sm-2">
            </div>
        </div>
    </div>
    </div>

</main>
<script src="https://vk.com/js/api/xd_connection.js?2" type="text/javascript"></script>
<script>

    var back = '${where}';
    var returnBack;
    if (back === 'profile') {
        returnBack = 'user?userId=${userId}&playerId=${playerId}';
    } else if (back === 'profileMain') {
        returnBack = 'home?&userId=${userId}&where=profileMain';
    }

    $('#returnBack').attr('href', returnBack);


    var listEvents = ${listEventsJson};
    var isWatch = false;
    if (listEvents) {
        var userId = "${userId}";
        listEvents.forEach(function (event, i) {
            var maxCountAnswer = event.maxCountAnswer;
            var usersList = event.userList;
            var sp = event.sport;
            var id = event.idEvent;
            var element = document.getElementById(id);
            var imgPlayground = document.getElementById(id + '_imgPlayground');
            if (sp == 'Футбол') {
                element.className = 'panel panel-success';
                imgPlayground.src = "resources/image/стадион.png";
            } else if (sp == 'Баскетбол') {
                element.className = 'panel panel-warning';
                imgPlayground.src = "resources/image/playbasket.png";
            } else if (sp == 'Волейбол') {
                element.className = 'panel panel-info';
                imgPlayground.src = "resources/image/сетка.png";
            }
            var description = event.description.split('\n');
            $('#descrEvent_' + id).html('');
            description.forEach(function (message, i) {
                $('#descrEvent_' + id).append(message);
                $('#descrEvent_' + id).append('<br>');
            });

            if (usersList.length > 2) {
                isWatch = true;
                $('#watch_' + id).removeClass('hide');
            }
            // Определяем истинное значение игроков
            if (maxCountAnswer == 1000) {
                var count = parseInt($('#badge1_' + id).text());
                if (usersList) {
                    usersList.forEach(function (user, i) {
                        if (user.countFake != 0) {
                            count = (count - 1) + user.countFake;
                            // isFake = true;
                        }
                    });
                }

                $('#badge1_' + id).text(count);
            } else {
                var count = parseInt($('#badge2_' + id).text().split(' / ')[0]);
                if (usersList) {
                    usersList.forEach(function (user, i) {
                        if (user.countFake != 0) {
                            count = (count - 1) + user.countFake;
                            // isFake = true;
                        }
                    });
                }

                $('#badge2_' + id).text(count + ' / ' + maxCountAnswer);

            }


            var isActive = false;
            usersList.forEach(function (user, i) {
                if (user.userId === userId) {
                    isActive = true;
                }
            });

            if (isActive) {
                $('#answerButton_' + id).removeClass('active');
                $('#answerButton_' + id).css('background', '#EAEAEC');

                $('#answerOk_' + id).removeClass('hide');

            } else {
                $('#answerButton_' + id).addClass('active');
                $('#answerButton_' + id).css('background', '');
                $('#answerOk_' + id).addClass('hide');
            }
        });

    }

    function resizeEvent() {
        var height = $('#eventBody').height();
        if (height < 650) {
            VK.callMethod('resizeWindow', 900, 650);
        } else {
            VK.callMethod('resizeWindow', 900, height + 10);
        }
    }

    setTimeout('resizeEvent()', 300);
</script>
</body>
</html>