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
    <script src="resources/js/events.js"></script>
    <style>

        /* Set black background color, white text and some padding */

        .hrDescription {
            margin-top: 9px;
            margin-bottom: 9px;
        }

        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }

        .borderless {
            border: 0 none;

            box-shadow: none;

        }
    </style>
</head>
<body>
<nav class="nav  navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand btn" id="returnBack"><span class="glyphicon glyphicon-menu-left"
                                                              aria-hidden=""></span></a>
        </div>
    </div>
</nav>
<a href="" class="btn hide" style="padding: 0px" id="templateUserList2">
    <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
    <img src="resources/image/foot.png" alt="Баскетбол" width="30"
         height="30" id="imageUser">
</a>
<a href="toUser?userId=${userId}" class="list-group-item borderless hide" id="list_template">
    <div class="media">
        <div class="pull-left">
            <img class="media-object" src="resources/image/стадион3.png" alt="Футбол" width="40"
                 height="40"/>
        </div>


        <div class="media-body " style="padding-top: 10px; padding-left: 3px">
            <%--       <h4 class="media-heading"
                       style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">${user.firstName}</h4>--%>
            <span>${firstName} ${lastName}</span>
            <%--<hr>--%>
        </div>
    </div>
</a>
<main id="mainPlayground">

    <div class="container-fluid" style="margin-top: 15px">


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="panel " id="panelGroup">
                    <div class="panel-heading ">
                        <div>
                            <a class="pull-left" href="#">
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                <img class="media-object" src="resources/image/playbasket.png" alt="Баскетбол"
                                     width="40" height="40" id="imageGroup">
                            </a>


                            <div class="media-body" style="padding-left: 10px">

                                <h4 class="media-heading"
                                    style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">
                                    ${namePlayground}</h4>


                                <span style="color: gray">${sport}</span>

                            </div>

                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="text-center">
                                    <c:choose>
                                        <c:when test="${isParticipant == true}">
                                            <a onclick="handleGroup()" id="exitFromGroup" class="btn btn-default"
                                               style="margin:3px;background: #EAEAEC">Выйти из группы</a>
                                            <a onclick="handleGroup()" id="enterToGroup" class="btn btn-primary hide"
                                               style="margin:3px">Вступить в группу</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a onclick="handleGroup()" id="exitFromGroup" class="btn btn-default hide"
                                               style="margin:3px;background: #EAEAEC">Выйти из группы</a>
                                            <a onclick="handleGroup()" id="enterToGroup" class="btn btn-primary "
                                               style="margin:3px">Вступить в группу</a>
                                        </c:otherwise>
                                    </c:choose>

                                    <a href="create?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}"
                                       class="btn btn-primary" id="goGame"
                                       style="margin:3px">Позвать на игру</a>
                                </div>


                            </div>
                        </div>


                        <h5><span class="glyphicon glyphicon-info-sign"></span> Информация</h5>
                        <div>
                            <div style="padding-bottom: 2px">
                                <span style="color: gray;">Aдрес: ${street}, ${house} </span>

                            </div>
                        </div>

                    </div>
                    <div class="list-group">
                        <c:choose>
                            <c:when test="${players.size() == 0}">
                                <a class="list-group-item ">
                                     <span class="badge" style="background: #ffffff"><span style="color: gray"
                                                                                           id="players"><c:out
                                             value="${players.size()}"/></span> </span>
                                    Участники
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="list-group-item "
                                   href="toPlayersGroups?playgroundId=${playgroundId}&userId=${userId}">
                                     <span class="badge" style="background: #ffffff"><span style="color: gray"
                                                                                           id="players"><c:out
                                             value="${players.size()}"/></span> <span
                                             class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
                                    Участники
                                </a>
                            </c:otherwise>
                        </c:choose>


                    </div>
                    <%--               <div class="container-fluid">
                                       <div class="row text-center" >
                                           <a href="#" class="btn" style=" margin-left: 5px;margin-top: 4px; margin-bottom: 4px"><span class="glyphicon  glyphicon-share-alt"  aria-hidden="Комментировать" style="margin-right: 5px"></span> Пригласить в группу</a>
                                           <!--   <a href="#" class="btn " ><span class="glyphicon glyphicon-th-list"></span> Рейтинг</a> -->
                                       </div>
                                   </div>--%>
                </div>
                <c:choose>
                    <c:when test="${listSize == 0}">
                        <div class="panel  panel-default">
                            <div class="panel-heading ">Нет записей</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="event" items="${listEvents}" varStatus="status">

                            <div class="panel panel-default">
                                <c:if test="${status.first}">
                                    <div class="panel-heading" style="background: #EAEAEC">
                            <span class=" badge pull-right" style="background: #EAEAEC"><span style="color: gray"><c:out
                                    value="${listSize}"/></span> <span class="glyphicon glyphicon-menu-down"
                                                                                style="color: gray"></span></span>
                                        События

                                    </div>
                                    <hr style="padding-top: 0px; margin-top: 0px; padding-bottom: 0px;margin-bottom: 0px">
                                </c:if>
                                <div style="background: white;padding-left: 15px;padding-top: 15px">
                                    <div class="text-center hide" style="color: gray; padding-bottom: 10px;"
                                         id="past_${event.idEvent}">
                                        <span>Завершено <span class="glyphicon glyphicon-eye-close"></span></span>
                                    </div>
                                    <a class="pull-left" href="user?playerId=${event.userIdCreator}&userId=${userId}">
                                        <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                        <img id="${event.idEvent}_imgPlayground" class="media-object"
                                             src="resources/image/foot2.png"
                                             alt="Баскетбол" width="35" height="35">
                                    </a>
                                    <div class="pull-right dropdown"
                                         style=" margin-top: 4px;margin-bottom: 4px; padding-right: 10px">
                                        <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu5"> <span
                                                class="glyphicon glyphicon-option-vertical"></span></a>
                                        <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu5">
                                            <c:choose>
                                                <c:when test="${event.userIdCreator == userId}">
                                                    <c:set var="playgroundId" value="${event.playgroundId}"/>
                                                    <c:set var="sport" value="${event.sport}"/>
                                                    <li>
                                                        <a onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playgroundId=${playgroundId}&playerId=${userId}', ${event.userList.size()})"
                                                           id="cancelAnswer_${event.idEvent}"> <span
                                                                class="glyphicon glyphicon-minus"
                                                                style="margin-right: 20px"></span>Отменить голос</a>
                                                    </li>
                                                    <li>
                                                        <a onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playgroundId=${playgroundId}&playerId=${userId}', ${event.userList.size()})"
                                                           id="doAnswer_${event.idEvent}"> <span
                                                                class="glyphicon glyphicon-plus"
                                                                style="margin-right: 20px"></span>Проголосовать</a>
                                                    </li>
                                                    <%--     <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span
                                                                 class="glyphicon glyphicon-time"
                                                                 style="margin-right: 20px"></span>История
                                                             изменений</a></li>--%>
                                                    <li>
                                                        <a href="event?eventId=${event.idEvent}&userId=${userId}"> <span
                                                                class="glyphicon glyphicon-share-alt"
                                                                style="margin-right: 20px"></span>К записи</a>
                                                    </li>


                                                    <li>
                                                        <a href="create?playgroundId=${playgroundId}&sport=${sport}&eventId=${event.idEvent}&userId=${userId}"
                                                           id="editEvent_${event.idEvent}">
                                                    <span class="glyphicon glyphicon-pencil"
                                                          style="margin-right: 20px"></span>Редактировать
                                                        </a></li>
                                                    <li>
                                                        <a href="endGame?playgroundId=${playgroundId}&eventId=${event.idEvent}&userId=${userId}&where=playground"
                                                           id="endEvent_${event.idEvent}"><span
                                                                class="glyphicon glyphicon-off"
                                                                style="margin-right: 20px"></span>Завершить
                                                            опрос</a></li>
                                                    <li>
                                                        <a href="deleteGame?playgroundId=${playgroundId}&eventId=${event.idEvent}&userId=${userId}&where=playground"><span
                                                                class="glyphicon glyphicon-trash"
                                                                style="margin-right: 20px"></span>Удалить
                                                            опрос</a></li>

                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="playgroundId" value="${event.playgroundId}"/>
                                                    <c:set var="sport" value="${event.sport}"/>
                                                    <li>
                                                        <a onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playgroundId=${playgroundId}&playerId=${userId}', ${event.userList.size()})"
                                                           id="cancelAnswer2_${event.idEvent}"> <span
                                                                class="glyphicon glyphicon-minus"
                                                                style="margin-right: 20px"></span>Отменить голос</a>
                                                    </li>
                                                    <li>
                                                        <a onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playgroundId=${playgroundId}&playerId=${userId}', ${event.userList.size()})"
                                                           id="doAnswer2_${event.idEvent}"> <span
                                                                class="glyphicon glyphicon-plus"
                                                                style="margin-right: 20px"></span>Проголосовать</a>
                                                    </li>
                                                    <%--    <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span class="glyphicon glyphicon-time"
                                                                                                                                style="margin-right: 20px"></span>История
                                                            изменений</a></li>--%>
                                                    <li>
                                                        <a href="event?eventId=${event.idEvent}&userId=${userId}"> <span
                                                                class="glyphicon glyphicon-share-alt"
                                                                style="margin-right: 20px"></span>К записи</a>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>

                                        </ul>
                                    </div>
                                    <div class="media-body" style="padding-left: 10px">

                                        <h5 class="media-heading"
                                            style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">${event.userFirtsNameCreator} ${event.userLastNameCreator} </h5>


                                        <span style="color: gray">${event.date} </span>

                                    </div>
                                </div>

                                <div class="panel-body" style="padding-bottom: 0px">
                                    <div style="padding-bottom: 12px">
                                        <span style="color: black;" id="descrEvent_${event.idEvent}"></span>
                                    </div>

                                    <div class="alert alert-danger fade in hide" role="alert"
                                         id="alertMax_${event.idEvent}">
                                        <button type="button" class="close" onclick="hideButton(${event.idEvent})"
                                                aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <strong>Warning!</strong> Превышен лимит игроков
                                    </div>

                                    <div class="alert alert-danger fade in hide" role="alert"
                                         id="alertFail_${event.idEvent}">
                                        <button type="button" class="close" onclick="hideButton(${event.idEvent})"
                                                aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <strong>Warning!</strong> Произошла ошибка
                                    </div>
                                    <div class="list-group" style="margin-bottom: 5px">
                                        <a class="list-group-item "
                                           onclick="handleAnswer(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playgroundId=${playgroundId}&playerId=${userId}', ${event.userList.size()})"
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
                                                            <a href="user?playerId=${user.userId}&playgroundId=${playgroundId}&userId=${userId}"
                                                               class="btn"
                                                               style="padding: 0px"
                                                               id="${user.userId}_imgUser_${event.idEvent}_fake">
                                                    <span id="${user.userId}_add_${event.idEvent}"
                                                          count="${user.countFake}">+${user.countFake}</span>

                                                            </a>

                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="user?playerId=${user.userId}&playgroundId=${playgroundId}&userId=${userId}"
                                                               class="btn"
                                                               style="padding: 0px"
                                                               id="${user.userId}_imgUser_${event.idEvent}">
                                                                <img src="resources/image/foot.png" alt="Баскетбол"
                                                                     width="30"
                                                                     height="30"
                                                                     id="${user.userId}_img_${event.idEvent}">
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
                                <a href="event?eventId=${event.idEvent}&userId=${userId}&where=comment" class="btn"
                                   style="margin-left: 5px;margin-top: 4px; margin-bottom: 4px"
                                   id="commentEvents_${event.idEvent}"><span
                                        class="glyphicon glyphicon-comment " aria-hidden="Комментировать"
                                        style="color: #77A5C5;margin-right: 5px"></span>
                                    <span id="countComment_${event.idEvent}" style="font-size: medium">
                                        <c:if test="${event.commentsList.size() > 0}">
                                            ${event.commentsList.size()}
                                        </c:if>
                                    </span>
                                </a>
                                <a href="#" class="btn"
                                   style=" margin-left: 5px; margin-left: 5px; margin-top: 4px;margin-bottom: 4px"
                                   id="share_${event.idEvent}"><span
                                        class="glyphicon glyphicon-bullhorn " aria-hidden="Комментировать"
                                        style="color: #77A5C5;margin-right: 5px"></span>Поделиться</a>


                            </div>

                            <div class="modal fade" id="addIgrok_${event.idEvent}">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                                &times;
                                            </button>
                                            <h4 class="modal-title">Добавить еще от меня</h4>
                                        </div>
                                        <div class="modal-body">
                                            <select class="form-control borderless" id="countIgrok_${event.idEvent}"
                                                    name="sel1">
                                                <option>1</option>
                                                <option>2</option>
                                                <option>3</option>
                                                <option>4</option>
                                                <option>5</option>
                                            </select>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть
                                            </button>
                                            <a onclick="addIgrok(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playgroundId=${playgroundId}&playerId=${userId}', ${event.userList.size()})"
                                               class="btn btn-primary">Добавить</a>
                                        </div>
                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->

                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <c:if test="${listSize >=  2}">
                    <c:if test="${listSize >  endList}">
                        <div class="text-center" style="padding-bottom: 10px">
                            <a href="playground?playgroundId=${playgroundId}&userId=${userId}&endList=${endList}"
                               class="btn">Загрузить еще</a>
                        </div>
                    </c:if>
                </c:if>

                <div class="col-sm-2">

                </div>

            </div>
        </div>
    </div>
