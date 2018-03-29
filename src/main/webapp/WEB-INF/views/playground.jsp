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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>

        /* Set black background color, white text and some padding */




    </style>
</head>
<body>
<nav class="nav  navbar-static-top navbar-default" >
    <div class="container-fluid ">
        <div class="pull-left" >
            <a class="navbar-brand btn"  id="returnBack"><span class="glyphicon glyphicon-menu-left" aria-hidden=""></span></a>
        </div>
    </div>
</nav>
<main >

    <div class="container " style="margin-top: 15px">


        <div class="row content">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">
                <div class="panel " id="panelGroup">
                    <div class="panel-heading " >
                        <div>
                            <a class="pull-left" href="#" >
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                <img class="media-object" src="resources/image/playbasket.png" alt="Баскетбол" width="40" height="40" id="imageGroup" >
                            </a>



                            <div class="media-body" style="padding-left: 10px">

                                <h4 class="media-heading" style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">
                                   ${namePlayground}</h4>



                                <span  style="color: gray">${sport}</span>

                            </div>

                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="text-center">
                                    <c:choose>
                                        <c:when test="${isParticipant == true}">
                                            <a onclick="handleGroup()" id="exitFromGroup" class="btn btn-default" style="margin:3px">Выйти из группы</a>
                                            <a onclick="handleGroup()" id="enterToGroup" class="btn btn-primary hide" style="margin:3px">Вступить в группу</a>
                                        </c:when>
                                        <c:otherwise>
                                            <a onclick="handleGroup()" id="exitFromGroup" class="btn btn-default hide" style="margin:3px">Выйти из группы</a>
                                            <a onclick="handleGroup()" id="enterToGroup" class="btn btn-primary " style="margin:3px">Вступить в группу</a>
                                        </c:otherwise>
                                    </c:choose>

                                    <a href="create?playgroundId=${playgroundId}&sport=${sport}" class="btn btn-primary" style="margin:3px">Позвать на игру</a>
                                </div>


                            </div>
                        </div>



                        <h5><span class="glyphicon glyphicon-info-sign"></span>  Информация</h5>
                        <div >
                            <div  style="padding-bottom: 2px">
                                <span style="color: gray;">Aдрес: ${street}, ${house} </span>

                            </div>
                        </div>

                    </div>
                    <div class="list-group" style="padding-bottom: 1px">
                        <a href="#" class="list-group-item ">
                            <span class="badge" style="background: #ffffff"><span style="color: gray"><c:out value="${players.size()}"/></span> <span class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
                            Участники
                        </a>
                        <a href="#" class="list-group-item">
                            <span class="badge" style="background: #ffffff"><span style="color: gray"><c:out value="${plays.size()}"/></span> <span class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
                            События </a>

                    </div>
                    <div class="container-fluid">
                        <div class="row text-center" >
                            <a href="#" class="btn" style=" margin-left: 5px;margin-top: 4px; margin-bottom: 4px"><span class="glyphicon  glyphicon-share-alt"  aria-hidden="Комментировать" style="margin-right: 5px"></span> Пригласить в группу</a>
                            <!--   <a href="#" class="btn " ><span class="glyphicon glyphicon-th-list"></span> Рейтинг</a> -->
                        </div>
                    </div>





                </div>


                <div class="col-md-2">

                </div>

            </div>
        </div>
    </div>
</main>
<script>
    var sp = '${sport}';
    if (sp == 'Футбол') {
        $('#panelGroup').addClass('panel-success');
        $('#imageGroup').attr("src", "resources/image/стадион.png")
    } else if (sp == 'Баскетбол') {
        $('#panelGroup').addClass('panel-warning');
        $('#imageGroup').attr("src", "resources/image/playbasket.png")
    } else if (sp == 'Волейбол') {
        $('#panelGroup').addClass('panel-info');
        $('#imageGroup').attr("src", "resources/image/сетка.png")
    }
    var returnBack = 'home?where=' + '${returnBack}' + '&playgroundId=' + '${playgroundId}' + '&sport=' + sp;
    $('#returnBack').attr('href', returnBack);

    function handleGroup() {
        var playgroundId = '${playgroundId}';
        var sport = '${sport}';
        $.ajax({
            url: 'handleGroup?playgroundId=' + playgroundId + '&sport=' + sport
        }).then(function (value) {
            if (value == true) {
                $('#exitFromGroup').removeClass('hide');
                $('#enterToGroup').addClass('hide');
            } else {
                $('#exitFromGroup').addClass('hide');
                $('#enterToGroup').removeClass('hide');
            }
        });
    }
</script>
</body>
</html>