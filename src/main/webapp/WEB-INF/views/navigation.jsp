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
                visibility: collapse;
                height: 0px;
            }

        }

        @media screen and (max-width: 550px) {

            #mobile {
                visibility: visible;

            }

            #web {
                visibility: collapse;
                height: 0px;
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
<%--#f2f6f4--%>
<header >
            <div class="btn-group btn-group-justified " role="group" style="height: 60px;box-shadow: 0 0 1px;" id="web">
                <a id="events" class="cursorPointer btn active" style="background: whitesmoke"><span
                        class="glyphicon glyphicon-calendar" aria-hidden=""></span> События</a>
                <a id="searchPlayground" class="cursorPointer btn" style="background: whitesmoke"><span class="glyphicon glyphicon-search" aria-hidden=""></span>
                    Площадки</a>
                 <a id="create" class="cursorPointer btn " data-toggle="modal"
                   data-target="#exampleModal" style="font-size: medium;background: whitesmoke"><span class="glyphicon glyphicon-plus-sign"
                                         aria-hidden="Создать"></span></a>
                <a  id="groups" class="cursorPointer btn " style="background: whitesmoke" ><span class="glyphicon glyphicon-th-list" aria-hidden=""></span> Группы</a>
                <a id="profile" class="cursorPointer btn " style="background: whitesmoke"><span class="glyphicon glyphicon-user" aria-hidden=""></span> Профиль</a>

            </div>
</header>

<footer class="container-fluid text-center navbar-fixed-bottom" style="margin-bottom: 0px; padding-bottom: 0px; ">
    <div class="row text-center" id="mobile" style="height: 50px; box-shadow: 0 0 3px;">
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


            $('#searchPlayground').addClass('active');
            $('#events').removeClass('active');
            $('#groups').removeClass('active');
            $('#profile').removeClass('active');
            $('#create').removeClass('active');
            resizeMain();

        });
    });

    $(function () {
        $('#events').click(function (event) {
            document.getElementById("event").className = "";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "hide";


            $('#searchPlayground').removeClass('active');
            $('#events').addClass('active');
            $('#groups').removeClass('active');
            $('#profile').removeClass('active');
            $('#create').removeClass('active');
            resizeEvent();
        });
    });

    $(function () {
        $('#groups').click(function (event) {
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "hide";
            document.getElementById("group").className = "";
            document.getElementById("search").className = "hide";

            $('#searchPlayground').removeClass('active');
            $('#events').removeClass('active');
            $('#groups').addClass('active');
            $('#profile').removeClass('active');
            $('#create').removeClass('active');
            resizeGroups();
        });
    });

    $(function () {
        $('#profile').click(function (event) {
            document.getElementById("event").className = "hide";
            document.getElementById("prof").className = "";
            document.getElementById("group").className = "hide";
            document.getElementById("search").className = "hide";

            $('#premiumDiv').addClass('hide');

            $('#searchPlayground').removeClass('active');
            $('#events').removeClass('active');
            $('#groups').removeClass('active');
            $('#profile').addClass('active');
            $('#create').removeClass('active');
            resizeProfileMain();
        });
    });

    $(function () {
        $('#searchPlaygroundMobile').click(function (event) {
            if (!isMapInit) {
                initMap();
                isMapInit = true;
            }
            setMobileMap();
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