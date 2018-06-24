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
    <script src="resources/js/media.js"></script>

    <%--   <script src="resources/js/xd_connection.js" type="text/javascript"></script>

       <script src="https://vk.com/js/api/mobile_sdk.js"  type="text/javascript"></script>--%>
    <%--<script type="text/javascript" src="//vk.com/js/api/openapi.js?154"></script>--%>

    <script src="https://ad.mail.ru/static/admanhtml/rbadman-html5.min.js"></script>
    <script src="https://vk.com/js/api/adman_init.js"></script>
    <script src="https://js.appscentrum.com/scr/preroll.js"></script>

    <script type="text/javascript">
        if (device.desktop()) {
            document.write('<script src="resources/js/xd_connection.js"></scr' + 'ipt>');
            document.write('<script src="//vk.com/js/api/openapi.js?154"></scr' + 'ipt>');
        } else {
            document.write('<script src="resources/js/mobile.js"></scr' + 'ipt>');
        }
    </script>
    <script>
        VK.init(function () {
            console.log('vk init');

            VK.addCallback('onSubscriptionSuccess', function (subscription_id) {
                console.log("SubscriptionSuccess: " + subscription_id);
                subscriptionSuccess(subscription_id);
            });
            VK.addCallback('onSubscriptionFail', function () {
                console.log("onSubscriptionFail");
            });
            VK.addCallback('onSubscriptionCancel', function () {
                console.log("onSubscriptionCancel");
                subscriptionCancel();
            });
        }, function () {
            alert('vk init fail \n Напишите нам об ошибке')
            // API initialization failed
            // Can reload page here
        }, '5.74');

    </script>
    <script type="text/javascript">
        var firstStart = '${firstStart}';
        var subscriptionStatus = '${subscriptionStatus}';
        window.addEventListener('load', function () {

            var user_id = '${userId}';
            var isAdmin = ${isAdmin};
            var app_id = 6600445;
            if (!isAdmin) {
                if ((subscriptionStatus === 'not' || subscriptionStatus === 'resume') && device.desktop()) {

                    if (firstStart === 'true') {

                        disableNavigtion(true);
                        $("#event").addClass('hide');
                        admanInit({
                            user_id: user_id,
                            app_id: app_id,
                            type: 'preloader',
                            params: {preview: 1}
                        }, onAdsReady, onNoAds);
                    } else {
                        getMedia();
                        setTimeout(handleReturn(), 1000);
                    }

                } else {
                    handleReturn();
                }
            } else {
                handleReturn();
            }


            function onAdsReady(adman) {
                adman.onStarted(function () {
                    console.log("Adman: Started");
                    admanStat(app_id, user_id);
                });

                adman.onCompleted(function () {
                    console.log("Adman: Completed");
                    $("#event").removeClass('hide');
                    getMedia();
                    setTimeout(handleReturn(), 1000);
                    disableNavigtion(false);

                });
                adman.onSkipped(function () {
                    console.log("Adman: Skipped");
                });
                adman.onClicked(function () {
                    console.log("Adman: Clicked");
                });

                adman.start('preroll');

            };


            function onNoAds() {
                console.log("Adman: No ads");
                getMedia();
                setTimeout(resizeEvent(), 1000);
            };
        });


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

        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    </style>
</head>
<body id="body">
<header>
    <div id="vk_ads_105219"></div>
</header>
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
    var firstStart = '${firstStart}';
    var subscriptionStatus = '${subscriptionStatus}';
    if (device.desktop()) {
        $('#navbarEvents').addClass('hide');
        $('#navbarProfile').addClass('hide');
        $('#navbarGroups').addClass('hide');

        $('#event').css('padding-top', '20px');
    }

    function handleReturn() {
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
            setTimeout('resizeProfileMain()', 500);
        } else if (returnBack === 'start') {
            if (device.desktop()) {
                VK.api("groups.isMember", {
                    "group_id": "148660655",
                    "user_id": "${userId}",
                    "v": "5.73"
                }, function (data) {
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
            setTimeout('resizeProfileMain()', 500);
        }
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
        if (device.desktop()) {
            if (subscriptionStatus === 'active' || subscriptionStatus === 'temp') {
                if (height < 650) {
                    VK.callMethod('resizeWindow', 900, 650);
                } else {
                    VK.callMethod('resizeWindow', 900, height + 50);
                }
            } else {
                if (height < 650) {
                    VK.callMethod('resizeWindow', 900, 650);
                } else {
                    VK.callMethod('resizeWindow', 900, height + 160);
                }

            }
        }
        //VK.callMethod('scrollWindow', 0);
    }

    function resizeGroups() {
        var height = $('#group').height();
        if (device.desktop()) {
            if (subscriptionStatus === 'active' || subscriptionStatus === 'temp') {
                if (height < 650) {
                    VK.callMethod('resizeWindow', 900, 650);
                } else {
                    VK.callMethod('resizeWindow', 900, height + 10);
                }
            } else {
                if (height < 650) {
                    VK.callMethod('resizeWindow', 900, 777);
                } else {
                    VK.callMethod('resizeWindow', 900, height + 140);
                }

            }
        }
    }

    function resizeMain() {
        //VK.callMethod('resizeWindow', 1000, $('#body').height() + 80);
        if (device.desktop()) {
            if (subscriptionStatus === 'active' || subscriptionStatus === 'temp') {
                VK.callMethod('resizeWindow', 900, 650);
            } else {
                VK.callMethod('resizeWindow', 900, 777);
            }
        }
        //VK.callMethod('scrollWindow', 0);
    }

    function hideStartInfo() {
        $('#startInfo').modal('hide');
    }

    function subscriptionSuccess(subscription_id) {
        $('#premiumDiv').addClass('hide');
        $('#premium').addClass('hide');
        $('#premiumCancel').addClass('hide');
        $('#premiumResume').addClass('hide');
        $('#alertSuccess').removeClass('hide');
        $('#alertSuccess').alert();
        resizeProfileMain();
    }

    function subscriptionCancel() {
        $('#premiumDiv').addClass('hide');
        $('#premium').addClass('hide');
        $('#premiumCancel').addClass('hide');
        $('#premiumResume').removeClass('hide');
        $('#alertWarning').removeClass('hide');
        $('#alertWarning').alert();
        resizeProfileMain();
    }

    function resizeProfileMain() {
        var height = $('#prof').height();
        if (device.desktop()) {
            if (subscriptionStatus === 'active' || subscriptionStatus === 'temp') {
                if (height < 650) {
                    VK.callMethod('resizeWindow', 900, 650);
                } else {
                    VK.callMethod('resizeWindow', 900, height + 50);
                }
            } else {
                if (height < 650) {
                    VK.callMethod('resizeWindow', 900, 777);
                } else {
                    VK.callMethod('resizeWindow', 900, height + 160);
                }
            }
        }
    }

    function disableNavigtion(flag) {
        if (flag) {
            $('#events').addClass('disabled');
            $('#searchPlayground').addClass('disabled');
            $('#create').addClass('disabled');
            $('#groups').addClass('disabled');
            $('#profile').addClass('disabled');
        } else {
            $('#events').removeClass('disabled');
            $('#searchPlayground').removeClass('disabled');
            $('#create').removeClass('disabled');
            $('#groups').removeClass('disabled');
            $('#profile').removeClass('disabled');
        }
    }

</script>
</body>
</html>