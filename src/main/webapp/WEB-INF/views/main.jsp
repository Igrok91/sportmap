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
    <link rel="stylesheet" href="resources\switch\switch.css"/>
    <script src="resources\switch\switch.js"></script>
    <script src="resources\js\device.js"></script>
    <script src="resources/js/xd_connection.js" type="text/javascript"></script>


    <style>
        .borderless {
            border: 0 none;

            box-shadow: none;

        }

        .cursorPointer {
            cursor: pointer;
        }

        .liOptions {
            margin-bottom: 2px;
            margin-top: 2px;
        }

        .round {
            border-radius: 50%;
        }

        body {
            overflow-y: scroll;
        }

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    </style>
</head>
<body id="body">
<div>

    <div id="event">
        <c:import url="events.jsp"/>
    </div>

    <div id="search" class="hide">
        <%--    <c:import url="searchPlayground.jsp"/>--%>
        <c:import url="map.jsp"/>

    </div>

    <div id="group" class="hide">
        <c:import url="groups.jsp"/>
    </div>

    <div id="prof" class="hide">
        <c:import url="profile.jsp"/>
    </div>

</div>

<div>
    <jsp:include page="navigation.jsp"/>
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title" id="exampleModalLabel">Выберите место игры</h5>
                </div>
                <div class="modal-body">

                    <div class="list-group" id="listGroupsCreate">
                        <c:forEach var="group" items="${allPlaygroundUser}">
                            <a href="create?playgroundId=${group.idplayground}&sport=${group.getSport()}&userId=${userId}"
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

    <div class="modal fade" id="falseModal" tabindex="-1" role="dialog" aria-labelledby="falseModalLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title" id="falseModalLabel"><span class="glyphicon glyphicon-alert"
                                                                       style="margin-right: 10px"></span>У вас нет
                        площадок</h5>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <a id="toSearchPlayground" class="btn btn-primary" data-dismiss="modal"><span
                                class="glyphicon glyphicon-search" style="margin-right: 10px"></span>Перейти в поиск</a>
                    </div>


                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="startInfo" tabindex="-1" role="dialog" aria-labelledby="startInfoLabel"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title text-center" id="startInfoLabel">Привет, ${firstName}!</h4>
                    <p><span class="glyphicon glyphicon-info-sign" style="padding-right: 3px"></span> Чтобы быть в курсе игр и сборов на площадках, вступай в группы площадок!
                        Для перехода к группе, кликните на карте по маркеру <span class="glyphicon glyphicon-map-marker"></span> </p>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <a id="hideStartInfo" onclick="hideStartInfo()" class="btn btn-primary" data-dismiss="modal"><span
                                class="glyphicon glyphicon-search" style="margin-right: 10px"></span>Найти группу</a>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>
<script>
    VK.init(function () {
        console.log('vk init');
        VK.addCallback('onAllowMessagesFromCommunity', function f(location){
            infoAllowMessages(true);
        });
        VK.addCallback('onAllowMessagesFromCommunityCancel', function f(location){
            infoAllowMessages(false);
        });

        VK.addCallback('onSubscriptionSuccess', function(subscription_id) {
           console.log("onSubscriptionSuccess  " + subscription_id);
            subscriptionSuccess(subscription_id);
        });
        VK.addCallback('onSubscriptionFail', function() {
            console.log("onSubscriptionFail");
        });
        VK.addCallback('onSubscriptionCancel', function() {
            console.log("onSubscriptionCancel");
        });
    }, function () {
        alert('vk init fail \n Напишите нам об ошибке')
        // API initialization failed
        // Can reload page here
    }, '5.74');

    function infoAllowMessages(flag) {
        $.ajax({
            url: 'infoAllowMessages?isAllow=' + flag + '&userId=' + ${userId}
        }).then(function (value) {

        });
    }
