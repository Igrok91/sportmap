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
        .borderless {
            border: 0 none;

            box-shadow: none;

        }

        textarea {
            resize: none;
        }


    </style>
</head>
<body>
<nav class="nav  navbar-static-top navbar-default ">
    <div class="container-fluid ">
        <div class="navbar-brand ">
            Мои профиль
        </div>
        <div class="pull-right dropdown" style="padding-top: 10px">
            <c:if test="${allowSendMessage == false}">
                <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"> <span
                        class="glyphicon glyphicon-bell"></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                    <li><a href="#" onclick="getPermissionSendMessages()" id="notification1">>Включить уведомления</a></li>
                </ul>
            </c:if>

        </div>
    </div>
</nav>
<main>

    <div class="container-fluid " style="margin-top: 20px">


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="panel borderless">
                    <div class="text-center">
                        <div style="margin-bottom: 5px">
                            <div>
                                <a  href="https://vk.com/id${userId}" target="_blank" >
                                    <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="40" height="40"> -->
                                    <img class="round" src="${user.photo_100}" alt="Футбол" width="100"
                                         height="100">
                                </a>
                            </div>


                            <div  style="padding-top: 10px">
                                <h4>${user.firstName} ${user.lastName}</h4>
                                <!--    <span  class="glyphicon glyphicon-star-empty" ></span><span style="color: gray; margin-right: 15px" > 105 </span>
                                   <span style="color: gray"> 3 место</span> -->
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div>
                            <div class="pull-right dropdown">
                                <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu3"> <span
                                        class="glyphicon glyphicon-option-vertical"></span></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3">
                                    <li><a onclick="editInfoUser()">
                                        <span class="glyphicon glyphicon-pencil" style="margin-right: 20px"></span>Редактировать
                                    </a></li>
                                    <c:if test="${allowSendMessage == false}">
                                        <li><a href="#" onclick="getPermissionSendMessages()" id="notification2"> <span class="glyphicon glyphicon-bell"
                                                                                                                        style="margin-right: 20px"></span>Включить </a></li>
                                    </c:if>
                                </ul>
                            </div>
                            <div>
                                <h5><span class="glyphicon glyphicon-info-sign"></span>
                                    <span id="informationUser" style="padding-left: 10px">
                                         <c:if test="${user.info == null || user.info.length() == 0}">
                                             нет информации
                                         </c:if>
                                    </span>

                                </h5>
                            </div>

                            <div class="container-fluid hide" id="divUserInfo">
                                <div class="row ">
                                    <div>
                                        <textarea type="text" id="userInfo"
                                                  style="padding-bottom: 15px; margin-bottom: 0px; "
                                                  class="form-control borderless " rows="1"
                                                  placeholder="" aria-label=""></textarea>
                                        <hr style="padding: 0px; margin:0px">
                                    </div>
                                    <div style="padding-top: 10px">
                                        <a href="#" onclick="saveInfoUser()" class="btn  pull-right" id="send">
                                            <span class="glyphicon glyphicon-floppy-save " aria-hidden=""></span>
                                            Сохранить</a>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="list-group">
                        <c:choose>
                            <c:when test="${user.playgroundIdlList.size() == 0}">
                                <a href="#"  class="list-group-item borderless ">
                            <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="нет"/>
                            </span>
                               </span>
                                    Группы
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" id="toGroupsUser" class="list-group-item borderless ">
                            <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="${user.playgroundIdlList.size()}"/>
                            </span>
                                <span class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
                                    Группы
                                </a>

                            </c:otherwise>
                        </c:choose>


                        <c:choose>
                            <c:when test="${user.listParticipant.size() == 0}">
                                <a href="#" class="list-group-item borderless">
                            <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="нет"/>
                               </span></span>
                                    Участие в играх</a>
                            </c:when>
                            <c:otherwise>
                                <a href="userParticipant?userId=${userId}&playerId=${userId}" class="list-group-item borderless">
                            <span class="badge" style="background: #ffffff"><span style="color: gray">
                                  <c:out value="${user.listParticipant.size()}"/>
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                                    Участие в играх</a>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${countOrganize == 0}">
                                <a href="#" class="list-group-item borderless">
                            <span class="badge" style="background: #ffffff"><span style="color: gray">
                                 <c:out value="нет"/>
                            </span></span>
                                    Организация игр</a>

                            </c:when>
                            <c:otherwise>
                                <a href="userOrganize?userId=${userId}&playerId=${userId}" class="list-group-item borderless">
                            <span class="badge" style="background: #ffffff"><span style="color: gray">
                                <c:out value="${countOrganize}"/>
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                                    Организация игр</a>

                            </c:otherwise>
                        </c:choose>

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
</main>
<script>
    var jsonUser = ${jsonUser};
    var userInfo = jsonUser.info;
    if (userInfo.length > 0) {
        var description = userInfo.split('\n');
        $('#informationUser').html('');
        description.forEach(function (message, i) {
            $('#informationUser').append(message);
            $('#informationUser').append('<br>');
        });
    }

    function editInfoUser() {
        $('#divUserInfo').removeClass('hide');
        $('#userInfo').focus();
        if (userInfo.length > 0) {
            var info = $('#informationUser').val();
            $('#userInfo').append(info);
        }
    }

    function saveInfoUser() {

        var text = $('#userInfo').val().trim();

        var userId = '${userId}';
        if (!text) {
            text = '';
            $('#informationUser').text("нет информации");
        } else {
            var description = text.split('\n');
            $('#informationUser').html('');
            description.forEach(function (message, i) {
                $('#informationUser').append(message);
                $('#informationUser').append('<br>');
            });
        }

        $.ajax({
            url: 'editUserInfo',
            method: "POST",
            data: ({userInfo: text, userId: userId})
        }).then(function () {

            $('#divUserInfo').addClass('hide');
        });
    }

    $(function () {
        $('#toGroupsUser').click(function (event) {
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "";
            document.getElementById("search").className = "hide";

            $('#li2').attr('class', '');
            $('#li1').attr('class', '');
            $('#li3').attr('class', '');
            $('#li4').attr('class', 'active');
            $('#li5').attr('class', '');
            resizeGroups();
        });
    });

    function getPermissionSendMessages() {
        $('#notification1').addClass('hide');
        $('#notification2').addClass('hide');
        VK.callMethod("showAllowMessagesFromCommunityBox");
    }


</script>
</body>
</html>