<%--
  Created by IntelliJ IDEA.
  User: Igor
  Date: 03.04.2017
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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


        }
        hr {
            margin-top: 5px;
            margin-bottom: 0px;
        }

    </style>
</head>
<body>

<nav class="nav  navbar-static-top navbar-default " >
    <div class="container-fluid ">
        <div class="navbar-brand ">
            Мои группы
        </div>
    </div>
</nav>
<main >

    <div class="container-fluid " >


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <c:choose>
                    <c:when test="${allPlaygroundUser.size() == 0}">
                        <div class="text-center" style="padding-top: 20px">
                            <span style="color: gray">У вас пока нет групп <br> Чтобы вступить в группу перейдите в посик <span class="glyphicon glyphicon-search" aria-hidden=""></span></span>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="list-group" id="listGroupsUser" style="padding-top: 7px">
                            <c:forEach var="group" items="${allPlaygroundUser}">
                                <a href="group?playgroundId=${group.idplayground}&sport=${group.getSport()}&userId=${userId}" class="list-group-item borderless">
                                    <div class="media">
                                        <div class="pull-left">
                                            <c:if test="${group.getSport() == 'Футбол'}">
                                                <img class="media-object" src="resources/image/стадион3.png" alt="Футбол" width="50"
                                                     height="50"/>
                                            </c:if>
                                            <c:if test="${group.getSport() == 'Баскетбол'}">
                                                <img class="media-object" src="resources/image/площадка2.png" alt="Баскетбол" width="50"
                                                     height="50"/>
                                            </c:if>
                                            <c:if test="${group.getSport() == 'Волейбол'}">
                                                <img class="media-object" src="resources/image/спортивная-сетка.png" alt="Волейбол" width="50"
                                                     height="50"/>
                                            </c:if>

                                        </div>


                                        <div class="media-body " style="padding-left: 10px">
                                            <h4 class="media-heading"
                                                style="padding-bottom: 0px; margin-bottom: 0px; padding-top: 5px">${group.getName()}</h4>
                                            <span style="color: gray">${group.getSport()}</span>
                                            <%--<hr>--%>
                                        </div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>


            </div>


            <div class="col-sm-8">

            </div>

        </div>
    </div>

</main>
<script src="https://vk.com/js/api/xd_connection.js?2"  type="text/javascript"></script>
<script>





        function getElementList(allPlaygroundUser, index, href) {
            var a = document.createElement('a');
            a.href = href + "?playgroundId=" + allPlaygroundUser.id + "&sport=" + allPlaygroundUser.sport;
            a.id = allPlaygroundUser.id;
            a.className = 'list-group-item borderless ';




            var divMedia = document.createElement('div');
            divMedia.className = 'media';

            var divImage = document.createElement('div');
            divImage.className = 'pull-left';
            var image = document.createElement('img');
            if (allPlaygroundUser.sport === 'Футбол') {
                image.src = 'resources/image/стадион3.png';
            }
            if (allPlaygroundUser.sport === 'Баскетбол') {
                image.src = 'resources/image/площадка2.png';
            }
            if (allPlaygroundUser.sport === 'Волейбол') {
                image.src = 'resources/image/спортивная-сетка.png';
            }
            image.width = '40';
            image.height = '40';
            image.className = 'media-object';
            divImage.appendChild(image);

            var divBody = document.createElement('div');
            divBody.className = 'media-body';
            var h4 = document.createElement('h4');
            h4.className = 'media-heading';
            h4.appendChild(document.createTextNode(allPlaygroundUser.namePlayground));
            var span = document.createElement('span');
            span.style.color = 'gray';
            span.appendChild(document.createTextNode(allPlaygroundUser.sport));
            var hr = document.createElement('hr');
            divBody.appendChild(h4);
            divBody.appendChild(span);
            divBody.appendChild(hr);

            divMedia.appendChild(divImage);
            divMedia.appendChild(divBody);
            a.appendChild(divMedia);
            return a;
        }


</script>
</body>
</html>