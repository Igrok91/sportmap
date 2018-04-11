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

        .hrDescription {
            margin-top: 9px;
            margin-bottom: 9px;
        }
        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
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


<main id="mainPlayground">

    <div class="container " style="margin-top: 15px">


        <div class="row content" >
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="panel " id="panelGroup" >
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

                                    <a href="create?playgroundId=${playgroundId}&sport=${sport}" class="btn btn-primary" id="goGame"
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
                    <div class="list-group" >
                        <c:choose>
                            <c:when test="${players.size() == 0}">
                                <a class="list-group-item ">
                                     <span class="badge" style="background: #ffffff"><span style="color: gray" id="players"><c:out
                                             value="${players.size()}"/></span> </span>
                                    Участники
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a class="list-group-item " data-toggle="modal" data-target="#playersModal">
                                     <span class="badge" style="background: #ffffff"><span style="color: gray" id="players"><c:out
                                             value="${players.size()}"/></span> <span class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
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
                <c:when test="${listEvents.size() == 0}">
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
                                    value="${listEvents.size()}"/></span> <span class="glyphicon glyphicon-menu-down"
                                                                                style="color: gray"></span></span>
                            События

                        </div>
                        <hr style="padding-top: 0px; margin-top: 0px; padding-bottom: 0px;margin-bottom: 0px">
                    </c:if>
                        <div class="" style="background: white;padding-left: 15px; padding-bottom: 15px;padding-top: 15px">

                            <a class="pull-left" href="#">
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                <img id="${event.idEvent}_imgPlayground" class="media-object"
                                     src="resources/image/foot2.png"
                                     alt="Баскетбол" width="30" height="30">
                            </a>


                            <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                                <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu7"> <span
                                        class="glyphicon glyphicon-option-vertical"></span></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu7">
                                    <c:choose>
                                        <c:when test="${event.userIdCreator == userId}">
                                            <c:set var="playgroundId" value="${event.playgroundId}"/>
                                            <c:set var="sport" value="${event.sport}"/>
                                            <li><a href="#"
                                                   onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})"
                                                   id="cancelAnswer_${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-minus"
                                                    style="margin-right: 20px"></span>Отменить голос</a>
                                            </li>
                                            <li><a href="#"
                                                   onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})"
                                                   id="doAnswer_${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-plus"
                                                    style="margin-right: 20px"></span>Проголосовать</a>
                                            </li>
                                            <li><a href="#" data-toggle="modal"
                                                   data-target="#historyChange_${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-time"
                                                    style="margin-right: 20px"></span>История
                                                изменений</a></li>
                                            <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}"> <span
                                                    class="glyphicon glyphicon-home"
                                                    style="margin-right: 20px"></span>К площадке</a>
                                            </li>
                                            <li><a href="event?eventId=${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-share-alt"
                                                    style="margin-right: 20px"></span>К записи</a>
                                            </li>


                                            <li>
                                                <a href="create?playgroundId=${playgroundId}&sport=${sport}&eventId=${event.idEvent}">
                                                    <span class="glyphicon glyphicon-pencil"
                                                          style="margin-right: 20px"></span>Редактировать
                                                </a></li>
                                            <li><a href="deleteGame?eventId=${event.idEvent}"><span
                                                    class="glyphicon glyphicon-off"
                                                    style="margin-right: 20px"></span>Завершить
                                                опрос</a></li>

                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="playgroundId" value="${event.playgroundId}"/>
                                            <c:set var="sport" value="${event.sport}"/>
                                            <li><a href="#"
                                                   onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})"
                                                   id="cancelAnswer2_${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-minus"
                                                    style="margin-right: 20px"></span>Отменить голос</a>
                                            </li>
                                            <li><a href="#"
                                                   onclick="handleAnswerMain(${event.maxCountAnswer}, ${event.idEvent})"
                                                   id="doAnswer2_${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-plus"
                                                    style="margin-right: 20px"></span>Проголосовать</a>
                                            </li>
                                            <li><a href="#" data-toggle="modal"
                                                   data-target="#historyChange_${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-time"
                                                    style="margin-right: 20px"></span>История
                                                изменений</a></li>
                                            <li><a href="playground?playgroundId=${playgroundId}&sport=${sport}"> <span
                                                    class="glyphicon glyphicon-home"
                                                    style="margin-right: 20px"></span>К площадке</a>
                                            </li>
                                            <li><a href="event?eventId=${event.idEvent}"> <span
                                                    class="glyphicon glyphicon-share-alt"
                                                    style="margin-right: 20px"></span>К записи</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>

                                </ul>
                            </div>
                            <div class="media-body" style="padding-left: 10px">

                                <h5 class="media-heading"
                                    style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">${event.userFirtsNameCreator} ${event.userLastNameCreator}</h5>


                                <span style="color: gray">${event.date} сегодня в 13:34</span>

                            </div>
                        </div>
                        <%--<hr style="margin-bottom: 9px; margin-top: 0px">--%>
                        <div>
                            <span style="color: black; padding-left: 17px; padding-right: 17px">${event.description}</span>
                        </div>
                        <%--<hr class="hrDescription">--%>

                        <div class="panel-body" style="padding-bottom: 0px">
                            <div class="list-group" style="margin-bottom: 5px">
                                <a class="list-group-item "
                                   onclick="handleAnswer(${event.maxCountAnswer}, ${event.idEvent})"
                                   id="answerButton_${event.idEvent}">
                                    <c:choose>
                                        <c:when test="${event.maxCountAnswer == 0}">
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
                                                    <a href="user?userId=${user.userId}" class="btn"
                                                       style="padding: 0px"
                                                       id="${user.userId}_imgUser_${event.idEvent}_fake">
                                                                    <span id="${user.userId}_add_${event.idEvent}"
                                                                          count="${user.countFake}">+${user.countFake}</span>

                                                    </a>

                                                </c:when>
                                                <c:otherwise>
                                                    <a href="user?userId=${user.userId}" class="btn"
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

                                        <c:if test="${event.userList.size() > 7}">
                                            <a href="#" class="btn" style="color: gray"> <span
                                                    class="glyphicon glyphicon-eye-open"
                                                    style="margin-right: 5px"></span>Все</a>
                                        </c:if>

                                    </div>

                                </div>


                            </div>

                        </div>

                        <a href="event?eventId=${event.idEvent}" class="btn"
                           style=" margin-left: 5px;margin-top: 4px; margin-bottom: 4px" id="commentEvents"><span
                                class="glyphicon glyphicon-comment " aria-hidden="Комментировать"
                                style="color: #77A5C5;margin-right: 5px"></span>
                            <c:if test="${event.commentsList.size() > 0}">
                                ${event.commentsList.size()}
                            </c:if></a>
                        <a href="#" class="btn"
                           style=" margin-left: 5px; margin-top: 4px;margin-bottom: 4px"><span
                                class="glyphicon glyphicon-bullhorn " aria-hidden="Комментировать"
                                style="color: #77A5C5;margin-right: 5px"></span>Поделиться</a>


                    </div>
                    </c:forEach>
                    </c:otherwise>
                    </c:choose>


                    <div class="col-sm-2">

                    </div>

                </div>
            </div>
        </div>
