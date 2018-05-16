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
    <script src="resources/js/events.js"></script>

    <style>

        /* Set black background color, white text and some padding */
        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }

        .hrDescription {
            margin-top: 9px;
            margin-bottom: 9px;
        }

        body {
            overflow-y: scroll;
        }


    </style>
    <script type="text/javascript" src="https://vk.com/js/api/share.js?95" charset="windows-1251"></script>
</head>
<body>


<a href="" class="btn hide" style="padding: 1px" id="templateUserList2">
    <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
    <img src="" alt="Баскетбол" width="35" class="round"
         height="35" id="imageUser">
</a>


<nav class="navbar navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand" href="#">События</a>
        </div>
        <%--        <div class="pull-right" style="padding-top: 10px">
                    <span style="margin-right: 3px">Все</span>
                    <input type="checkbox" class="checkbox-switch"/>
                </div>--%>
    </div>
</nav>
<div class="container-fluid ">

    <div class="row content">
        <div class="col-sm-2">

        </div>
        <div class="col-sm-8" style="padding-bottom: 45px">
            <c:choose>
                <c:when test="${listEvents.size() == 0}">
                    <div class="text-center">
                        <span style="color: gray">Нет событий</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="list-group">
                        <c:forEach var="event" items="${listEvents}">


                            <div class="panel " id="${event.idEvent}">
                                <div class="panel-heading" style="padding-bottom: 3px; padding-top: 6px">

                                    <div>
                                        <a class="pull-left"
                                           href="playground?playgroundId=${event.playgroundId}&sport=${event.sport}&userId=${userId}">
                                            <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                            <img id="${event.idEvent}_imgPlayground"
                                                 src="resources/image/playbasket.png"
                                                 alt="Баскетбол" width="40" height="40">
                                        </a>


                                        <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                                            <a class="btn  dropdown-toggle" data-toggle="dropdown"
                                               id="dropdownMenu5"> <span
                                                    class="glyphicon glyphicon-option-vertical"></span></a>
                                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu5">
                                                <c:choose>
                                                    <c:when test="${event.userIdCreator == userId}">
                                                        <c:set var="playgroundId" value="${event.playgroundId}"/>
                                                        <c:set var="sport" value="${event.sport}"/>
                                                        <li class="liOptions"><a
                                                                onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playerId=${userId}'), ${event.userList.size()}, '${user.photo_50}'"
                                                                id="cancelAnswer_${event.idEvent}"
                                                                class="cursorPointer"> <span
                                                                class="glyphicon glyphicon-minus "
                                                                style="margin-right: 20px"></span>Отменить голос</a>
                                                        </li>
                                                        <li class="liOptions"><a
                                                                onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playerId=${userId}', ${event.userList.size()}, '${user.photo_50}')"
                                                                id="doAnswer_${event.idEvent}"
                                                                class="cursorPointer"> <span
                                                                class="glyphicon glyphicon-plus "
                                                                style="margin-right: 20px"></span>Проголосовать</a>
                                                        </li>
                                                        <%--     <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span
                                                                     class="glyphicon glyphicon-time"
                                                                     style="margin-right: 20px"></span>История
                                                                 изменений</a></li>--%>
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


                                                        <li class="liOptions"><a
                                                                href="create?playgroundId=${playgroundId}&sport=${sport}&eventId=${event.idEvent}&userId=${userId}">
                                                    <span class="glyphicon glyphicon-pencil"
                                                          style="margin-right: 20px"></span>Редактировать
                                                        </a></li>
                                                        <li class="liOptions"><a
                                                                href="endGame?playgroundId=${playgroundId}&eventId=${event.idEvent}&userId=${userId}"><span
                                                                class="glyphicon glyphicon-off"
                                                                style="margin-right: 20px"></span>Завершить
                                                            опрос</a></li>
                                                        <li class="liOptions"><a
                                                                href="deleteGame?playgroundId=${playgroundId}&eventId=${event.idEvent}&userId=${userId}"><span
                                                                class="glyphicon glyphicon-trash"
                                                                style="margin-right: 20px"></span>Удалить
                                                            опрос</a></li>

                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="playgroundId" value="${event.playgroundId}"/>
                                                        <c:set var="sport" value="${event.sport}"/>
                                                        <li class="liOptions"><a
                                                                onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playerId=${userId}', ${event.userList.size()}, '${user.photo_50}')"
                                                                id="cancelAnswer2_${event.idEvent}"
                                                                class="cursorPointer"> <span
                                                                class="glyphicon glyphicon-minus"
                                                                style="margin-right: 20px"></span>Отменить голос</a>
                                                        </li>
                                                        <li class="liOptions"><a
                                                                onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playerId=${userId}', ${event.userList.size()}, '${user.photo_50}')"
                                                                id="doAnswer2_${event.idEvent}"
                                                                class="cursorPointer"> <span
                                                                class="glyphicon glyphicon-plus"
                                                                style="margin-right: 20px"></span>Проголосовать</a>
                                                        </li>
                                                        <%--    <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span class="glyphicon glyphicon-time"
                                                                                                                                    style="margin-right: 20px"></span>История
                                                                изменений</a></li>--%>
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
                                    <div style="padding-bottom: 20px">
                                        <a class="pull-left"
                                           href="user?playerId=${event.userIdCreator}&userId=${userId}">
                                            <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                            <img id="${event.idEvent}_imgPlayground" class="media-object round"
                                                 src="${event.userCreatorPhoto}"
                                                 alt="Баскетбол" width="50" height="50">

                                        </a>
                                        <div class="media-body" style="padding-top: 6px">
                                            <a href="user?playerId=${event.userIdCreator}&userId=${userId}"
                                               style="margin-left: 3px;"
                                               class="btn"> ${event.userFirtsNameCreator} ${event.userLastNameCreator}
                                            </a>
                                        </div>

                                    </div>
                                        <%--<hr style="margin-bottom: 9px; margin-top: 0px">--%>
                                    <div style="padding-bottom: 12px;">
                                        <span style="color: black;" id="descrEvent_${event.idEvent}"></span>
                                    </div>
                                        <%--<hr class="hrDescription">--%>
                                    <div class="alert alert-danger fade in hide" role="alert"
                                         id="alertMax_${event.idEvent}">
                                        <button type="button" class="close" onclick="hideButton(${event.idEvent})"
                                                aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                        <strong>Warning!</strong> Превышен лимит игроков
                                    </div>

                                    <div class="list-group" style="margin-bottom: 5px">
                                        <button class="list-group-item "
                                                onclick="handleAnswer(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playerId=${userId}', ${event.userList.size()}, '${user.photo_50}', 'answerButton_${event.idEvent}')"
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
                                        </button>
                                    </div>

                                    <div class="btn-group " style="margin-top: 7px">
                                        <div class="container-fluid">
                                            <div class="row" id="imgUserList_${event.idEvent}">
                                                <c:forEach var="user" items="${event.userList}">
                                                    <c:choose>
                                                        <c:when test="${user.isFake() == true}">
                                                            <a href="user?playerId=${user.userId}&userId=${userId}"
                                                               class="btn" style="padding: 2px 0px;"
                                                               id="${user.userId}_imgUser_${event.idEvent}_fake">
                                                                <span id="${user.userId}_add_${event.idEvent}"
                                                                      count="${user.countFake}">+${user.countFake}</span>
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="user?playerId=${user.userId}&userId=${userId}"
                                                               class="btn" style="padding: 2px 0px"
                                                               id="${user.userId}_imgUser_${event.idEvent}">
                                                                <img src="${user.photo_50}" alt="Баскетбол" width="35"
                                                                     class="round media-object "
                                                                     height="35"
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
                                   style=" margin-left: 5px;margin-top: 5px; margin-bottom: 5px"
                                   id="commentEvents"><span
                                        class="glyphicon glyphicon-comment " aria-hidden="Комментировать"
                                        style="color: #77A5C5;margin-right: 5px"></span>
                                    <span id="countComment_${event.idEvent}" style="font-size: medium">
                                        <c:if test="${event.commentsList.size() > 0}">
                                            ${event.commentsList.size()}
                                        </c:if>
                                    </span>
                                </a>
                                <span class="btn">

                                    <script type="text/javascript">
                                    document.write(VK.Share.button({url: "https://vk.com/app6437488_-148660655#${event.idEvent}"}, {
                                        type: "custom",
                                        text: "<span><span class=\"glyphicon glyphicon-bullhorn \" style=\"color: #77A5C5;margin-right: 5px\"></span> Поделиться</span>"
                                    }));
                                  </script>

                                </span>


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
                                                    <%-- <option>6</option>
                                                     <option>7</option>
                                                     <option>8</option>
                                                     <option>9</option>
                                                     <option>10</option>--%>
                                            </select>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть
                                            </button>
                                            <button id="addIgrok_${event.idEvent}"
                                                    onclick="addIgrok(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'playerId=${userId}', ${event.userList.size()}, 'addIgrok_${event.idEvent}')"
                                                    class="btn btn-primary">Добавить
                                            </button>
                                        </div>
                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal-dialog -->
                            </div>
                            <!-- /.modal -->

                            <!-- Modal -->
                            <div class="modal fade" id="historyChange_${event.idEvent}" tabindex="-1" role="dialog"
                                 aria-labelledby="historyChangeLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">

                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                            <h5 class="modal-title" id="historyChangeLabel">История изменений</h5>
                                        </div>
                                        <div class="modal-body">

                                            <div class="list-group">
                                                <c:forEach var="history" items="${event.historyEvent}">
                                                    <a href="user?playerId=${history.userId}&userId=${userId}"
                                                       class="list-group-item borderless">
                                                        <div class="media">
                                                            <div class="pull-left">
                                                                <img class="media-object" src="resources/image/foot.png"
                                                                     alt="Футбол" width="40"
                                                                     height="40"/>
                                                            </div>


                                                            <div class="media-body ">
                                                                <p style="margin-bottom: 0px; padding-bottom: 0px; padding-top: 2px">${history.firstName} ${history.lastName} ${history.action}</p>
                                                                <span style="color: gray">${history.date}</span>
                                                                <hr style="margin-top: 0px; margin-bottom: 0px">
                                                            </div>
                                                        </div>
                                                    </a>
                                                </c:forEach>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>

                    </div>
                </c:otherwise>
            </c:choose>


        </div>

    </div>
    <div class="col-sm-2">

    </div>
