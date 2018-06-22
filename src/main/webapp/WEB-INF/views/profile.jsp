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
        .premium {
            border: 2px dotted rgba(0, 10, 141, 0.76);

        }
    </style>
</head>
<body >
<nav id="navbarProfile" class="nav  navbar-static-top navbar-default ">
    <div class="container-fluid ">
        <div class="navbar-brand ">
            Мои профиль
        </div>
<%--        <div class="pull-right dropdown" style="padding-top: 10px">
            <c:if test="${allowSendMessage == false}">
                <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"> <span
                        class="glyphicon glyphicon-bell"></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                    <li><a href="#" class="cursorPointer" onclick="getPermissionSendMessages()" id="notification1">Включить уведомления</a></li>
                </ul>
            </c:if>

        </div>--%>
    </div>
</nav>
<main id="bodyProfile">
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
                                    <img class="round" src="${user.photo_100}" alt="Пользователь" width="100"
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

                        <div id="alertSuccess" class="alert alert-success fade in hide" style="padding-top: 10px" role="alert">
                            <button type="button" class="close" onclick="hideButtonAlert('alertSuccess')"
                                    aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <div class="text-center">
                                Подписка успешно оформлена, перезапустите приложение!
                            </div>
                        </div>
                        <div id="alertDanger" class="alert alert-danger fade in hide" role="alert" style="padding-top: 10px">
                            <button type="button" class="close" onclick="hideButtonAlert('alertDanger')"
                                    aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <strong>Произошла ошибка!</strong>
                        </div>
                        <div id="alertWarning" class="alert alert-warning fade in hide" role="alert" style="padding-top: 10px">
                            <button type="button" class="close" onclick="hideButtonAlert('alertWarning')"
                                    aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            Подписка отменена!
                        </div>

                        <div id="premium" class="text-center" style="padding-bottom: 15px">
                            <p>Добавь новую площадку на карту и стань игроком "Премиум" бесплатно</p>
                            <a  href="#" onclick="toPremium()" class="btn btn-success">Стать игроком "Премиум"</a>
                        </div>
                        <div id="premiumCancel" class="text-center" style="padding-bottom: 15px">
                            <a href="#" onclick="orderCancel()" class="btn btn-primary">Отменить подписку "Премиум"</a>
                        </div>
                        <div id="premiumResume" class="text-center " style="padding-bottom: 15px">
                            <p>Добавь новую площадку на карту и стань игроком "Премиум" бесплатно</p>
                            <a href="#" onclick="toPremiumResume()" class="btn btn-success">Стать игроком "Премиум" </a>
                        </div>

                        <div id="tempPremium" class="text-center hide" >
                            <h3><span class="glyphicon glyphicon-star-empty" style="padding-right: 10px"></span> Игрок "Премиум" <span class="glyphicon glyphicon-star-empty" style="padding-left: 10px"></span></h3>
                            <p id="countEnd" style="color: gray">Осталось <c:out value="${user.getCountDaytoEndSubscribeTemp()}"/> д.</p>
                        </div>

                        <div id="premiumDiv" class="hide">
                            <div class="text-center">
                                <h3><span class="glyphicon glyphicon-star-empty" style="padding-right: 10px"></span> Игрок "Премиум" <span class="glyphicon glyphicon-star-empty" style="padding-left: 10px"></span></h3>
                                <p style="color: gray">Опции для проффесионального игрока:</p>
                            </div>
                            <ul class="list-group">
                                <li class="list-group-item borderless">
                                  <span style="padding-right: 10px"><img class="round " src="resources\image\marketing.png" alt="Нет" width="50"
                                                                         height="50"></span>
                                    Нет рекламы в приложении</li>
                                <li class="list-group-item borderless">
                                  <span style="padding-right: 10px"><img class="round " src="resources\image\infinity2.png" alt="Нет" width="50"
                                                                         height="50"></span>
                                    Вступление в группы без ограничений (сейчас 3 макс.)</li>
                                <li class="list-group-item borderless">
                                     <span style="padding-right: 10px"><img class="round " src="resources\image\first.png" alt="Нет" width="50"
                                                                            height="50"></span>
                                    Первым получение уведомлений</li>
                                <li class="list-group-item borderless">
                                     <span style="padding-right: 10px"><img class="round " src="resources\image\stat.png" alt="Нет" width="50"
                                                                            height="50"></span>
                                    Cтатистика по играм</li>
                                <%--         <li class="list-group-item borderless">
                                           <span style="padding-right: 10px"><img class="round premium" src="${user.photo_50}" alt="Премиум" width="50"
                                                                                 height="50"></span>
                                             Иконка "Премиум"</li>--%>
                            </ul>
                            <div class="text-center">
                                <a id="paySubscriptions" href="#" onclick="order()" class="btn btn-primary hide">Приобрести подписку</a>
                                <a id="resumePay" href="#" onclick="orderResume()" class="btn btn-primary hide">Возобновить подписку</a>
                                <p style="color: gray;padding-top: 5px">20 голосов в месяц</p>
                                <p>Или добавьте новую площадку на карту в разделе <span style="color: gray" class="glyphicon glyphicon-search"></span> <span style="color: gray"> Площадки</span>
                                и активируйте подписку "Премиум" на три месяца
                                </p>
                                <a href="#" onclick="hidePremium()" class="btn">Скрыть</a>
                            </div>
                        </div>
                        <div>
                            <div class="pull-right dropdown">
                                <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu3"> <span
                                        class="glyphicon glyphicon-option-vertical"></span></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3">
                                    <li><a class="cursorPointer" onclick="editInfoUser()">
                                        <span class="glyphicon glyphicon-pencil" style="margin-right: 20px"></span>Редактировать
                                    </a></li>
                        <%--            <c:if test="${allowSendMessage == false}">
                                        <li><a href="#" class="cursorPointer" onclick="getPermissionSendMessages()" id="notification2"> <span class="glyphicon glyphicon-bell"
                                                                                                                        style="margin-right: 20px"></span>Включить </a></li>
                                    </c:if>--%>
                                </ul>
                            </div>
                            <div>
                                <h5><span class="glyphicon glyphicon-info-sign"></span>
                                    <span id="informationUser" style="padding-left: 10px;color: gray">
                                         <c:if test="${user.info == null || user.info.length() == 0}">
                                             Напишите о себе
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

                    <div class="list-group" style="margin-bottom: 15px">
                        <c:choose>
                            <c:when test="${user.playgroundIdlList.size() == 0}">
                                <a href="#"  class="list-group-item borderless ">
                                    <span style="padding-right: 5px"> <img src="resources/image/users.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                <c:out value="нет"/>
                            </span>
                               </span>
                                    Группы
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" id="toGroupsUser" class="list-group-item borderless ">
                                    <span style="padding-right: 5px"> <img src="resources/image/users.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                <c:out value="${user.playgroundIdlList.size()}"/>
                            </span>
                                <span class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
                                    Группы
                                </a>

                            </c:otherwise>
                        </c:choose>

                        <c:if test="${user.getSubscriptionStatus() == 'active' || user.getSubscriptionStatus() == 'temp'}">
                        <c:choose>
                            <c:when test="${user.listParticipant.size() == 0}">
                                <a href="#" class="list-group-item borderless">
                                    <span style="padding-right: 5px"> <img src="resources/image/participant.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                <c:out value="нет"/>
                               </span></span>
                                    Участие в играх</a>
                            </c:when>
                            <c:otherwise>
                                <a href="userParticipant?userId=${userId}&playerId=${userId}" class="list-group-item borderless">
                                    <span style="padding-right: 5px"> <img src="resources/image/participant.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                  <c:out value="${user.listParticipant.size()}"/>
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                                    Участие в играх</a>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${countOrganize == 0}">
                                <a href="#" class="list-group-item borderless">
                                    <span style="padding-right: 5px"> <img src="resources/image/organisator.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                 <c:out value="нет"/>
                            </span></span>
                                    Организация игр</a>

                            </c:when>
                            <c:otherwise>
                                <a href="userOrganize?userId=${userId}&playerId=${userId}" class="list-group-item borderless">
                                    <span style="padding-right: 5px"> <img src="resources/image/organisator.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                <c:out value="${countOrganize}"/>
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                                    Организация игр</a>

                            </c:otherwise>
                        </c:choose>
                        </c:if>
                        <a href="#" onclick="showInviteBox()" class="list-group-item borderless">
                            <span style="padding-right: 5px"> <img src="resources/image/invite.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                            Пригласить друзей</a>
                       <%-- <a href="#" onclick="showInstallPushBox()" class="list-group-item borderless">
                            <span style="padding-right: 5px"> <img src="resources/image/mobile.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                            Мобильная версия</a>--%>
                        <a href="https://vk.com/board148660655" target="_blank" class="list-group-item borderless">
                            <span style="padding-right: 5px"> <img src="resources/image/settings.png"  width="25" height="25"></span>
                            <span class="badge" style="background: #ffffff;margin-top: 3px"><span style="color: gray">
                                <span class="glyphicon glyphicon-menu-right"></span></span></span>
                            Связаться с разработчиками</a>

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

    var subscriptionStatus = '${subscriptionStatus}';
    if (device.desktop()) {
        if (subscriptionStatus === 'active') {
            $('#premiumCancel').removeClass('hide');
            $('#premium').addClass('hide');
            $('#premiumResume').addClass('hide');
            $('#tempPremium').addClass('hide');
        } else if (subscriptionStatus === 'resume') {
            $('#premiumCancel').addClass('hide');
            $('#premium').addClass('hide');
            $('#premiumResume').removeClass('hide');
            $('#tempPremium').addClass('hide');
        } else if (subscriptionStatus === 'not') {
            $('#premiumCancel').addClass('hide');
            $('#premium').removeClass('hide');
            $('#premiumResume').addClass('hide');
            $('#tempPremium').addClass('hide');
        } else if (subscriptionStatus === 'temp') {
            $('#premiumCancel').addClass('hide');
            $('#premium').addClass('hide');
            $('#premiumResume').addClass('hide');
            $('#tempPremium').removeClass('hide');
        }
    } else {
        if (subscriptionStatus === 'active') {
            $('#premiumCancel').addClass('hide');
            $('#premium').addClass('hide');
            $('#premiumResume').addClass('hide');
            $('#tempPremium').removeClass('hide');
            $('#countEnd').addClass('hide');
        } else if (subscriptionStatus === 'temp') {
            $('#premiumCancel').addClass('hide');
            $('#premium').addClass('hide');
            $('#premiumResume').addClass('hide');
            $('#tempPremium').removeClass('hide');
        } else {
            $('#premiumCancel').addClass('hide');
            $('#premium').addClass('hide');
            $('#premiumResume').addClass('hide');
            $('#tempPremium').addClass('hide');
        }
    }

    function editInfoUser() {
        $('#divUserInfo').removeClass('hide');
        $('#userInfo').focus();
        if (userInfo.length > 0) {
            var info = $('#informationUser').val();
            $('#userInfo').append(info);
        }
        setTimeout(resizeProfileMain(), 1000);
    }

    function saveInfoUser() {

        var text = $('#userInfo').val().trim();

        var userId = '${userId}';
        if (!text) {
            text = '';
            $('#informationUser').text("Напишите о себе");
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

    function toPremium() {
        $('#premiumDiv').removeClass('hide');
        $('#paySubscriptions').removeClass('hide');
        //$('#premium').addClass('hide');
        resizeProfileMain();
    }
    function toPremiumResume() {
        $('#premiumDiv').removeClass('hide');
        $('#resumePay').removeClass('hide');
        resizeProfileMain();
    }

    function hidePremium() {
        $('#premiumDiv').addClass('hide');
      //  $('#premium').removeClass('hide');
        resizeProfileMain();
    }

    function order() {
        VK.callMethod('showSubscriptionBox', 'create', {item: 'premium'});
    }

    function orderCancel() {
        VK.callMethod('showSubscriptionBox', 'cancel', {subscription_id: '${subscription_id}'});
    }

    function orderResume() {
        VK.callMethod('showSubscriptionBox', 'resume', {subscription_id: '${subscription_id}'});
    }


    function hideButtonAlert(id) {
        $('#' + id).addClass('hide');
    }

    function showInviteBox() {
        VK.callMethod("showInviteBox");
    }
    
    function showInstallPushBox() {
        VK.callMethod("showInstallPushBox");
    }

</script>
</body>
</html>