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
<%--    <nav class="nav navbar-default navbar-static-top  " id="web">
        <div class="container-fluid">--%>
            <div class="btn-group btn-group-justified navStyle" role="group" style="height: 60px">
    <%--            <ul class="nav navbar-nav nav-tabs nav-justified" id="nav" style="height: 60px">
                    <li id="li1"><a href="home?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="events" class="cursorPointer"><span
                            class="glyphicon glyphicon-calendar" aria-hidden=""></span> События</a></li>
                    <li id="li2"><a href="home?where=map&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="searchPlayground" class="cursorPointer"><span class="glyphicon glyphicon-search"
                                                                                      aria-hidden=""></span>
                        Площадки</a></li>
                    <li id="li3"><a id="create" href="create?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" class="cursorPointer"><span class="glyphicon glyphicon-plus-sign"
                                                                      aria-hidden="Создать"></span></a></li>
                    <li id="li4"><a href="home?where=group&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="groups" class="cursorPointer"><span class="glyphicon glyphicon-th-list"
                                                                            aria-hidden=""></span> Группы</a></li>
                    <li id="li5"><a href="home?where=profileMain&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="profile" class="cursorPointer"><span class="glyphicon glyphicon-user"
                                                                             aria-hidden=""></span> Профиль</a></li>
                </ul>--%>
        <a href="home?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="events" class="cursorPointer btn btn-primary" style="font-size: medium"><span
                class="glyphicon glyphicon-calendar" aria-hidden=""></span> События</a>
        <a href="home?where=map&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="searchPlayground" class="cursorPointer btn btn-primary" style="font-size: medium"><span class="glyphicon glyphicon-search"
                                                                                                                                                aria-hidden=""></span>
            Площадки</a>
        <a id="create" href="create?playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" class="cursorPointer btn btn-primary" style="font-size: medium"><span class="glyphicon glyphicon-plus-sign"
                                                                                                                              aria-hidden="Создать"></span></a>
        <a href="home?where=group&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="groups" class="cursorPointer btn btn-primary" style="font-size: medium"><span class="glyphicon glyphicon-th-list"
                                                                                                                                        aria-hidden=""></span> Группы</a>
        <a href="home?where=profileMain&playgroundId=${playgroundId}&sport=${sport}&userId=${userId}" id="profile" class="cursorPointer btn btn-primary" style="font-size: medium"><span class="glyphicon glyphicon-user"
                                                                                                                                               aria-hidden=""></span> Профиль</a>
            </div><!-- /.navbar-collapse -->
<%--        </div><!-- /.container-fluid -->
    </nav>--%>
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