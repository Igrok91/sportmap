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
    <script src="resources/js/events.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="resources\js\device.js"></script>
    <script src="resources/js/xd_connection.js" type="text/javascript"></script>
    <script src="resources\js\media.js"></script>
    <style>
        .borderless {
            border: 0 none;
            box-shadow: none;
        }
        .liOptions {
            margin-bottom: 2px;
            margin-top: 2px;
        }
        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }
        textarea {
            resize: none;
        }
        .round {
            border-radius: 50%;
        }

        .cursorPointer {
            cursor: pointer;
        }
    </style>
    <script type="text/javascript" src="resources/js/share.js" charset="windows-1251"></script>
</head>
<body id="eventMain">
<header>
    <div id="vk_ads_105219"></div>
</header>
<a href="" class="btn hide" style="padding: 2px" id="templateUserList2">
    <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
    <img src="" alt="Баскетбол" width="35" class="round"
         height="35" id="imageUser">
</a>

<li class="list-group-item hide" style="padding-bottom: 1px;padding-top: 5px" id="templateComment">
    <div class="media">
        <a class="pull-left" href=""
           style="margin-top: 5px" id="templateCommentLink">
            <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="35" height="35"> -->
            <img class="media-object round" src="" alt="user" id="templateCommentId"
                 width="35" height="35">
        </a>
        <a onclick="" class="btn pull-right hide" id="deleteComment" style="padding: 0px;background: white"> <span
                class="glyphicon glyphicon-remove "></span></a>
        <div class="media-body ">
            <h5 class="media-heading"
                style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px;" id="templateCommentName"></h5>
            <span style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 2px" id="templateCommentMessage"></span>
            <span style="color: gray" id="templateCommentDate"></span>
        </div>
    </div>
</li>

<nav class="nav navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand btn" href="home?&userId=${userId}"><span class="glyphicon glyphicon-menu-left"
                                                                            aria-hidden=""></span></a>
            <a class="navbar-brand" href="#">Событие</a>
        </div>

    </div>