</main>

<script src="https://vk.com/js/api/xd_connection.js?2" type="text/javascript"></script>
<script>
    var listEvents = ${listEventsJson};

    console.log(listEvents.length);
    if (listEvents) {
        var userId = "${userId}";
        listEvents.forEach(function (event, i) {
            var maxCountAnswer = event.maxCountAnswer;
            var usersList = event.userList;
            var id = event.idEvent;
            var activeEvent = event.active;
            console.log("idEvent " + id);

            var description = event.description.split('\n');
            $('#descrEvent_' + id).html('');
            description.forEach(function (message, i) {

                $('#descrEvent_' + id).append(message);
                $('#descrEvent_' + id).append('<br>');
            });

            if (usersList.length > 2) {
                $('#watch_' + id).removeClass('hide');
            }


            // Определяем истинное значение игроков
            if (maxCountAnswer == 1000) {
                var count = parseInt($('#badge1_' + id).text());
                console.log("badge1 " + $('#badge1_' + id).text())
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
                console.log("badge2 " + $('#badge2_' + id).text());
                if (usersList) {
                    usersList.forEach(function (user, i) {
                        if (user.countFake != 0) {
                            count = (count - 1) + user.countFake;
                            // isFake = true;
                        }
                    });
                }

                $('#badge2_' + id).text(count + ' / ' + maxCountAnswer);

                if (count >= event.maxCountAnswer) {
                    $('#answerButton_' + id).addClass('disabled')
                } else {
                    $('#answerButton_' + id).removeClass('disabled');
                }
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
                $('#cancelAnswer_' + id).removeClass('hide');
                $('#doAnswer_' + id).addClass('hide');
                $('#cancelAnswer2_' + id).removeClass('hide');
                $('#doAnswer2_' + id).addClass('hide');
            } else {
                $('#answerButton_' + id).addClass('active');
                $('#answerButton_' + id).css('background', '');
                $('#answerOk_' + id).addClass('hide');
                $('#cancelAnswer_' + id).addClass('hide');
                $('#doAnswer_' + id).removeClass('hide');
                $('#cancelAnswer2_' + id).addClass('hide');
                $('#doAnswer2_' + id).removeClass('hide');
            }

            if (activeEvent === false) {
                disabledEventPast(id);
            }

        });

    }

    var sp = '${sport}';
    if (sp == 'Футбол') {
        $('#panelGroup').addClass('panel-success');
        $('#imageGroup').attr("src", "resources/image/стадион.png")
    } else if (sp == 'Баскетбол') {
        $('#panelGroup').addClass('panel-warning');
        $('#imageGroup').attr("src", "resources/image/playbasket.png")
    } else if (sp == 'Волейбол') {
        $('#panelGroup').addClass('panel-info');
        $('#imageGroup').attr("src", "resources/image/сетка.png")
    }
    var returnBack = 'home?where=' + '${returnBack}' + '&playgroundId=' + '${playgroundId}' + '&sport=' + sp + '&userId=' + ${userId};
    $('#returnBack').attr('href', returnBack);

    function handleGroup() {
        var playgroundId = '${playgroundId}';
        var sport = '${sport}';
        $.ajax({
            url: 'handleGroup?playgroundId=' + playgroundId + '&sport=' + sport + '&userId=' + ${userId}
        }).then(function (value) {
            var userId = '${userId}';
            if (value == true) {
                $('#exitFromGroup').removeClass('hide');
                $('#enterToGroup').addClass('hide');
                $('#goGame').removeClass("disabled");

                var count2 = parseInt($('#players').text());
                count2 = count2 + 1;
                $('#players').text(count2);
                /*
                  $('#list_template').removeClass('hide');

                  var userData = document.getElementById("list_template").cloneNode(true);
                  userData.id = "list_" + userId;
                  $('#list_template').addClass('hide');
                  $('#listGroupsUser').append(userData)*/
            } else {
                $('#exitFromGroup').addClass('hide');
                $('#enterToGroup').removeClass('hide');
                $('#goGame').addClass("disabled");

                var count2 = parseInt($('#players').text());
                count2 = count2 - 1;
                $('#players').text(count2);
                //    $('#list_' + userId).remove();
            }
        });
    }

    setTimeout('resizePlayground()', 500);

    function resizePlayground() {
        var height = $('#mainPlayground').height();
        if (height < 650) {
            VK.callMethod('resizeWindow', 900, 650);
        } else {
            VK.callMethod('resizeWindow', 900, height + 60);
        }
    }

    var isParticipant = ${isParticipant};
    if (isParticipant === false) {
        $('#goGame').addClass("disabled");
    }


    var dateNow = new Date().getTime();

    function updateData() {
        console.log("observer");
        $.ajax({
            url: 'getNewDataEventsPlayground?date=' + dateNow + '&userId=' + ${userId} +'&playgroundId=' + ${playgroundId}
        }).then(function (value) {
            console.log("success");

            if (value) {
                console.log("data edit");
                dateNow = new Date().getTime();
                console.log("value.length " + value.length)
                console.log("listEvents.length " + listEvents.length)


                value.forEach(function (event, i) {
                    var isWatch = false;
                    var eventId = event.idEvent;
                    var usersList = event.userList;
                    var commentList = event.commentsList;
                    var element = document.getElementById(eventId);
                    if (element) {
                        if (commentList.length > 0) {
                            $('#countComment_' + eventId).text(commentList.length);
                        }
                        if (usersList.length > 2) {
                            isWatch = true;
                            // $('#watch_' + eventId).removeClass('hide');
                        }

                        if (event.maxCountAnswer == 1000) {
                            var count = usersList.length;
                            $('#imgUserList_' + eventId).empty();
                            $('#templateUserList2').removeClass('hide');
                            usersList.forEach(function (user, i) {
                                // Если фейк
                                if (user.countFake != 0) {
                                    count = (count - 1) + user.countFake;
                                    if (!isWatch) {
                                        $('#imageUser').addClass('hide');
                                        var userImg = document.getElementById("templateUserList2").cloneNode(true);
                                        var addIgr = user.countFake;
                                        userImg.id = user.userId + '_imgUser_' + eventId + '_fake';
                                        userImg.href = "user?playerId=" + user.userId + "&userId=${userId}";
                                        var span = document.createElement('span');
                                        span.id = user.userId + '_add_' + eventId;
                                        span.setAttribute('count', addIgr);
                                        span.appendChild(document.createTextNode("+" + addIgr));
                                        userImg.appendChild(span);
                                        $('#imgUserList_' + eventId).append(userImg);
                                        $('#imageUser').removeClass('hide');
                                    }
                                } else {
                                    if (!isWatch) {
                                        var userImg = document.getElementById("templateUserList2").cloneNode(true);
                                        userImg.id = user.userId + '_imgUser_' + eventId;
                                        userImg.href = "user?playerId=" + user.userId + "&userId=${userId}";
                                        $('#imgUserList_' + eventId).append(userImg);
                                    }
                                }

                            });
                            $('#templateUserList2').addClass('hide');
                            $('#badge1_' + eventId).text(count);
                        } else {
                            var count = usersList.length;

                            $('#imgUserList_' + eventId).empty();
                            $('#templateUserList2').removeClass('hide');
                            usersList.forEach(function (user, i) {
                                if (user.countFake != 0) {
                                    count = (count - 1) + user.countFake;
                                    if (!isWatch) {
                                        $('#imageUser').addClass('hide');
                                        var userImg = document.getElementById("templateUserList2").cloneNode(true);
                                        var addIgr = user.countFake;
                                        userImg.id = user.userId + '_imgUser_' + eventId;
                                        userImg.href = "user?playerId=" + user.userId + "&userId=${userId}";
                                        var span = document.createElement('span');
                                        span.id = user.userId + '_add_' + eventId;
                                        span.setAttribute('count', addIgr);
                                        span.appendChild(document.createTextNode("+" + addIgr));
                                        userImg.appendChild(span);
                                        $('#imgUserList_' + eventId).append(userImg);
                                        $('#imageUser').removeClass('hide');
                                    }
                                } else {
                                    if (!isWatch) {
                                        var userImg = document.getElementById("templateUserList2").cloneNode(true);
                                        userImg.id = user.userId + '_imgUser_' + eventId;
                                        userImg.href = "user?playerId=" + user.userId + "&userId=${userId}";
                                        $('#imgUserList_' + eventId).append(userImg);
                                    }
                                }
                            });
                            $('#templateUserList2').addClass('hide');

                            if (count >= event.maxCountAnswer) {
                                $('#answerButton_' + eventId).addClass('disabled')
                            } else {
                                $('#answerButton_' + eventId).removeClass('disabled');
                            }
                            $('#badge2_' + eventId).text(count + ' / ' + event.maxCountAnswer);
                        }
                    }
                });
            }

        });
    }

    function hideButton(eventId) {
        $('#alertMax_' + eventId).addClass('hide');
        $('#alertFail_' + eventId).addClass('hide');

    }

    function disabledEventPast(id) {
        $('#past_' + id).removeClass('hide');
        $('#doAnswer2_' + id).addClass('hide');
        $('#doAnswer_' + id).addClass('hide');
        $('#cancelAnswer2_' + id).addClass('hide');
        $('#cancelAnswer_' + id).addClass('hide');
        $('#editEvent_' + id).addClass('hide');
        $('#endEvent_' + id).addClass('hide');
        $('#share_' + id).addClass('hide');

        $('#answerButton_' + id).addClass('disabled');
        $('#commentEvents_' + id).addClass('disabled');
    }


    setInterval(updateData, 5000);
</script>
</body>
</html>