</main>
<!-- Modal -->
<div class="modal fade" id="playersModal" tabindex="-1" role="dialog" aria-labelledby="playersModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">

                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h5 class="modal-title" id="playersModalLabel">Участники</h5>
            </div>
            <div class="modal-body">
     
                        <div class="list-group" id="listGroupsUser">
                            <c:forEach var="user" items="${players}">
                                <a href="toUser?userId=${user.userId}" class="list-group-item borderless" id="${user.userId}">
                                    <div class="media">
                                        <div class="pull-left">
                                            <img class="media-object" src="resources/image/стадион3.png" alt="Футбол" width="40"
                                                 height="40"/>
                                        </div>


                                        <div class="media-body ">
                                                <%--       <h4 class="media-heading"
                                                           style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">${user.firstName}</h4>--%>
                                            <span style="color: gray">${user.firstName} ${user.lastName}</span>
                                                <%--<hr>--%>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>

                        </div>

            </div>
        </div>
    </div>
</div>
<script src="https://vk.com/js/api/xd_connection.js?2"  type="text/javascript"></script>
<script>




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
    var returnBack = 'home?where=' + '${returnBack}' + '&playgroundId=' + '${playgroundId}' + '&sport=' + sp;
    $('#returnBack').attr('href', returnBack);

    function handleGroup() {
        var playgroundId = '${playgroundId}';
        var sport = '${sport}';
        $.ajax({
            url: 'handleGroup?playgroundId=' + playgroundId + '&sport=' + sport
        }).then(function (value) {
            if (value == true) {
                $('#exitFromGroup').removeClass('hide');
                $('#enterToGroup').addClass('hide');
                $('#goGame').removeClass("disabled");

                var count2 = parseInt($('#players').text());
                count2 = count2 + 1;
                $('#players').text(count2);

            } else {
                $('#exitFromGroup').addClass('hide');
                $('#enterToGroup').removeClass('hide');
                $('#goGame').addClass("disabled");

                var count2 = parseInt($('#players').text());
                count2 = count2 - 1;
                $('#players').text(count2);
            }
        });
    }
    setTimeout('resizePlayground()', 500);
    function resizePlayground() {
        var  height =  $('#mainPlayground').height();
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
</script>
</body>
</html>