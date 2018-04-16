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

        .hrDescription {
            margin-top: 9px;
            margin-bottom: 9px;
        }

        textarea {
            resize: none;
        }
    </style>
</head>
<body>

<a href="" class="btn hide" style="padding: 0px" id="templateUserList">
    <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
    <img src="resources/image/foot.png" alt="Баскетбол" width="30"
         height="30" id="imageUser">
</a>

<li class="list-group-item hide" style="padding-bottom: 1px;padding-top: 5px" id="templateComment" >
    <div class="media">
        <a class="pull-left" href=""
           style="margin-top: 5px" id="templateCommentLink">
            <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="35" height="35"> -->
            <img class="media-object" src="resources/image/foot.png" alt="Футбол" id="templateCommentId"
                 width="35" height="35">
        </a>
        <a href="#" onclick="" class="btn pull-right hide"  id="deleteComment" style="padding: 0px;background: white">  <span class="glyphicon glyphicon-remove "></span></a>
        <div class="media-body ">
            <h5 class="media-heading"
                style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px;color: #77A5C5" id="templateCommentName"></h5>
            <span style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 2px" id="templateCommentMessage"></span>
            <span style="color: gray" id="templateCommentDate"></span>
        </div>
    </div>
</li>

<nav class="navbar navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand btn" href="home?&userId=${userId}"><span class="glyphicon glyphicon-menu-left"
                                                          aria-hidden=""></span></a>
            <a class="navbar-brand" href="#">Событие</a>
        </div>

    </div>