</script>
<script>

    var el = document.querySelector('.checkbox-switch');
    var el2 = document.querySelector('.checkbox-switch2');
    var mySwitch = new Switch(el, {
        showText: true,
        onText: '',
        offText: ''
    });

    var mySwitch2 = new Switch(el2, {
        showText: true,
        onText: '',
        offText: ''
    });
    var returnBack = '${returnBack}';
    var start = '${start}';
    var startInfo = '${startInfo}';
    if (returnBack === 'map' || start === 'true') {
        document.getElementById("event").className = "hide";
        document.getElementById("prof").className = "hide";
        document.getElementById("group").className = "hide";
        document.getElementById("search").className = "";
        $('#li2').attr('class', 'active');
        $('#li1').attr('class', '');
        $('#li3').attr('class', '');
        $('#li4').attr('class', '');
        $('#li5').attr('class', '');
        setTimeout('resizeMain()', 300);
        initMap();
        isMapInit = true;
        if (startInfo === 'true') {
            $('#startInfo').modal('show');
        }

    } else if (returnBack === 'group') {
        document.getElementById("event").className = "hide";
        document.getElementById("prof").className = "hide";
        document.getElementById("group").className = "";
        document.getElementById("search").className = "hide";
        $('#li2').attr('class', '');
        $('#li1').attr('class', '');
        $('#li3').attr('class', '');
        $('#li4').attr('class', 'active');
        $('#li5').attr('class', '');
        setTimeout('resizeGroups()', 300);
    } else if (returnBack === 'home') {
        document.getElementById("event").className = "";
        document.getElementById("prof").className = "hide";
        document.getElementById("group").className = "hide";
        document.getElementById("search").className = "hide";
        $('#li2').attr('class', '');
        $('#li1').attr('class', 'active');
        $('#li3').attr('class', '');
        $('#li4').attr('class', '');
        $('#li5').attr('class', '');
        setTimeout('resizeEvent()', 300);
    } else if (returnBack === 'profileMain') {
        document.getElementById("event").className = "hide";
        document.getElementById("prof").className = "";
        document.getElementById("group").className = "hide";
        document.getElementById("search").className = "hide";
        $('#li2').attr('class', '');
        $('#li1').attr('class', '');
        $('#li3').attr('class', '');
        $('#li4').attr('class', '');
        $('#li5').attr('class', 'active');
        setTimeout('resizeEvent()', 300);
    } else if (returnBack === 'start') {
        if (device.desktop()) {
            VK.api("groups.isMember", {"group_id": "148660655", "user_id": "${userId}", "v": "5.73"}, function (data) {
                var isMember = data.response === 1;
                if (isMember) {
                    $('#subscribe').remove();
                } else {
                    $('#subscribe').removeClass('hide');
                    var count = 0;
                    while (count < 5) {
                        setTimeout('resizeEvent()', 1000);
                        count++;
                    }
                }
            });
        }
        setTimeout('resizeEvent()', 500);
    } else {
        setTimeout('resizeEvent()', 500);
    }

    var sessUser =  ${jsonUser};
    var allPlayUser = sessUser.allPlaygroundUser;

    if (allPlayUser.length != 0) {
        $('#create').attr('data-target', '#exampleModal');
        $('#createMobile').attr('data-target', '#exampleModal');
    } else {
        $('#create').attr('data-target', '#falseModal');
        $('#createMobile').attr('data-target', '#falseModal');
    }
    $(function () {
        $('#toSearchPlayground').click(function (event) {
            if (!isMapInit) {
                initMap();
                isMapInit = true;
            }
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "";

            $('#li2').attr('class', 'active');
            $('#li1').attr('class', '');
            $('#li3').attr('class', '');
            $('#li4').attr('class', '');
            $('#li5').attr('class', '');
        });
    });

    function resizeEvent() {
        //VK.callMethod('resizeWindow', 1000, $('#body').height() + 80);
        var height = $('#event').height();
        if (height < 650) {
            VK.callMethod('resizeWindow', 900, 650);
        } else {
            VK.callMethod('resizeWindow', 900, height + 10);
        }
        //VK.callMethod('scrollWindow', 0);
    }

    function resizeGroups() {
        var height = $('#group').height();
        if (height < 650) {
            VK.callMethod('resizeWindow', 900, 650);
        } else {
            VK.callMethod('resizeWindow', 900, height + 10);
        }
    }

    function resizeMain() {
        //VK.callMethod('resizeWindow', 1000, $('#body').height() + 80);
        VK.callMethod('resizeWindow', 900, 650);
        //VK.callMethod('scrollWindow', 0);
    }

    function hideStartInfo() {
        $('#startInfo').modal('hide');
    }
    function resizeProfilePremium() {
        var height = $('#premiumDiv').height();
        VK.callMethod('resizeWindow', 900, height + 650);
    }

    function resizeProfile() {
            VK.callMethod('resizeWindow', 900, 650);
    }

    function subscriptionSuccess(subscription_id) {

    }

</script>
</body>
</html>