</nav>
<main>
    <div class="container-fluid " style="margin-top: 15px">

        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="panel " id="${event.idEvent}">
                    <div class="panel-heading" style="padding-bottom: 3px; padding-top: 6px">

                        <div>
                            <a class="pull-left"
                               href="playground?playgroundId=${event.playgroundId}&sport=${event.sport}&userId=${userId}">
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                <img id="${event.idEvent}_imgPlayground" class="media-object"
                                     src="resources/image/стадион.png"
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
                                                    onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'eventId=${event.idEvent}&playerId=${userId}', ${event.userList.size()}, '${user.photo_50}')"
                                                    id="cancelAnswer_${event.idEvent}" class="cursorPointer"> <span
                                                    class="glyphicon glyphicon-minus"
                                                    style="margin-right: 20px"></span>Отменить голос</a>
                                            </li>
                                            <li class="liOptions"><a
                                                    onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'eventId=${event.idEvent}&playerId=${userId}', ${event.userList.size()}, '${user.photo_50}')"
                                                    id="doAnswer_${event.idEvent}" class="cursorPointer"> <span
                                                    class="glyphicon glyphicon-plus"
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
                                                    href="create?playgroundId=${playgroundId}&sport=${sport}&eventId=${event.idEvent}&userId=${userId}"
                                                    id="editEvent_${event.idEvent}">
                                                    <span class="glyphicon glyphicon-pencil"
                                                          style="margin-right: 20px"></span>Редактировать
                                            </a></li>
                                            <li class="liOptions"><a
                                                    href="endGame?playgroundId=${playgroundId}&eventId=${event.idEvent}&userId=${userId}"
                                                    id="endEvent_${event.idEvent}"><span class="glyphicon glyphicon-off"
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
                                                    onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'eventId=${event.idEvent}&playerId=${userId}', ${event.userList.size()}, '${user.photo_50}')"
                                                    id="cancelAnswer2_${event.idEvent}" class="cursorPointer"> <span
                                                    class="glyphicon glyphicon-minus"
                                                    style="margin-right: 20px"></span>Отменить голос</a>
                                            </li>
                                            <li class="liOptions"><a
                                                    onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'eventId=${event.idEvent}&playerId=${userId}', ${event.userList.size()}, '${user.photo_50}')"
                                                    id="doAnswer2_${event.idEvent}" class="cursorPointer"> <span
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
                               href="user?playerId=${event.userIdCreator}&eventId=${event.idEvent}&userId=${userId}">
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                <img id="${event.idEvent}_imgPlayground" class="media-object round"
                                     src="${event.userCreatorPhoto}"
                                     alt="Баскетбол" width="50" height="50">

                            </a>
                            <div class="media-body" style="padding-top: 6px">
                                <a href="user?playerId=${event.userIdCreator}&userId=${userId}&eventId=${event.idEvent}"
                                   style="margin-left: 3px;"
                                   class="btn"> ${event.userFirtsNameCreator} ${event.userLastNameCreator}
                                </a>
                            </div>

                        </div>
                        <div style="padding-bottom: 12px">
                            <span style="color: black" id="descrEvent_${event.idEvent}"></span>
                        </div>
                        <div class="alert alert-danger fade in hide" role="alert" id="alertMax_${event.idEvent}">
                            <button type="button" class="close" onclick="hideButton(${event.idEvent})"
                                    aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>Warning!</strong> Превышен лимит игроков
                        </div>

                        <div class="alert alert-danger fade in hide" role="alert" id="alertFail_${event.idEvent}">
                            <button type="button" class="close" onclick="hideButton(${event.idEvent})"
                                    aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>Warning!</strong> Произошла ошибка
                        </div>

                        <div class="list-group" style="margin-bottom: 5px">
                            <button class="list-group-item "
                                    onclick="handleAnswer(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'eventId=${event.idEvent}&playerId=${userId}', ${event.userList.size()}, '${user.photo_50}', 'answerButton_${event.idEvent}')"
                                    id="answerButton_${event.idEvent}">
                                <c:choose>
                                    <c:when test="${event.maxCountAnswer == 1000}">
                                        <span class="badge" id="badge1_${event.idEvent}">${event.userList.size()}</span>
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
                                    <c:forEach var="userFromList" items="${event.userList}">
                                        <c:choose>
                                            <c:when test="${userFromList.isFake() == true}">
                                                <a href="user?playerId=${userFromList.userId}&eventId=${event.idEvent}&userId=${userId}"
                                                   class="btn" style="padding: 2px 0px"
                                                   id="${userFromList.userId}_imgUser_${event.idEvent}_fake">
                                                    <span id="${userFromList.userId}_add_${event.idEvent}"
                                                          count="${userFromList.countFake}">+${userFromList.countFake}</span>

                                                </a>

                                            </c:when>
                                            <c:otherwise>
                                                <a href="user?playerId=${userFromList.userId}&eventId=${event.idEvent}&userId=${userId}"
                                                   class="btn" style="padding:2px 0px"
                                                   id="${userFromList.userId}_imgUser_${event.idEvent}">
                                                    <img src="${userFromList.photo_50}" alt="Баскетбол" width="35"
                                                         class="round"
                                                         height="35" id="${userFromList.userId}_img_${event.idEvent}">
                                                </a>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>
                                    <a href="toPlayers?eventId=${event.idEvent}&userId=${userId}"
                                       id="watch_${event.idEvent}" class="btn hide"> <span
                                            class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span></a>

                                </div>

                            </div>


                        </div>

                    </div>

                    <hr style="margin-bottom: 0px">
                    <span class="btn" style="margin: 5px" id="share_${event.idEvent}">
                        <script type="text/javascript">
                            document.write(VK.Share.button({url: "https://vk.com/app6600445_172924708#${event.idEvent}"}, {
                                type: "custom",
                                text: "<span><span class=\"glyphicon glyphicon-bullhorn \" style=\"color: #77A5C5;margin-right: 5px\"></span> Поделиться</span>"
                                    }));
                        </script>
                    </span>
                    <%--   <c:if test="${event.commentsList.size() != 0}">--%>
                    <div class="text-center hide" style="color: gray; padding: 15px;" id="past_${event.idEvent}">
                        <span>Завершено <span class="glyphicon glyphicon-eye-close"></span></span>
                    </div>

                    <ul class="list-group" id="listComment">
                        <c:forEach var="comment" items="${event.commentsList}">
                            <c:set var="eventid" value="${event.idEvent}"></c:set>
                            <c:set var="userId" value="${userId}"></c:set>
                            <li class="list-group-item" style="padding-bottom: 1px;padding-top: 5px"
                                id="${comment.commentId}" onmouseenter="handler(event)" onmouseleave="handler(event)">
                                <div class="media">
                                    <a class="pull-left"
                                       href="user?playerId=${comment.userId}&eventId=${event.idEvent}&userId=${userId}"
                                       style="margin-top: 5px">
                                        <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="35" height="35"> -->
                                        <img class="media-object round" src="${comment.userPhoto}" alt="user"
                                             width="35" height="35">
                                    </a>
                                    <c:if test="${comment.userId == userId}">
                                        <a id="${comment.commentId}_del"
                                           onclick="deleteComment('${comment.commentId}', '${eventid}')"
                                           class="btn pull-right hide" style="padding: 0px;background: white"> <span
                                                class="glyphicon glyphicon-remove "></span></a>
                                    </c:if>
                                    <div class="media-body ">
                                        <h5 class="media-heading"
                                            style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px;">${comment.firstName} ${comment.lastName}</h5>
                                        <span style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 2px">${comment.message}</span>
                                        <br>
                                        <span style="color: gray">${comment.date}</span>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <%--</c:if>--%>

                    <div style="margin-bottom: 15px; margin-top: 15px;" id="commentArea">
                        <c:if test="${event.commentsList.size() == 0}">
                            <hr id="hrComment"
                                style="margin-top: 0px; padding-top: 0px; margin-bottom: 7px;padding-bottom: 7px">
                        </c:if>
                        <div>
                            <div>

                                <div class="container-fluid">
                                    <div class="row ">
                                        <div class="col-xs-10 col-md-11 col-sm-11  ">
                                                <textarea type="text" id="textComment"
                                                          style="padding-bottom: 15px; margin-bottom: 0px; "
                                                          class="form-control borderless  media-heading" rows="1"
                                                          placeholder="Ваше сообщение" aria-label=""></textarea>
                                            <hr style="padding: 0px; margin:0px">
                                        </div>
                                        <div class="col-xs-2 col-md-1 col-sm-1 pull-right " style="padding-left: 3px">
                                            <a onclick="sendCommentUser()" class="btn  pull-right" id="send"><span
                                                    style="padding-bottom: 10px"> <img
                                                    src="resources/image/send.png" width="25"
                                                    height="25"></span></a>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </div>


                </div>

                <div class="modal fade" id="addIgrok_${event.idEvent}">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;
                                </button>
                                <h4 class="modal-title">Добавить еще от меня</h4>
                            </div>
                            <div class="modal-body">
                                <select class="form-control borderless" id="countIgrok_${event.idEvent}" name="sel1">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                                <a id="addIgrok_${event.idEvent}"
                                   onclick="addIgrok(${event.maxCountAnswer}, ${event.idEvent}, ${userId}, 'eventId=${event.idEvent}', ${event.userList.size()}, 'addIgrok_${event.idEvent}')"
                                   class="btn btn-primary">Добавить</a>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->

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

            </div>
            <div class="col-sm-2">

            </div>
        </div>
    </div>