</nav>
<main>
    <div class="container-fluid ">

        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="list-group">

                    <div class="panel " id="eventPanel">
                        <div class="panel-heading" style="padding-bottom: 3px; padding-top: 6px">

                            <div>
                                <a class="pull-left" href="#">
                                    <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                    <img id="imageGroup3" class="media-object" src="resources/image/playbasket.png"
                                         alt="Баскетбол" width="40" height="40">
                                </a>


                                <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                                    <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu2"> <span
                                            class="glyphicon glyphicon-option-vertical"></span></a>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
                                        <c:choose>
                                            <c:when test="${event.userIdCreator == userId}">
                                                <c:set var="playgroundId" value="${event.playgroundId}" />
                                                <c:set var="sport" value="${event.sport}" />
                                                <li><a href="#" onclick="handleAnswerMain()" id="cancelAnswer"> <span class="glyphicon glyphicon-minus"
                                                                                                                      style="margin-right: 20px"></span>Отменить голос</a>
                                                </li>
                                                <li><a href="#" onclick="handleAnswerMain()" id="doAnswer"> <span class="glyphicon glyphicon-plus"
                                                                                                                  style="margin-right: 20px"></span>Проголосовать</a>
                                                </li>
                                                <li><a href="#" data-toggle="modal" data-target="#historyChange"> <span
                                                        class="glyphicon glyphicon-time"
                                                        style="margin-right: 20px"></span>История
                                                    изменений</a></li>
                                                <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}"> <span class="glyphicon glyphicon-home"
                                                                       style="margin-right: 20px"></span>К площадке</a>
                                                </li>
                                           <%--     <li><a href="#"> <span class="glyphicon glyphicon-share-alt"
                                                                       style="margin-right: 20px"></span>К записи</a>
                                                </li>--%>




                                                <li><a href="create?playgroundId=${playgroundId}&sport=${sport}&eventId=${event.idEvent}">
                                                    <span class="glyphicon glyphicon-pencil"
                                                          style="margin-right: 20px"></span>Редактировать
                                                </a></li>
                                                <li><a href="endGame?eventId=${event.idEvent}"><span class="glyphicon glyphicon-off"
                                                                                                     style="margin-right: 20px"></span>Завершить
                                                    опрос</a></li>
                                                <li><a href="deleteGame?eventId=${event.idEvent}"><span class="glyphicon glyphicon-trash"
                                                                                                        style="margin-right: 20px"></span>Удалить
                                                    опрос</a></li>

                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="playgroundId" value="${event.playgroundId}" />
                                                <c:set var="sport" value="${event.sport}" />
                                                <li><a href="#" onclick="handleAnswerMain()" id="cancelAnswer2"> <span class="glyphicon glyphicon-minus"
                                                                                                                       style="margin-right: 20px"></span>Отменить голос</a>
                                                </li>
                                                <li><a href="#" onclick="handleAnswerMain()" id="doAnswer2"> <span class="glyphicon glyphicon-plus"
                                                                                                                   style="margin-right: 20px"></span>Проголосовать</a>
                                                </li>
                                                <li><a href="#" data-toggle="modal" data-target="#historyChange"> <span class="glyphicon glyphicon-time"
                                                                       style="margin-right: 20px"></span>История
                                                    изменений</a></li>
                                                <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}"> <span class="glyphicon glyphicon-home"
                                                                       style="margin-right: 20px"></span>К площадке</a>
                                                </li>
                                              <%--  <li><a href="#"> <span class="glyphicon glyphicon-share-alt"
                                                                       style="margin-right: 20px"></span>К записи</a>
                                                </li>--%>
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
                        <div>
                            <a href="#" class="btn" style="margin-left: 5px"><span class="glyphicon glyphicon-user "
                                                                                   aria-hidden=""
                                                                                   style="margin-right: 5px"></span> ${event.userFirtsNameCreator} ${event.userLastNameCreator}
                            </a>
                        </div>
                        <hr style="margin-bottom: 9px; margin-top: 0px">
                        <div>
                            <span style="color: black; padding-left: 17px; padding-right: 17px">${event.description}</span>
                        </div>
                        <hr class="hrDescription">

                        <div class="panel-body" style="padding-bottom: 0px">
                            <div class="list-group" style="margin-bottom: 5px">
                                <a href="#" class="list-group-item " onclick="handleAnswer()" id="answerButton">
                                    <c:choose>
                                        <c:when test="${event.maxCountAnswer == 0}">
                                            <span class="badge" id="badge1">${event.userList.size()}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge" id="badge2">${event.userList.size()} / ${event.maxCountAnswer} </span>
                                        </c:otherwise>
                                    </c:choose>


                                    <div class="text-center">
                                        +
                                    </div>
                                </a>
                            </div>

                            <div class="btn-group " style="margin-top: 5px">
                                <div class="container-fluid">
                                    <div class="row" id="imgUserList">
                                        <c:forEach var="user" items="${event.userList}">
                                            <a href="user?userId=${user.userId}" class="btn" style="padding: 0px" id="${user.userId}">
                                                <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
                                                    <c:choose>
                                                        <c:when test="${user.isFake() == true}">
                                                           <span id="${user.userId}count" count="${user2.countFake}">+${user.countFake}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="resources/image/foot.png" alt="Баскетбол" width="30"
                                                                 height="30" id="${user2.userId}img">
                                                        </c:otherwise>
                                                    </c:choose>

                                            </a>
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
                        <hr style="margin-bottom: 0px">
                        <a href="#" class="btn" style=" margin-left: 5px; margin-top: 4px; margin-bottom: 4px"><span
                                class="glyphicon glyphicon-bullhorn " style="margin-right: 5px"></span> Поделиться</a>
                     <%--   <c:if test="${event.commentsList.size() != 0}">--%>

                            <ul class="list-group" id="listComment" >
                                <c:forEach var="comment" items="${event.commentsList}">
                                    <c:set var="eventid" value="${event.idEvent}"></c:set>
                                    <c:set var="userId" value="${userId}"></c:set>
                                    <li class="list-group-item" style="padding-bottom: 1px;padding-top: 5px" id="${comment.commentId}" onmouseenter="handler(event)" onmouseleave="handler(event)">
                                        <div class="media">
                                            <a class="pull-left" href="user?userId=${comment.userId}"
                                               style="margin-top: 5px">
                                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="35" height="35"> -->
                                                <img class="media-object" src="resources/image/foot.png" alt="Футбол"
                                                     width="35" height="35">
                                            </a>
                                            <c:if test="${comment.userId == userId}">
                                                <a href="#" id="${comment.commentId}del" onclick="deleteComment(${comment.commentId}, ${eventid})" class="btn pull-right hide"  style="padding: 0px;background: white">  <span class="glyphicon glyphicon-remove "></span></a>
                                            </c:if>
                                            <div class="media-body ">
                                                <h5 class="media-heading"
                                                    style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px;color: #77A5C5">${comment.firstName} ${comment.lastName}</h5>
                                                <span style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 2px">${comment.message}</span>
                                                <br>
                                                <span style="color: gray">${comment.date}</span>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        <%--</c:if>--%>

                        <div style="margin-bottom: 15px; margin-top: 15px;">
                            <c:if test="${event.commentsList.size() == 0}">
                                <hr id="hrComment"  style="margin-top: 0px; padding-top: 0px; margin-bottom: 7px;padding-bottom: 7px">
                            </c:if>
                            <div>
                                <a class="pull-left" href="#" style="margin-left: 15px;">
                                    <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
                                    <img class="media-object" src="resources/image/foot.png" alt="Баскетбол" width="35"
                                         height="35">
                                </a>

                                <div class="media-body">

                                    <div class="container-fluid">
                                        <div class="row ">
                                            <div class="col-xs-9 col-md-11 col-sm-11  ">
                                                <textarea type="text" id="textComment" style="padding-bottom: 15px; margin-bottom: 0px; "
                                                          class="form-control borderless  media-heading" rows="1"
                                                          placeholder="Ваше сообщение" aria-label=""></textarea>
                                                <hr style="padding: 0px; margin:0px">
                                            </div>
                                            <div class="col-xs-3 col-md-1 col-sm-1 pull-righ ">
                                                <a href="#" onclick="sendCommentUser()" class="btn  pull-right" id="send"><span
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


                </div>


            </div>

        </div>
        <div class="col-sm-2">

        </div>
    </div>

