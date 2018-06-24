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

            box-shadow: none;

        }

        textarea {
            resize: none;
        }

        .round {
            border-radius: 50%;
        }


    </style>
</head>
<body id="userBody">
<nav class="nav navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left">
            <a class="navbar-brand btn" id="returnBack"><span class="glyphicon glyphicon-menu-left"
                                                              aria-hidden=""></span></a>
            <div class="navbar-brand ">
                Профиль
            </div>
        </div>

    </div>
</nav>
<main>

    <div class="container-fluid " style="margin-top: 15px">


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="panel borderless">
                    <div class="text-center">
                        <div style="margin-bottom: 5px">
                            <div>
                                <a id="userProfileWeb" class="hide" href="https://vk.com/id${playerId}" target="_blank">
                                    <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="40" height="40"> -->
                                    <img class="round" src="${userPhoto}" alt="Пользователь" width="100"
                                         height="100">
                                </a>
                                <a id="userProfileMobile" class="hide" href="vk://vk.com/id${playerId}" target="_blank">
                                    <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="40" height="40"> -->
                                    <img class="round" src="${userPhoto}" alt="Пользователь" width="100"
                                         height="100">
                                </a>
                            </div>


                            <div style="padding-top: 10px">
                                <h4>${userfirstName} ${userlastName}</h4>
                                <!--    <span  class="glyphicon glyphicon-star-empty" ></span><span style="color: gray; margin-right: 15px" > 105 </span>
                                   <span style="color: gray"> 3 место</span> -->
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div>
                            <h5><span class="glyphicon glyphicon-info-sign"></span>
                                <span id="informationUser" style="color: gray; padding-left: 10px; padding-right: 12px">
                                           <c:if test="${userInfo == null || userInfo.length() == 0}">
                                               нет информации
                                           </c:if>

                                    </span>

                            </h5>
                        </div>


                    </div>
                    <div class="list-group">
                        <c:choose>
                            <c:when test="${countGroup == 0}">
                                <a href="#" class="list-group-item borderless">
                                    <span style="padding-right: 5px"> <img src="resources/image/users.png" width="25"
                                                                           height="25"></span>
                                    <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="нет"/>
                            </span>
                               </span>
                                    Группы
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="groupsUser?userId=${userId}&where=profile&playerId=${playerId}"
                                   class="list-group-item borderless">
                                    <span style="padding-right: 5px"> <img src="resources/image/users.png" width="25"
                                                                           height="25"></span>
                                    <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="${countGroup}"/>
                            </span>
                                <span class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
                                    Группы
                                </a>

                            </c:otherwise>
                        </c:choose>
                        <c:if test="${subscriptionStatus == 'active' || user.getSubscriptionStatus() == 'temp'}">
                            <c:choose>
                                <c:when test="${countParticipant == 0}">
                                    <a href="#" class="list-group-item borderless">
                                        <span style="padding-right: 5px"> <img src="resources/image/participant.png"
                                                                               width="25" height="25"></span>
                                        <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="нет"/>
                               </span></span>
                                        Участие в играх</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="userParticipant?userId=${userId}&where=profile&playerId=${playerId}"
                                       class="borderless list-group-item">
                                        <span style="padding-right: 5px"> <img src="resources/image/participant.png"
                                                                               width="25" height="25"></span>
                                        <span class="badge" style="background: #ffffff"><span style="color: gray">
                                  <c:out value="${countParticipant}"/>
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                                        Участие в играх</a>
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${countOrganize == 0}">
                                    <a href="#" class="list-group-item borderless">
                                        <span style="padding-right: 5px"> <img src="resources/image/organisator.png"
                                                                               width="25" height="25"></span>
                                        <span class="badge" style="background: #ffffff"><span style="color: gray">
                                 <c:out value="нет"/>
                            </span></span>
                                        Организация игр</a>

                                </c:when>
                                <c:otherwise>
                                    <a href="userOrganize?userId=${userId}&where=profile&playerId=${playerId}"
                                       class=" borderless list-group-item">
                                        <span style="padding-right: 5px"> <img src="resources/image/organisator.png"
                                                                               width="25" height="25"></span>
                                        <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="${countOrganize}"/>
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                                        Организация игр</a>

                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>

                    <div style="padding: 20px">
                        <!-- <a href="#" class="btn"><span class="glyphicon glyphicon-th-list"></span> Общий рейтинг</a>   -->
                    </div>


                </div>


                <div class="col-sm-2">

                </div>

            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="groupModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title">Группы</h5>
                </div>
                <div class="modal-body">

                    <div class="list-group">
                        <c:forEach var="group" items="${allPlaygroundUser}">
                            <a href="group?playgroundId=${group.idplayground}&sport=${group.getSport()}"
                               class="list-group-item borderless">
                                <div class="media">
                                    <div class="pull-left">
                                        <c:if test="${group.getSport() == 'Футбол'}">
                                            <img class="media-object" src="resources/image/стадион3.png" alt="Футбол"
                                                 width="40"
                                                 height="40"/>
                                        </c:if>
                                        <c:if test="${group.getSport() == 'Баскетбол'}">
                                            <img class="media-object" src="resources/image/площадка2.png"
                                                 alt="Баскетбол" width="40"
                                                 height="40"/>
                                        </c:if>
                                        <c:if test="${group.getSport() == 'Волейбол'}">
                                            <img class="media-object" src="resources/image/спортивная-сетка.png"
                                                 alt="Волейбол" width="40"
                                                 height="40"/>
                                        </c:if>

                                    </div>


                                    <div class="media-body ">
                                        <h4 class="media-heading"
                                            style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">${group.name}</h4>
                                        <span style="color: gray">${group.getSport()}</span>
                                        <hr>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>

    var back = '${where}';
    var returnBack;
    var isDesktop = device.desktop();
    if (back === 'events') {
        returnBack = 'home?&userId=' + ${userId};
    } else if (back === 'event') {
        returnBack = 'event?eventId=' + ${eventId} +'&userId=' + ${userId};
    } else if (back === 'playground') {
        returnBack = 'playground?playgroundId=' + ${playgroundId} +'&userId=' + ${userId};
    }

    if (isDesktop) {
        $('#userProfileWeb').removeClass('hide');
    } else {
        $('#userProfileMobile').removeClass('hide');
    }

    $('#returnBack').attr('href', returnBack);

    var userInfo = ${userInfoJson};
    if (userInfo.length > 0) {
        var description = userInfo.split('\n');
        $('#informationUser').html('');
        description.forEach(function (message, i) {
            $('#informationUser').append(message);
            $('#informationUser').append('<br>');
        });
    }


    function resizeUser() {
        if (device.desktop()) {
            var height = $('#userBody').height();
            if (height < 650) {
                VK.callMethod('resizeWindow', 900, 650);
            } else {
                VK.callMethod('resizeWindow', 900, height + 10);
            }
        }
    }

    setTimeout('resizeUser()', 300);
    if (device.desktop()) {
        VK.callMethod("scrollWindow", 0, 500);
    }
</script>
</body>
</html>