</main>
<script>
    VK.init(function () {
        console.log('vk init');
    }, function () {
        alert('vk init fail \n Напишите нам об ошибке')
        // API initialization failed
        // Can reload page here
    }, '5.74');
</script>
<script>
    var where = '${where}';
    var subscriptionStatus = '${subscriptionStatus}';
    if (where === 'comment') {
        $('#textComment').focus();
    }

    if (device.desktop()) {
        $('#navPlaygrounds').addClass('hide');
        if (subscriptionStatus === 'not' || subscriptionStatus === 'resume') {
            getMedia();
        }
    }


    var maxWatch = 10;
    var event = ${eventJson};
    var activeEvent = event.active;
    var userId = "${userId}";
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
    if (description && description.length > 0) {
        description.forEach(function (message, i) {

            $('#descrEvent_' + id).append(message);
            $('#descrEvent_' + id).append('<br>');
        });
    }
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

    if (activeEvent === false) {
        disabledEventPast(id);
    } else {
        handleLengthText();
    }


    function sendCommentUser() {
        var text = $('#textComment').val().trim();
        var eventId = '${event.idEvent}';
        var userId = '${userId}';
        var playgroundId = '${event.playgroundId}';


        if (text.length != 0) {
            $('#textComment').val('');
            $.ajax({
                url: 'sendCommentUser',
                method: 'POST',
                data: ({message: text, eventId: eventId, userId: userId, playgroundId: playgroundId})
            }).then(function (comment) {
                switch (comment.success) {
                    case true:
                        addCommentToListComments(comment, eventId);
                        break;
                    case false:
                        $('#alertFail_' + eventId).removeClass('hide');
                        $('#alertFail_' + eventId).alert();
                        break;
                }

                resizeEvent();
                if (device.desktop()) {
                    $('#textComment').focus();
                }
            });

        }

    }

    function hideButton(eventId) {
        $('#alertMax_' + eventId).addClass('hide');
        $('#alertFail_' + eventId).addClass('hide');

    }


    function deleteComment(commentId, eventId) {
        var userId = '${userId}';
        var playgroundId = '${event.playgroundId}';

        $.ajax({
            url: 'deleteComment?commentId=' + commentId + '&eventId=' + eventId + '&playgroundId=' + playgroundId + '&userId=' + userId
        }).then(function () {
            var comment = document.getElementById(commentId);
            var listComment = document.getElementById('listComment');
            listComment.removeChild(comment);
            if (listComment.childNodes.lenhth == 0) {
                $('#hrComment').removeClass('hide');
            }
        });

    }

    $("#textComment").keyup(function (event) {
        if (event.keyCode == 13 && !event.shiftKey) {
            //    if (device.desktop()) {
            sendCommentUser();
            //  }
        }
    });


    function handler(event) {
        event = event || window.event;

        if (event.type == 'mouseenter') {

            var id = document.getElementById(event.target.id + '_del');
            if (id) {
                id.className = 'btn pull-right';
            }

        }
        if (event.type == 'mouseleave') {
            var id = document.getElementById(event.target.id + '_del');
            if (id) {
                id.className = 'btn pull-right hide';
            }

        }
    }

    function handleText() {
        var t = $('#textComment').val().trim();
        var text = t.split('');
        if (text.length > 0) {
            $('#send').removeClass('disabled');
        } else {
            $('#send').addClass('disabled');

        }

    }

    function handleLengthText() {
        setInterval(handleText, 500);
    }


    setTimeout('resizeEvent()', 300);

    function resizeEvent() {
        //VK.callMethod('resizeWindow', 1000, $('#body').height() + 80);
        if (device.desktop()) {
            var height = $('#eventMain').height();
            if (height < 650) {
                VK.callMethod('resizeWindow', 900, 650);
            } else {
                VK.callMethod('resizeWindow', 900, height + 100);
            }
        }

    }

    var dateNow = new Date().getTime();

    function updateData() {
        var userId = '${userId}';
        var playgroundId = '${event.playgroundId}';
        var eventId = '${event.idEvent}';
        var isWatch = false;
        $.ajax({
            url: 'getNewDataEvent?date=' + dateNow + '&userId=' + userId + '&eventId=' + eventId
        }).then(function (value) {

            if (value) {
                console.log("data edit");
                dateNow = new Date().getTime();
                var event = value;
                var usersList = event.userList;
                var commentList = event.commentsList;
                if (commentList.length > 0) {
                    $('#listComment').empty();
                    commentList.forEach(function (comment, i) {
                        addCommentToListComments(comment, eventId);
                    })
                }
                if (usersList.length > maxWatch) {
                    isWatch = true;
                    // $('#watch_' + eventId).removeClass('hide');
                }
                if (event.isEditEvent == true) {
                    location.reload();
                }

                resizeEvent();

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
            }
        });
    }

    function addCommentToListComments(comment, eventId) {
        var userId = '${userId}';
        $('#hrComment').addClass('hide');
        $('#templateCommentLink').attr('href', 'user?playerId=' + comment.userId + '&userId=${userId}');
        $('#templateCommentName').text(comment.firstName + " " + comment.lastName);
        var message = comment.message.split('\n');
        $('#templateCommentMessage').html('');
        message.map(function (message, i) {

            $('#templateCommentMessage').append(message);
            $('#templateCommentMessage').append('<br>');
        });
        //$('#templateCommentMessage').text(comment.message);
        $('#templateCommentDate').text(comment.date);
        $('#templateComment').removeClass('hide');
        var img = document.getElementById('templateCommentId');
        img.src = comment.userPhoto;
        var templ = document.getElementById("templateComment").cloneNode(true);
        templ.id = comment.commentId;

        var idDel = comment.commentId + '_del';
        templ.childNodes[1].childNodes[3].id = idDel;

        if (comment.userId === userId) {
            templ.onmouseenter = handler;
            templ.onmouseleave = handler;
            templ.childNodes[1].childNodes[3].onclick = function () {
                deleteComment(comment.commentId, eventId);
            };
        }

        $('#templateComment').addClass('hide');
        $('#listComment').append(templ);


        $('#templateCommentMessage').empty();
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
        $('#commentArea').addClass('hide');
        $('#textComment').attr('disabled', 'disabled');
        $('#answerButton_' + id).attr('disabled', 'disabled');

    }

    setInterval(updateData, 5000);
</script>

</body>
</html>