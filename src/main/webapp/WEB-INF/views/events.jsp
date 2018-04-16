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


    <style>

        /* Set black background color, white text and some padding */
        disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }
        .hrDescription {
            margin-top: 9px;
            margin-bottom: 9px;
        }
        body
        {
            overflow-y:scroll;
        }
    </style>
</head>
<body >


<a href="" class="btn hide" style="padding: 0px" id="templateUserList2">
    <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
    <img src="resources/image/foot.png" alt="Баскетбол" width="30"
         height="30" id="imageUser">
</a>


<nav class="navbar navbar-static-top navbar-default" >
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
<div class="container-fluid " >

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
                                        <a class="pull-left" href="#" >
                                            <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                            <img id="${event.idEvent}_imgPlayground" class="media-object" src="resources/image/playbasket.png"
                                                 alt="Баскетбол" width="40" height="40">
                                        </a>


                                        <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                                            <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu5"> <span
                                                    class="glyphicon glyphicon-option-vertical"></span></a>
                                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu5">
                                                <c:choose>
                                                    <c:when test="${event.userIdCreator == userId}">
                                                        <c:set var="playgroundId" value="${event.playgroundId}" />
                                                        <c:set var="sport" value="${event.sport}" />
                                                        <li><a href="#" onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})" id="cancelAnswer_${event.idEvent}"> <span class="glyphicon glyphicon-minus"
                                                                                                                                                                                        style="margin-right: 20px"></span>Отменить голос</a>
                                                        </li>
                                                        <li><a href="#" onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})" id="doAnswer_${event.idEvent}"> <span class="glyphicon glyphicon-plus"
                                                                                                                                                                                    style="margin-right: 20px"></span>Проголосовать</a>
                                                        </li>
                                                        <%--     <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span
                                                                     class="glyphicon glyphicon-time"
                                                                     style="margin-right: 20px"></span>История
                                                                 изменений</a></li>--%>
                                                        <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}"> <span class="glyphicon glyphicon-home"
                                                                                                                                    style="margin-right: 20px"></span>К площадке</a>
                                                        </li>
                                                        <li><a href="event?eventId=${event.idEvent}&userId=${userId}"> <span class="glyphicon glyphicon-share-alt"
                                                                                                            style="margin-right: 20px"></span>К записи</a>
                                                        </li>




                                                        <li><a href="create?playgroundId=${playgroundId}&sport=${sport}&eventId=${event.idEvent}&userId=${userId}">
                                                    <span class="glyphicon glyphicon-pencil"
                                                          style="margin-right: 20px"></span>Редактировать
                                                        </a></li>
                                                        <li><a href="endGame?eventId=${event.idEvent}&userId=${userId}"><span class="glyphicon glyphicon-off"
                                                                                                             style="margin-right: 20px"></span>Завершить
                                                            опрос</a></li>
                                                        <li><a href="deleteGame?eventId=${event.idEvent}&userId=${userId}"><span class="glyphicon glyphicon-trash"
                                                                                                                style="margin-right: 20px"></span>Удалить
                                                            опрос</a></li>

                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:set var="playgroundId" value="${event.playgroundId}" />
                                                        <c:set var="sport" value="${event.sport}" />
                                                        <li><a href="#" onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})" id="cancelAnswer2_${event.idEvent}"> <span class="glyphicon glyphicon-minus"
                                                                                                                                                                                         style="margin-right: 20px"></span>Отменить голос</a>
                                                        </li>
                                                        <li><a href="#" onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})" id="doAnswer2_${event.idEvent}"> <span class="glyphicon glyphicon-plus"
                                                                                                                                                                                     style="margin-right: 20px"></span>Проголосовать</a>
                                                        </li>
                                                        <%--    <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span class="glyphicon glyphicon-time"
                                                                                                                                    style="margin-right: 20px"></span>История
                                                                изменений</a></li>--%>
                                                        <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}"> <span class="glyphicon glyphicon-home"
                                                                                                                                    style="margin-right: 20px"></span>К площадке</a>
                                                        </li>
                                                        <li><a href="event?eventId=${event.idEvent}&userId=${userId}"> <span class="glyphicon glyphicon-share-alt"
                                                                                                            style="margin-right: 20px"></span>К записи</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>

                                            </ul>
                                        </div>
                                        <div class="media-body" style="padding-left: 10px">

                                            <h4 class="media-heading"
                                                style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">${event.playgroundName}</h4>


                                            <span style="color: gray">${event.date} сегодня в 13:34</span>

                                        </div>

                                    </div>


                                </div>
                                <div style="padding-left: 15px;padding-top: 10px; padding-bottom: 12px">
                                    <a class="pull-left" href="#" >
                                        <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                        <img id="${event.idEvent}_imgPlayground" class="media-object" src="resources/image/foot2.png"
                                             alt="Баскетбол" width="35" height="35">

                                    </a>
                                    <div class="media-body" >
                                        <a href="#" style="margin-left: 3px;padding-left: 3px" class="btn" > ${event.userFirtsNameCreator} ${event.userLastNameCreator}
                                        </a>
                                    </div>

                                </div>
                                    <%--<hr style="margin-bottom: 9px; margin-top: 0px">--%>
                                <div>
                                    <span style="color: black; padding-left: 17px; padding-right: 17px">${event.description}</span>
                                </div>
                                    <%--<hr class="hrDescription">--%>

                                <div class="panel-body" style="padding-bottom: 0px">
                                    <div class="list-group" style="margin-bottom: 5px">
                                        <a  class="list-group-item "  onclick="handleAnswer(${event.maxCountAnswer}, ${event.idEvent})" id="answerButton_${event.idEvent}">
                                            <c:choose>
                                                <c:when test="${event.maxCountAnswer == 0}">
                                                    <span class="badge" id="badge1_${event.idEvent}">${event.userList.size()}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge" id="badge2_${event.idEvent}">${event.userList.size()} / ${event.maxCountAnswer} </span>
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
                                                            <a href="user?userId=${user.userId}" class="btn" style="padding: 0px" id="${user.userId}_imgUser_${event.idEvent}_fake">
                                                                <span id="${user.userId}_add_${event.idEvent}" count="${user.countFake}">+${user.countFake}</span>

                                                            </a>

                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="user?userId=${user.userId}" class="btn" style="padding: 0px" id="${user.userId}_imgUser_${event.idEvent}">
                                                                <img src="resources/image/foot.png" alt="Баскетбол" width="30"
                                                                     height="30" id="${user.userId}_img_${event.idEvent}">
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>

                                                </c:forEach>

                                                <c:if test="${event.userList.size() > 7}">
                                                    <a href="#" class="btn" style="color: gray"> <span
                                                            class="glyphicon glyphicon-eye-open"
                                                            style="margin-right: 5px"></span>Все</a>
                                                </c:if>

                                            </div>

                                        </div>


                                    </div>

                                </div>

                                <a href="event?eventId=${event.idEvent}" class="btn" style=" margin-left: 5px;margin-top: 4px; margin-bottom: 4px" id="commentEvents"><span
                                        class="glyphicon glyphicon-comment " aria-hidden="Комментировать"
                                        style="color: #77A5C5;margin-right: 5px"></span>
                                    <c:if test="${event.commentsList.size() > 0}">
                                        ${event.commentsList.size()}
                                    </c:if></a>
                                <a href="#" class="btn" style=" margin-left: 5px; margin-top: 4px;margin-bottom: 4px"><span
                                        class="glyphicon glyphicon-bullhorn " aria-hidden="Комментировать"
                                        style="color: #77A5C5;margin-right: 5px"></span>Поделиться</a>





                            </div>

                            <div class="modal fade" id="addIgrok_${event.idEvent}">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title">Добавить еще от меня</h4>
                                        </div>
                                        <div class="modal-body">
                                            <select class="form-control borderless" id="countIgrok_${event.idEvent}" name="sel1">
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
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                                            <a onclick="addIgrok(${event.maxCountAnswer}, ${event.idEvent})" class="btn btn-primary">Добавить</a>
                                        </div>
                                    </div><!-- /.modal-content -->
                                </div><!-- /.modal-dialog -->
                            </div><!-- /.modal -->

                            <!-- Modal -->
                            <div class="modal fade" id="historyChange_${event.idEvent}" tabindex="-1" role="dialog" aria-labelledby="historyChangeLabel"
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
                                                    <a href="user?userId=${history.userId}" class="list-group-item borderless">
                                                        <div class="media">
                                                            <div class="pull-left">
                                                                <img class="media-object" src="resources/image/foot.png" alt="Футбол" width="40"
                                                                     height="40"/>
                                                            </div>


                                                            <div class="media-body ">
                                                                <p style="margin-bottom: 0px; padding-bottom: 0px; padding-top: 2px">${history.firstName} ${history.lastName}   ${history.action}</p>
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
    console.log(listEvents.length);
    if (listEvents) {
        var userId = "${userId}";
        listEvents.map(function (event, i) {
            var maxCountAnswer = event.maxCountAnswer;
            var usersList = event.userList;
            var isFake = false;
            var sp = event.sport;
            var id = event.idEvent;
            console.log("idEvent " + id);
            var element = document.getElementById(id);
            var imgPlayground = document.getElementById(id+'_imgPlayground');
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
            // Определяем истинное значение игроков
            if (maxCountAnswer == 0) {
                var count = parseInt($('#badge1_'+id).text());
                console.log("badge1 " + $('#badge1_'+id).text())
                if (usersList) {
                    usersList.map(function (user, i) {
                        if (user.countFake != 0) {
                            count = count + user.countFake;
                            isFake = true;
                        }
                    });
                }
                if(isFake) {
                    --count;
                }
                $('#badge1_'+ id).text(count);
            } else {
                var count = parseInt($('#badge2_'+id).text().split(' / ')[0]);
                console.log("badge2 " + $('#badge2_'+id).text());
                if (usersList) {
                    usersList.map(function (user, i) {
                        if (user.countFake != 0) {
                            count = count + user.countFake;
                            isFake = true;
                        }
                    });
                }
                if(isFake) {
                    --count;
                }
                $('#badge2_'+ id).text(count + ' / ' + maxCountAnswer );
            }


                var eventId = event.idEvent;
                console.log("eventId " + eventId);
                var listUser = event.userList;
                var isActive = false;
                listUser.map(function (user, i) {
                    if (user.userId === userId ) {
                        isActive = true;
                    }
                });

                if (isActive) {
                   // $('#answerButton_'+ eventId).addClass('active');
                    $('#answerButton_'+ eventId).removeClass('active');
                    $('#answerButton_'+ eventId).css('background','#EAEAEC');

                    $('#answerOk_'+ eventId).removeClass('hide');
                    $('#cancelAnswer_'+ eventId).removeClass('hide');
                    $('#doAnswer_'+ eventId).addClass('hide');
                    $('#cancelAnswer2_'+ eventId).removeClass('hide');
                    $('#doAnswer2_'+ eventId).addClass('hide');
                } else {
                    //$('#answerButton_'+ eventId).removeClass('active');
                    $('#answerButton_'+ eventId).addClass('active');
                    $('#answerButton_'+ eventId).css('background','');
                    $('#answerOk_'+ eventId).addClass('hide');
                    $('#cancelAnswer_'+ eventId).addClass('hide');
                    $('#doAnswer_'+ eventId).removeClass('hide');
                    $('#cancelAnswer2_'+ eventId).addClass('hide');
                    $('#doAnswer2_'+ eventId).removeClass('hide');
                }

        });

    }

    function addIgrok(maxCountAnswer, eventId) {
        var addIgr = $('#countIgrok_' + eventId).val();
        var userId = ${userId};
        $.ajax({
            url: 'addIgrok?eventId=' + eventId + '&count=' + addIgr + '&userId=' + ${userId}
        }).then(function (value) {
            if (maxCountAnswer == 0) {
                var clone = document.getElementById(userId + '_imgUser_' + eventId + '_fake');
                if (clone) {
                    var countRemove = parseInt(document.getElementById(userId + "_add_" + eventId).getAttribute('count'));
                    var count = $('#badge1_'+ eventId).text();
                    $('#badge1_' + eventId).text(count - countRemove);
                    // var userList = document.getElementById('imgUserList_' + eventId);
                    // userList.removeChild(clone);
                    $('#'+userId + '_imgUser_' + eventId + '_fake').remove();
                }
                var count = parseInt($('#badge1_'+ eventId).text());
                count = count + parseInt(addIgr);
                $('#badge1_' + eventId).text(count);
                $('#templateUserList2').removeClass('hide');
                $('#imageUser').addClass('hide');
                var userImg = document.getElementById("templateUserList2").cloneNode(true);
                userImg.id = userId + '_imgUser_' + eventId + '_fake';
                userImg.href = "user?userId=" + userId;
                var span = document.createElement('span');
                span.id = userId + '_add_' + eventId;
                span.setAttribute('count', addIgr);
                span.appendChild(document.createTextNode("+" + addIgr));
                userImg.appendChild(span);
                $('#imgUserList_'+ eventId).append(userImg);
                $('#templateUserList2').addClass('hide');
                $('#imageUser').removeClass('hide');

                $('#addIgrok_'+ eventId).modal('hide');

            } else {
                var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                console.log(count[0]);
                if (count[0] == maxCountAnswer) {
                    console.log(count[0]);
                    $('#addIgrok_'+ eventId).modal('hide');
                } else {
                    var clone = document.getElementById(userId + '_imgUser_' + eventId + '_fake');
                    if (clone) {
                        var countRemove = parseInt(document.getElementById(userId + "_add_" + eventId).getAttribute('count'));
                        var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                        count = count - countRemove;
                        $('#badge2_' + eventId).text(count + ' / ' + maxCountAnswer );
                        $('#'+userId + '_imgUser_' + eventId + '_fake').remove();
                    }
                    count = count + parseInt(addIgr);
                    $('#badge2_' + eventId).text(count + ' / ' + maxCountAnswer );
                    $('#templateUserList2').removeClass('hide');
                    $('#imageUser').addClass('hide');
                    var userImg = document.getElementById("templateUserList2").cloneNode(true);
                    userImg.id = userId + '_imgUser_' + eventId + '_fake';;
                    userImg.href = "user?userId=" + userId;
                    var span = document.createElement('span');
                    span.id = userId + '_add_' + eventId;
                    span.setAttribute('count', addIgr);
                    span.appendChild(document.createTextNode("+" + addIgr));
                    userImg.appendChild(span);
                    $('#imgUserList_' + eventId).append(userImg)
                    $('#templateUserList2').addClass('hide');
                    $('#imageUser').removeClass('hide');
                    $('#addIgrok_' + eventId).modal('hide');
                }
            }
        });
    }

    function handleAnswer(maxCountAnswer, eventId) {
            $.ajax({
                url: 'handleAnswer?eventId=' + eventId + '&userId=' + ${userId}
            }).then(function (value) {
                console.log('answer ' + value);
                var userId = '${userId}';
                if (value === 'true') {
                    $('#cancelAnswer_'+ eventId).removeClass('hide');
                    $('#doAnswer_'+ eventId).addClass('hide');
                    $('#cancelAnswer2_'+ eventId).removeClass('hide');
                    $('#doAnswer2_'+ eventId).addClass('hide');
                    if (maxCountAnswer == 0) {
                        //$('#answerButton_'+ eventId).addClass('active');
                        $('#answerButton_'+ eventId).removeClass('active');
                        $('#answerButton_'+ eventId).css('background','#EAEAEC');
                        $('#answerOk_'+ eventId).removeClass('hide');
                        var count = parseInt($('#badge1_'+ eventId).text());
                        ++count;
                        $('#badge1_'+ eventId).text(count);
                        $('#templateUserList2').removeClass('hide');
                        var userImg = document.getElementById("templateUserList2").cloneNode(true);
                        userImg.id = userId + '_imgUser_' + eventId;
                        userImg.href = "user?userId=" + userId;
                        $('#imgUserList_'+ eventId).append(userImg);
                        $('#templateUserList2').addClass('hide');
                    } else if (value === 'false'){
                        var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                        console.log(count[0]);
                        if (count[0] == maxCountAnswer) {
                            console.log(count[0]);

                        } else {
                            //$('#answerButton_'+ eventId).addClass('active');
                            $('#answerButton_'+ eventId).removeClass('active');
                            $('#answerButton_'+ eventId).css('background','#EAEAEC');
                            $('#answerOk_'+ eventId).removeClass('hide');
                            ++count;
                            $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                            $('#templateUserList2').removeClass('hide');
                            var userImg = document.getElementById("templateUserList2").cloneNode(true);
                            userImg.id = userId + '_imgUser_' + eventId;
                            userImg.href = "user?userId=" + userId;
                            $('#imgUserList_'+ eventId).append(userImg)
                            $('#templateUserList2').addClass('hide');
                        }
                    } else {

                    }
                } else {
                    $('#addIgrok_' + eventId).modal('show');
                }

            });
    }

    function handleAnswerMain(maxCountAnswer, eventId) {
        $.ajax({
            url: 'handleAnswerMain?eventId=' + eventId + '&userId=' + ${userId}
        }).then(function (value) {
            console.log('answer ' + value);
            var userId = '${userId}';
            if (value === 'true') {
                $('#cancelAnswer_'+ eventId).removeClass('hide');
                $('#doAnswer_'+ eventId).addClass('hide');
                $('#cancelAnswer2_'+ eventId).removeClass('hide');
                $('#doAnswer2_'+ eventId).addClass('hide');
                if (maxCountAnswer == 0) {
                  //  $('#answerButton_'+ eventId).addClass('active');
                    $('#answerButton_'+ eventId).removeClass('active');
                    $('#answerButton_'+ eventId).css('background','#EAEAEC');
                    $('#answerOk_'+ eventId).removeClass('hide');
                    var count = $('#badge1_'+ eventId).text();
                    ++count;
                    $('#badge1_'+ eventId).text(count);
                    $('#templateUserList2').removeClass('hide');
                    var userImg = document.getElementById("templateUserList2").cloneNode(true);
                    userImg.id = userId + '_imgUser_' + eventId;
                    userImg.href = "user?userId=" + userId;
                    $('#imgUserList_'+ eventId).append(userImg);
                    $('#templateUserList2').addClass('hide');
                } else {
                    var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                    console.log(count[0]);
                    if (count[0] == maxCountAnswer) {
                        console.log(count[0]);

                    } else {
                        //$('#answerButton_'+ eventId).addClass('active');
                        $('#answerButton_'+ eventId).removeClass('active');
                        $('#answerButton_'+ eventId).css('background','#EAEAEC');
                        $('#answerOk_'+ eventId).removeClass('hide');
                        ++count;
                        $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                        $('#templateUserList2').removeClass('hide');
                        var userImg = document.getElementById("templateUserList2").cloneNode(true);
                        userImg.id = userId + '_imgUser_' + eventId;
                        userImg.href = "user?userId=" + userId;
                        $('#imgUserList_'+ eventId).append(userImg)
                        $('#templateUserList2').addClass('hide');
                    }
                }

            } else {
                $('#cancelAnswer_'+ eventId).addClass('hide');
                $('#doAnswer_'+ eventId).removeClass('hide');
                $('#cancelAnswer2_'+ eventId).addClass('hide');
                $('#doAnswer2_'+ eventId).removeClass('hide');
                //$('#answerButton_'+ eventId).removeClass('active');
                $('#answerButton_'+ eventId).addClass('active');
                $('#answerButton_'+ eventId).css('background','');
                $('#answerOk_'+ eventId).addClass('hide');
                if (maxCountAnswer == 0) {

                    var count = $('#badge1_'+ eventId).text();
                    $('#badge1_'+ eventId).text(count - 1);
                } else {
                    var count = parseInt($('#badge2_'+ eventId).text().split(' / '));
                    --count;
                    $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                }
                $('#' + userId + '_imgUser_'+ eventId).remove();



                var userAdd = document.getElementById(userId + '_imgUser_'+ eventId + '_fake');
                if(userAdd) {
                    var countRemove = parseInt(document.getElementById(userId + '_add_' + eventId).getAttribute('count'));
                    if (maxCountAnswer == 0) {
                        var count = $('#badge1_'+ eventId).text();
                        $('#badge1_'+ eventId).text(count - countRemove);
                    } else {
                        var count = parseInt($('#badge2_'+ eventId).text().split(' / '));
                        console.log(count[0]);
                        count = count - countRemove;
                        $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                    }
                    $('#' + userId + '_imgUser_'+ eventId + '_fake' ).remove();
                }

            }
        });
    }

</script>
</body>
</html>