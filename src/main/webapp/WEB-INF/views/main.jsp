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
    <link rel="stylesheet" href="resources/switch/switch.css"/>
    <script src="resources/switch/switch.js"></script>
    <script src="resources/js/device.js"></script>

     <script src="resources/js/xd_connection.js" type="text/javascript"></script>
     <script type="text/javascript" src="//vk.com/js/api/openapi.js?154"></script>

    <script>
        var isSubscribe;
        VK.init(function () {
            console.log('vk init');

            VK.addCallback('onAllowMessagesFromCommunityCancel', function f(location){
                $('#dropdownMenu1').removeClass('hide');
                $('#notification2').removeClass('hide');
            });
        }, function () {
            alert('vk init fail \n Напишите нам об ошибке')
            // API initialization failed
            // Can reload page here
        }, '5.74');

    </script>
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

        .navStyle {
            font-family: "Trebuchet MS", Helvetica, sans-serif;
            letter-spacing: 0px;
            word-spacing: 1.4px;
            color: #000000;
            font-weight: 400;
            text-decoration: none;
            font-style: normal;
            font-variant: normal;
            text-transform: none;
        }

        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    </style>
</head>
<body id="body">
<jsp:include page="navigation.jsp"/>

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
                    <p><span class="glyphicon glyphicon-info-sign" style="padding-right: 3px"></span> Чтобы быть в курсе
                        игр и сборов на площадках, вступай в группы площадок!
                        Для перехода к группе, кликните на карте по маркеру <span
                                class="glyphicon glyphicon-map-marker"></span></p>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <a id="hideStartInfo" onclick="hideStartInfo()" class="btn btn-primary"
                           data-dismiss="modal"><span
                                class="glyphicon glyphicon-search" style="margin-right: 10px"></span>Найти группу</a>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>

<script>

/*    var el = document.querySelector('.checkbox-switch');
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
    });*/
    var returnBack = '${returnBack}';
    var start = '${start}';
    var firstStart = '${firstStart}';
    var isDesktop = device.desktop();
    var sessUser =  ${jsonUser};
    var allPlayUser = sessUser.allPlaygroundUser;

    if (isDesktop) {
        $('#event').css('padding-top', '20px');
    } else {
        $('#web').addClass('hide');
        $('#navbarEvents').removeClass('hide');
        $('#navbarProfile').removeClass('hide');
        $('#navbarGroups').removeClass('hide');
    }

    if (returnBack === 'map' || start === 'true') {
        document.getElementById("event").className = "hide";
        document.getElementById("prof").className = "hide";
        document.getElementById("group").className = "hide";
        document.getElementById("search").className = "";


        $('#searchPlayground').addClass('active');
        $('#events').removeClass('active');
        $('#groups').removeClass('active');
        $('#profile').removeClass('active');
        $('#create').removeClass('active');

        initMap();
        isMapInit = true;
        // Если нет групп и первый заход в приложение
        if (firstStart === 'true') {
            $('#startInfo').modal('show');
        }
        setMobileMap();
        setTimeout('resizeMain()', 1000);

    } else if (returnBack === 'group') {
        document.getElementById("event").className = "hide";
        document.getElementById("prof").className = "hide";
        document.getElementById("group").className = "";
        document.getElementById("search").className = "hide";


        $('#searchPlayground').removeClass('active');
        $('#events').removeClass('active');
        $('#groups').addClass('active');
        $('#profile').removeClass('active');
        $('#create').removeClass('active');
        setTimeout('resizeGroups()', 300);
    } else if (returnBack === 'home') {
        document.getElementById("event").className = "";
        document.getElementById("prof").className = "hide";
        document.getElementById("group").className = "hide";
        document.getElementById("search").className = "hide";


        $('#searchPlayground').removeClass('active');
        $('#events').addClass('active');
        $('#groups').removeClass('active');
        $('#profile').removeClass('active');
        $('#create').removeClass('active');
        setTimeout('resizeEvent()', 300);
    } else if (returnBack === 'profileMain') {
        document.getElementById("event").className = "hide";
        document.getElementById("prof").className = "";
        document.getElementById("group").className = "hide";
        document.getElementById("search").className = "hide";


        $('#searchPlayground').removeClass('active');
        $('#events').removeClass('active');
        $('#groups').removeClass('active');
        $('#profile').addClass('active');
        $('#create').removeClass('active');
        setTimeout('resizeProfileMain()', 500);
    } else {
        setTimeout('resizeEvent()', 500);
    }

VK.api("groups.isMember", {"group_id": "148660655", "user_id": "${userId}", "v": "5.74"}, function (data) {
    var isMember = data.response === 1;
    if (isMember) {
        isSubscribe = true;
        $('#organizeUser').removeClass('hide');
        $('#participantUser').removeClass('hide');
        $('#tempPremium').removeClass('hide');

    } else {
        $('#premium').removeClass('hide');
        isSubscribe = false;
    }
});




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

            $('#searchPlayground').addClass('active');
            $('#events').removeClass('active');
            $('#groups').removeClass('active');
            $('#profile').removeClass('active');
            $('#create').removeClass('active');
        });
    });

    function resizeEvent() {
        //VK.callMethod('resizeWindow', 1000, $('#body').height() + 80);
        var height = $('#event').height();
        if (isDesktop) {
            if (height < 650) {
                VK.callMethod('resizeWindow', 900, 650);
            } else {
                VK.callMethod('resizeWindow', 900, height + 50);
            }
        }
        //VK.callMethod('scrollWindow', 0);
    }

    function resizeGroups() {
        var height = $('#group').height();
        if (isDesktop) {
            if (height < 650) {
                VK.callMethod('resizeWindow', 900, 650);
            } else {
                VK.callMethod('resizeWindow', 900, height + 10);
            }
        }
    }

    function resizeMain() {
        //VK.callMethod('resizeWindow', 1000, $('#body').height() + 80);
        if (isDesktop) {
            VK.callMethod('resizeWindow', 900, 650);
        }
        //VK.callMethod('scrollWindow', 0);
    }

    function hideStartInfo() {
        $('#startInfo').modal('hide');
    }


    function resizeProfileMain() {
        var height = $('#prof').height();
        if (isDesktop) {
            if (height < 650) {
                VK.callMethod('resizeWindow', 900, 650);
            } else {
                VK.callMethod('resizeWindow', 900, height + 50);
            }
        }
    }

</script>
</body>
</html>