</div>


<script>
    var listEvents = ${listEventsJson};
    var eventsId = {};
    var maxWatch = 2;
    console.log(listEvents.length);
    var userId = "${userId}";
    if (listEvents) {
        listEvents.forEach(function (event, i) {
            var maxCountAnswer = event.maxCountAnswer;
            var usersList = event.userList;
            var sp = event.sport;
            var id = event.idEvent;
            console.log("idEvent " + id);
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
            eventsId[id] = id;
            var description = event.description.split('\n');
            $('#descrEvent_' + id).html('');
            description.forEach(function (message, i) {
                $('#descrEvent_' + id).append(message);
                $('#descrEvent_' + id).append('<br>');
            });

            if (usersList.length > maxWatch) {
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

                if (count >= event.maxCountAnswer) {
                    $('#answerButton_' + id).addClass('disabled')
                } else {
                    $('#answerButton_' + id).removeClass('disabled');
                }
            }


            var isActive = false;
            var isFakePresent = false;
            usersList.forEach(function (user, i) {
                if (user.userId === userId) {
                    if (user.isFake === true) {
                        isFakePresent = true;

                    }
                    isActive = true;
                }

                if (i > maxWatch) {
                    if (user.isFake === true) {
                        $('#' + user.userId + '_imgUser_' + id + '_fake').addClass('hide');
                    } else {
                        $('#' + user.userId + '_imgUser_' + id).addClass('hide');
                    }
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
                if (isFakePresent) {
                    var answerButton = document.getElementById("answerButton_" + id);
                    answerButton.setAttribute('disabled', 'disabled');
                }
            } else {
                $('#answerButton_' + id).addClass('active');
                $('#answerButton_' + id).css('background', '');
                $('#answerOk_' + id).addClass('hide');
                $('#cancelAnswer_' + id).addClass('hide');
                $('#doAnswer_' + id).removeClass('hide');
                $('#cancelAnswer2_' + id).addClass('hide');
                $('#doAnswer2_' + id).removeClass('hide');
            }


        });

    }


    var dateNow = new Date().getTime();

    function updateData() {


        $.ajax({
            url: 'getNewDataEvents',
            method: 'POST',
            data: ({date: dateNow, eventsId: JSON.stringify(eventsId), userId: userId})
        }).then(function (value) {


            if (value) {
                console.log("data edit");
                dateNow = new Date().getTime();

                value.forEach(function (event, i) {
                    var isWatch = false;
                    var eventId = event.idEvent;
                    var usersList = event.userList;
                    var commentList = event.commentsList;
                    if (commentList.length > 0) {
                        $('#countComment_' + eventId).text(commentList.length);
                    }
                    if (usersList.length > maxWatch) {
                        isWatch = true;
                        $('#watch_' + eventId).removeClass('hide');
                    }
                    if (event.isEditEvent) {
                        location.reload();
                    }

                    if (event.maxCountAnswer == 1000) {
                        var count = usersList.length;
                        if (!isWatch) {
                            $('#imgUserList_' + eventId).empty();
                        }
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
                                    var img = document.getElementById('imageUser');
                                    img.src = user.photo_50;
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
                        if (!isWatch) {
                            $('#imgUserList_' + eventId).empty();
                        }

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
                                    var img = document.getElementById('imageUser');
                                    img.src = user.photo_50;
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
                });
            }
        });
    }

    function hideButton(eventId) {
        $('#alertMax_' + eventId).addClass('hide');

    }

    function shareEvent(eventId) {
        VK.callMethod("shareBox", 'http://vk.com/share.php?url=https://vk.com/app6437488_-148660655#eventId=' + eventId, '', 'Присоединяйся к игре');
    }

    setInterval(updateData, 5000);

</script>
</body>
</html>