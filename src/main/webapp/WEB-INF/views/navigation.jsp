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


        @media screen and (max-width: 767px) {

            #mobile {
                visibility: visible;

            }

            #web {
                visibility: collapse;;
            }

        }

        @media screen and (max-width: 550px) {

            #mobile {
                visibility: visible;

            }

            #web {
                visibility: collapse;
            }

            .tablet {
                display: none;
            }

        }

        @media screen and (min-width: 768px) {

            #mobile {
                visibility: collapse;
            }

            #web {
                visibility: visible;

            }

            .navSportMap {
                padding-top: 50px;
            }

        }

        #mobile {
            background-color: #fcfcfc;
        }


    </style>
</head>
<body>
<header>
    <nav class="nav navbar-default navbar-fixed-top  " role="navigation" id="web">
        <div class="container-fluid">
            <div class="btn-group btn-group-justified">
                <ul class="nav navbar-nav nav-tabs nav-justified" id="nav">
                    <li id="li1" class="active "><a id="events" class="cursorPointer"><span
                            class="glyphicon glyphicon-calendar" aria-hidden=""></span> События</a></li>
                    <li id="li2"><a id="searchPlayground" class="cursorPointer"><span class="glyphicon glyphicon-search"
                                                                                      aria-hidden=""></span>
                        Площадки</a></li>
                    <li id="li3"><a id="create" class="cursorPointer" data-toggle="modal"
                                    data-target="#exampleModal"><span class="glyphicon glyphicon-plus-sign"
                                                                      aria-hidden="Создать"></span></a></li>
                    <li id="li4"><a id="groups" class="cursorPointer"><span class="glyphicon glyphicon-th-list"
                                                                            aria-hidden=""></span> Группы</a></li>
                    <li id="li5"><a id="profile" class="cursorPointer"><span class="glyphicon glyphicon-user"
                                                                             aria-hidden=""></span> Профиль</a></li>
                </ul>

            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
</header>

<footer class="container-fluid text-center navbar-fixed-bottom" style="margin-bottom: 0px; padding-bottom: 0px; box-shadow: 0 0 3px;">
    <div class="row text-center" id="mobile" style="height: 50px">
        <div class="btn-group btn-group-justified">
            <a href="#" id="eventsMobile" class="btn " style="padding-top: 15px;; "><span
                    class="glyphicon glyphicon-calendar " aria-hidden=""><span class="tablet"> События</span></span></a>
            <a href="#" id="searchPlaygroundMobile" class="btn " style="padding-top: 15px;"><span
                    class="glyphicon glyphicon-search  " aria-hidden=""><span class="tablet"> Площадки</span></span></a>
            <a href="#" id="createMobile" class="btn" style="padding-top: 15px;" data-toggle="modal"
               data-target="#exampleModal"><span class="glyphicon glyphicon-plus-sign "
                                                 aria-hidden="Создать"></span></a>
            <a href="#" id="groupsMobile" class="btn" style="padding-top: 15px;"><span
                    class="glyphicon glyphicon-th-list " aria-hidden=""><span class="tablet"> Группы</span></span></a>
            <a href="#" id="profileMobile" class="btn " style="padding-top: 15px;"><span
                    class="glyphicon glyphicon-user  " aria-hidden=""><span class="tablet"> Профиль</span></span></a>
        </div>
    </div>
    <%--
        <nav class="nav navbar-default navbar-fixed-bottom  " role="navigation" id="web">
            <div class="container-fluid">
                <div class="btn-group btn-group-justified">
                    <ul class="nav navbar-nav nav-tabs nav-justified" id="nav">
                        <li id="li1" class="active " ><a id="events"><span class="glyphicon glyphicon-calendar" aria-hidden=""></span>  События<span class="sr-only">(current)</span></a></li>
                        <li id="li2"><a id="searchPlayground"><span class="glyphicon glyphicon-search" aria-hidden=""></span>  Площадки</a></li>
                        <li id="li3"><a id="create" data-toggle="modal" data-target="#exampleModal" ><span class="glyphicon glyphicon-plus-sign" aria-hidden="Создать"></span></a></li>
                        <li id="li4"><a id="groups"><span class="glyphicon glyphicon-th-list" aria-hidden=""></span>  Группы</a></li>
                        <li id="li5"><a id="profile"><span class="glyphicon glyphicon-user" aria-hidden=""></span>  Профиль</a></li>
                    </ul>

                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
    --%>


</footer>

<script>
    var isMapInit = false;
    $(function () {
        $('#searchPlayground').click(function (event) {
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
            resizeMain();

        });
    });

    $(function () {
        $('#events').click(function (event) {
            document.getElementById("event").className = "";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "hide";

            $('#li2').attr('class', '');
            $('#li1').attr('class', 'active');
            $('#li3').attr('class', '');
            $('#li4').attr('class', '');
            $('#li5').attr('class', '');
            resizeEvent();
        });
    });

    $(function () {
        $('#groups').click(function (event) {
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

    $(function () {
        $('#profile').click(function (event) {
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "hide";
            $('#li2').attr('class', '');
            $('#li1').attr('class', '');
            $('#li3').attr('class', '');
            $('#li4').attr('class', '');
            $('#li5').attr('class', 'active');
            resizeMain();
        });
    });

    $(function () {
        $('#searchPlaygroundMobile').click(function (event) {
            if (!isMapInit) {
                initMap();
                isMapInit = true;
            }
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "";
        });
    });

    $(function () {
        $('#eventsMobile').click(function (event) {
            document.getElementById("event").className = "";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "hide";
        });
    });

    $(function () {
        $('#groupsMobile').click(function (event) {
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "";
            document.getElementById("search").className = "hide";
        });
    });

    $(function () {
        $('#profileMobile').click(function (event) {
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "hide";
        });
    });

</script>
</body>
</html>