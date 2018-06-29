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
<header>

            <div class="btn-group btn-group-justified " role="group" style="height: 60px;box-shadow: 0 0 1px;" id="web">
        <a href="home?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="events" class="cursorPointer btn" style="background: whitesmoke"><span
                class="glyphicon glyphicon-calendar" aria-hidden=""></span> События</a>
        <a href="home?where=map&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="searchPlayground" class="cursorPointer btn " style="background: whitesmoke"><span class="glyphicon glyphicon-search"
                                                                                                                                                aria-hidden=""></span>
            Площадки</a>
        <a id="create" href="create?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" class="cursorPointer btn " style="font-size: medium;background: whitesmoke"><span class="glyphicon glyphicon-plus-sign"
                                                                                                                              aria-hidden="Создать"></span></a>
        <a href="home?where=group&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="groups" class="cursorPointer btn" style="background: whitesmoke"><span class="glyphicon glyphicon-th-list"
                                                                                                                                        aria-hidden=""></span> Группы</a>
        <a href="home?where=profileMain&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="profile" class="cursorPointer btn " style="background: whitesmoke"><span class="glyphicon glyphicon-user"
                                                                                                                                               aria-hidden=""></span> Профиль</a>
            </div>
</header>

<footer class="container-fluid text-center navbar-fixed-bottom" style="margin-bottom: 0px; padding-bottom: 0px; ">
    <div class="row text-center" id="mobile" style="height: 50px; box-shadow: 0 0 3px;">
        <div class="btn-group btn-group-justified">
            <a href="home?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="eventsMobile" class="btn " style="padding-top: 15px;; "><span
                    class="glyphicon glyphicon-calendar " aria-hidden=""><span class="tablet"> События</span></span></a>
            <a href="home?where=map&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="searchPlaygroundMobile" class="btn " style="padding-top: 15px;"><span
                    class="glyphicon glyphicon-search  " aria-hidden=""><span class="tablet"> Площадки</span></span></a>
            <a href="create?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="createMobile" class="btn" style="padding-top: 15px;"><span class="glyphicon glyphicon-plus-sign "
                                                 aria-hidden="Создать"></span></a>
            <a href="home?where=group&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" class="btn" style="padding-top: 15px;"><span
                    class="glyphicon glyphicon-th-list " aria-hidden=""><span class="tablet"> Группы</span></span></a>
            <a href="home?where=profileMain&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="profileMobile" class="btn " style="padding-top: 15px;"><span
                    class="glyphicon glyphicon-user  " aria-hidden=""><span class="tablet"> Профиль</span></span></a>
        </div>
    </div>
</footer>

</body>
</html>