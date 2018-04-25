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

    <style>

        /* Set black background color, white text and some padding */

        .borderless {
            border: 0 none;

            box-shadow: none;

        }
        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
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

<a href="" class="btn hide" style="padding: 0px" id="templateUserList2">
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
                                <a class="pull-left" href="playground?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" >
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
                                                <li><a  onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId})" id="cancelAnswer_${event.idEvent}"> <span class="glyphicon glyphicon-minus"
                                                                                                                                                                                   style="margin-right: 20px"></span>Отменить голос</a>
                                                </li>
                                                <li><a  onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId})" id="doAnswer_${event.idEvent}"> <span class="glyphicon glyphicon-plus"
                                                                                                                                                                               style="margin-right: 20px"></span>Проголосовать</a>
                                                </li>
                                                <%--     <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span
                                                             class="glyphicon glyphicon-time"
                                                             style="margin-right: 20px"></span>История
                                                         изменений</a></li>--%>
                                                <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}"> <span class="glyphicon glyphicon-home"
                                                                                                                                             style="margin-right: 20px"></span>К площадке</a>
                                                </li>


                                                <li><a href="create?playgroundId=${playgroundId}&sport=${sport}&eventId=${event.idEvent}&userId=${userId}">
                                                    <span class="glyphicon glyphicon-pencil"
                                                          style="margin-right: 20px"></span>Редактировать
                                                </a></li>
                                                <li><a href="endGame?playgroundId=${playgroundId}&eventId=${event.idEvent}&userId=${userId}"><span class="glyphicon glyphicon-off"
                                                                                                                                                   style="margin-right: 20px"></span>Завершить
                                                    опрос</a></li>
                                                <li><a href="deleteGame?playgroundId=${playgroundId}&eventId=${event.idEvent}&userId=${userId}"><span class="glyphicon glyphicon-trash"
                                                                                                                                                      style="margin-right: 20px"></span>Удалить
                                                    опрос</a></li>

                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="playgroundId" value="${event.playgroundId}" />
                                                <c:set var="sport" value="${event.sport}" />
                                                <li><a  onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId})" id="cancelAnswer2_${event.idEvent}"> <span class="glyphicon glyphicon-minus"
                                                                                                                                                                                    style="margin-right: 20px"></span>Отменить голос</a>
                                                </li>
                                                <li><a  onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent}, ${userId})" id="doAnswer2_${event.idEvent}"> <span class="glyphicon glyphicon-plus"
                                                                                                                                                                                style="margin-right: 20px"></span>Проголосовать</a>
                                                </li>
                                                <%--    <li><a href="#" data-toggle="modal" data-target="#historyChange_${event.idEvent}"> <span class="glyphicon glyphicon-time"
                                                                                                                            style="margin-right: 20px"></span>История
                                                        изменений</a></li>--%>
                                                <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}"> <span class="glyphicon glyphicon-home"
                                                                                                                                             style="margin-right: 20px"></span>К площадке</a>
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
                            <div style="padding-bottom: 12px">
                                <span style="color: black" id="descrEvent_${event.idEvent}"></span>
                            </div>
                            <%--<hr class="hrDescription">--%>
                            <div class="alert alert-danger fade in hide" role="alert" id="alertMax_${event.idEvent}">
                                <button type="button" class="close" onclick="hideButton(${event.idEvent})" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <strong>Warning!</strong> Превышен лимит игроков
                            </div>

                            <div class="list-group" style="margin-bottom: 5px">
                                <a  class="list-group-item "  onclick="handleAnswer(${event.maxCountAnswer}, ${event.idEvent}, ${userId})" id="answerButton_${event.idEvent}">
                                    <c:choose>
                                        <c:when test="${event.maxCountAnswer == 1000}">
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
                                        <a href="toPlayers?eventId=${event.idEvent}&userId=${userId}" id="watch_${event.idEvent}" class="btn hide"> <span
                                                class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span></a>

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
                                            <a href="#" id="${comment.commentId}_del" onclick="deleteComment(${comment.commentId}, ${eventid})" class="btn pull-right hide"  style="padding: 0px;background: white">  <span class="glyphicon glyphicon-remove "></span></a>
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
                                    <a onclick="addIgrok(${event.maxCountAnswer}, ${event.idEvent}, ${userId})" class="btn btn-primary">Добавить</a>
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

        </div>
        <div class="col-sm-2">

        </div>
    </div>
    </div>
</main>


<script>
    $(document).ready(function () {
        $('#all').tooltip({title: "Смотреть всех", container: ".row"});
    });
    var where = '${where}';
    if (where === 'comment') {
        $('#textComment').focus();
    }

    var event = ${eventJson};
    var isWatch = false;
    var userId = "${userId}";
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
                var count = parseInt($('#badge1_'+id).text());
                console.log("badge1 " + $('#badge1_'+id).text())
                if (usersList) {
                    usersList.forEach(function (user, i) {
                        if (user.countFake != 0) {
                            count = (count - 1) + user.countFake;
                            // isFake = true;
                        }
                    });
                }

                $('#badge1_'+ id).text(count);
            } else {
                var count = parseInt($('#badge2_'+id).text().split(' / ')[0]);
                console.log("badge2 " + $('#badge2_'+id).text());
                if (usersList) {
                    usersList.forEach(function (user, i) {
                        if (user.countFake != 0) {
                            count = (count - 1) + user.countFake;

                        }
                    });
                }

                $('#badge2_'+ id).text(count + ' / ' + maxCountAnswer );

                if (count >= event.maxCountAnswer) {
                    $('#answerButton_' + id).addClass('disabled')
                } else {
                    $('#answerButton_' + id).removeClass('disabled');
                }
            }

            var isActive = false;
            usersList.forEach(function (user, i) {
                if (user.userId === userId ) {
                    isActive = true;
                }
            });

            if (isActive) {
                $('#answerButton_'+ id).removeClass('active');
                $('#answerButton_'+ id).css('background','#EAEAEC');

                $('#answerOk_'+ id).removeClass('hide');
                $('#cancelAnswer_'+ id).removeClass('hide');
                $('#doAnswer_'+ id).addClass('hide');
                $('#cancelAnswer2_'+ id).removeClass('hide');
                $('#doAnswer2_'+ id).addClass('hide');
            } else {
                $('#answerButton_'+ id).addClass('active');
                $('#answerButton_'+ id).css('background','');
                $('#answerOk_'+ id).addClass('hide');
                $('#cancelAnswer_'+ id).addClass('hide');
                $('#doAnswer_'+ id).removeClass('hide');
                $('#cancelAnswer2_'+ id).addClass('hide');
                $('#doAnswer2_'+ id).removeClass('hide');
            }


    function sendCommentUser() {
        var text = $('#textComment').val().trim();
        var eventId = '${event.idEvent}';
        var userId = '${userId}';

        if (text.length != 0) {
            $.ajax({
                url: 'sendCommentUser',
                method: 'POST',
                data: ({message: text, eventId: eventId , userId: userId})
            }).then(function (comment) {
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

                    $('#textComment').val('');
                    $('#templateCommentMessage').empty();
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

    var isDisabled = true;
    function handleText() {
        if (isDisabled) {
            var text = $('#textComment').val().split('');
            console.log("description " + text.length);
            if (text.length > 0) {
                $('#send').removeClass('disabled');
            } else {
                $('#send').addClass('disabled');
            }
        }

    }
    setInterval(handleText, 1000);
</script>

</body>
</html>