</main>

<div class="modal fade" id="addIgrok">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">Добавить еще от меня</h4>
            </div>
            <div class="modal-body">
                <select class="form-control borderless" id="countIgrok" name="sel1">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>
                    <option>8</option>
                    <option>9</option>
                    <option>10</option>
                </select>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>
                <a onclick="addIgrok()" class="btn btn-primary">Добавить</a>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Modal -->
<div class="modal fade" id="historyChange" tabindex="-1" role="dialog" aria-labelledby="historyChangeLabel"
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

                <div class="list-group" id="listGroupsCreate">
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

<script>
    $(document).ready(function () {
        $('#all').tooltip({title: "Смотреть всех", container: ".row"});
    });
    $('#textComment').focus();

    var sp = '${event.sport}';
    if (sp == 'Футбол') {
        $('#eventPanel').addClass('panel-success');
        $('#imageGroup3').attr("src", "resources/image/стадион.png")
    } else if (sp == 'Баскетбол') {
        $('#eventPanel').addClass('panel-warning');
        $('#imageGroup3').attr("src", "resources/image/playbasket.png")
    } else if (sp == 'Волейбол') {
        $('#eventPanel').addClass('panel-info');
        $('#imageGroup3').attr("src", "resources/image/сетка.png")
    }
    var userId = '${userId}';
    var eventListActive = ${eventListActive};
    var maxCountAnswer = '${event.maxCountAnswer}';
    var event = ${eventJson};
    var usersList = event.userList;
    var isFake = false;

    if (maxCountAnswer == 0) {
        var count = parseInt($('#badge1').text());
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
        $('#badge1').text(count);
    } else {
        var count = parseInt($('#badge2').text().split(' / ')[0]);
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
        $('#badge2').text(count + ' / ' + maxCountAnswer );
    }


    if (eventListActive) {
        var eventId = '${event.idEvent}';
        if (eventListActive[eventId] && eventListActive[eventId] == true) {
            $('#answerButton').addClass('active');
            $('#cancelAnswer').removeClass('hide');
            $('#doAnswer').addClass('hide');
            $('#cancelAnswer2').removeClass('hide');
            $('#doAnswer2').addClass('hide');
        } else {
            $('#answerButton').removeClass('active');
            $('#cancelAnswer').addClass('hide');
            $('#doAnswer').removeClass('hide');
            $('#cancelAnswer2').addClass('hide');
            $('#doAnswer2').removeClass('hide');
        }
    }

    function addIgrok() {
        var maxCountAnswer = '${event.maxCountAnswer}';
        var eventId = '${event.idEvent}';
        var addIgr = $('#countIgrok').val();
        $.ajax({
            url: 'addIgrok?eventId=' + eventId + '&count=' + addIgr
        }).then(function (value) {
            if (maxCountAnswer == 0) {
                var clone = document.getElementById(userId+'add');
                if (clone) {
                    var countRemove = parseInt(document.getElementById(userId + 'countAdd').getAttribute('count'));
                    var count = $('#badge1').text();
                    $('#badge1').text(count - countRemove);
                    var userList = document.getElementById('imgUserList');
                    userList.removeChild(clone);


                }
                var count = parseInt($('#badge1').text());
                count = count + parseInt(addIgr);
                $('#badge1').text(count);
                $('#templateUserList').removeClass('hide');
                $('#imageUser').addClass('hide');
                var userImg = document.getElementById("templateUserList").cloneNode(true);
                userImg.id = userId + 'add';
                userImg.href = "user?userId=" + userId;
                var span = document.createElement('span');
                span.id = userId + 'countAdd';
                span.setAttribute('count', addIgr);
                span.appendChild(document.createTextNode("+" + addIgr));
                userImg.appendChild(span);
                $('#imgUserList').append(userImg);
                $('#templateUserList').addClass('hide');
                $('#imageUser').removeClass('hide');

                $('#addIgrok').modal('hide');

            } else {
                var count = parseInt($('#badge2').text().split(' / '));
                console.log(count[0]);
                if (count[0] == maxCountAnswer) {
                    console.log(count[0]);
                    $('#addIgrok').modal('hide');
                } else {
                    var clone = document.getElementById(userId+'add');
                    if (clone) {
                        var countRemove = parseInt(document.getElementById(userId + 'countAdd').getAttribute('count'));
                        var count = parseInt($('#badge2').text().split(' / '));
                        count = count - countRemove;
                        $('#badge2').text(count + ' / ' + maxCountAnswer );
                        var userList = document.getElementById('imgUserList');
                        userList.removeChild(clone);
                    }
                    count = count + parseInt(addIgr);
                    $('#badge2').text(count + ' / ' + maxCountAnswer );
                    $('#templateUserList').removeClass('hide');
                    $('#imageUser').addClass('hide');
                    var userImg = document.getElementById("templateUserList").cloneNode(true);
                    userImg.id = userId + 'add';
                    userImg.href = "user?userId=" + userId;
                    var span = document.createElement('span');
                    span.id = userId + 'countAdd';
                    span.setAttribute('count', addIgr);
                    span.appendChild(document.createTextNode("+" + addIgr));
                    userImg.appendChild(span);
                    $('#imgUserList').append(userImg)
                    $('#templateUserList').addClass('hide');
                    $('#imageUser').removeClass('hide');
                    $('#addIgrok').modal('hide');
                }
            }
        });
    }

    function handleAnswer() {
        var maxCountAnswer = '${event.maxCountAnswer}';
        var eventId = '${event.idEvent}';

        if (eventListActive) {

                $.ajax({
                    url: 'handleAnswer?eventId=' + eventId
                }).then(function (value) {
                    console.log('answer ' + value);
                    var userId = '${userId}';
                    if (value == true) {
                        $('#cancelAnswer').removeClass('hide');
                        $('#doAnswer').addClass('hide');
                        $('#cancelAnswer2').removeClass('hide');
                        $('#doAnswer2').addClass('hide');
                        if (maxCountAnswer == 0) {
                            $('#answerButton').addClass('active');
                            var count = $('#badge1').text();
                            ++count;
                            $('#badge1').text(count);
                            $('#templateUserList').removeClass('hide');
                            var userImg = document.getElementById("templateUserList").cloneNode(true);
                            userImg.id = userId;
                            userImg.href = "user?userId=" + userId;
                            $('#imgUserList').append(userImg);
                            $('#templateUserList').addClass('hide');
                        } else {
                            var count = parseInt($('#badge2').text().split(' / '));
                            console.log(count[0]);
                            if (count[0] == maxCountAnswer) {
                                console.log(count[0]);

                            } else {
                                $('#answerButton').addClass('active');
                                ++count;
                                $('#badge2').text(count + ' / ' + maxCountAnswer );
                                $('#templateUserList').removeClass('hide');
                                var userImg = document.getElementById("templateUserList").cloneNode(true);
                                userImg.id = userId;
                                userImg.href = "user?userId=" + userId;
                                $('#imgUserList').append(userImg)
                                $('#templateUserList').addClass('hide');
                            }
                        }
                    } else {
                        $('#addIgrok').modal('show');
                    }

                });
        }
    }

    function handleAnswerMain() {
        var maxCountAnswer = '${event.maxCountAnswer}';
        var eventId = '${event.idEvent}';
                $.ajax({
                    url: 'handleAnswerMain?eventId=' + eventId + '&userId=' + ${userId} ,
                }).then(function (value) {
                    console.log('answer ' + value);
                    var userId = '${userId}';
                    if (value == true) {
                        $('#cancelAnswer').removeClass('hide');
                        $('#doAnswer').addClass('hide');
                        $('#cancelAnswer2').removeClass('hide');
                        $('#doAnswer2').addClass('hide');
                        if (maxCountAnswer == 0) {
                            $('#answerButton').addClass('active');
                            var count = $('#badge1').text();
                            ++count;
                            $('#badge1').text(count);
                            $('#templateUserList').removeClass('hide');
                            var userImg = document.getElementById("templateUserList").cloneNode(true);
                            userImg.id = userId;
                            userImg.href = "user?userId=" + userId;
                            $('#imgUserList').append(userImg);
                            $('#templateUserList').addClass('hide');
                        } else {
                            var count = parseInt($('#badge2').text().split(' / '));
                            console.log(count[0]);
                            if (count[0] == maxCountAnswer) {
                                console.log(count[0]);

                            } else {
                                $('#answerButton').addClass('active');
                                ++count;
                                $('#badge2').text(count + ' / ' + maxCountAnswer );
                                $('#templateUserList').removeClass('hide');
                                var userImg = document.getElementById("templateUserList").cloneNode(true);
                                userImg.id = userId;
                                userImg.href = "user?userId=" + userId;
                                $('#imgUserList').append(userImg)
                                $('#templateUserList').addClass('hide');
                            }
                        }

                    } else {
                        $('#cancelAnswer').addClass('hide');
                        $('#doAnswer').removeClass('hide');
                        $('#cancelAnswer2').addClass('hide');
                        $('#doAnswer2').removeClass('hide');
                        $('#answerButton').removeClass('active');
                        if (maxCountAnswer == 0) {

                            var count = $('#badge1').text();
                            $('#badge1').text(count - 1);
                        } else {
                            var count = parseInt($('#badge2').text().split(' / '));
                            --count;
                            $('#badge2').text(count + ' / ' + maxCountAnswer );
                        }
                        var user = document.getElementById(userId);
                        var userAdd = document.getElementById(userId + 'add');
                        var userList = document.getElementById('imgUserList');
                        userList.removeChild(user);
                        if(userAdd) {
                            var countRemove = parseInt(document.getElementById(userId + 'countAdd').getAttribute('count'));
                            if (maxCountAnswer == 0) {
                                var count = $('#badge1').text();
                                $('#badge1').text(count - countRemove);
                            } else {
                                var count = parseInt($('#badge2').text().split(' / '));
                                console.log(count[0]);
                                count = count - countRemove;
                                $('#badge2').text(count + ' / ' + maxCountAnswer );
                            }
                            userList.removeChild(userAdd);
                        }


                    }
                });


    }

    function sendCommentUser() {
        var text = $('#textComment').val().trim();
        var eventId = '${event.idEvent}';

        if (text.length != 0) {
            $.ajax({
                url: 'sendCommentUser?userId=' + ${userId},
                method: 'POST',
                data: ({message: text, eventId: eventId })
            }).then(function (commentList) {
                $('#listComment').empty();
                commentList.map(function (comment, index) {
                    $('#hrComment').addClass('hide');
                    $('#templateCommentLink').attr('href', 'user?userId=' + userId);
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
                    var templ = document.getElementById("templateComment").cloneNode(true);
                    templ.id = comment.commentId;

                    var idDel = comment.commentId + 'del';
                    templ.childNodes[1].childNodes[3].id = idDel;



                    if (comment.userId == userId) {
                        templ.onmouseenter = handler;
                        templ.onmouseleave = handler;
                        templ.childNodes[1].childNodes[3].onclick = function () {
                            deleteComment(comment.commentId, eventId);
                        };
                    }

                    $('#templateComment').addClass('hide');
                    $('#listComment').append(templ);

                    $('#textComment').val('');
                    $('#textComment').focus();
                    $('#templateCommentMessage').empty();
                });

            });
        }

    }

    function deleteComment(commentId, eventId) {

        $.ajax({
            url: 'deleteComment?commentId=' + commentId + '&eventId=' + eventId
        }).then(function () {
            var comment = document.getElementById(commentId);
            var listComment = document.getElementById('listComment');
            listComment.removeChild(comment);
            if (listComment.childNodes.lenhth == 0) {
                $('#hrComment').removeClass('hide');
            }
        });

    }

    $("#textComment").keyup(function(event){
        if(event.keyCode == 13 && !event.shiftKey){
                sendCommentUser();
        }
    });



    function handler(event) {
        event = event || window.event;

        if (event.type == 'mouseenter') {

            var id = document.getElementById(event.target.id + 'del');
            if (id) {
                id.className = 'btn pull-right';
            }

        }
        if (event.type == 'mouseleave') {
            var id = document.getElementById(event.target.id + 'del');
            if (id) {
                id.className = 'btn pull-right hide';
            }

        }
    }
</script>

</body>
</html>