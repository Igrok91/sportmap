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



        .hrDescription {
            margin-top: 5px;
            margin-bottom: 5px;
        }

    </style>
</head>
<body>
<%--Шаблон UserGroup--%>
<a  href="#"  class="btn" style="padding: 0px" id="userTemplate">
    <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
    <img  src="resources/image/foot.png" alt="Баскетбол" width="30" height="30" >
</a>

<%--Шаблон event panel--%>
<div class="panel  hide" id="eventsGame" >
    <div class="panel-heading" style="padding-bottom: 3px; padding-top: 6px">

        <div>
            <a class="pull-left" href="#" >
                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                <img class="media-object" src="resources/image/playbasket.png" alt="Баскетбол" width="40" height="40" id="imageGroup2">
            </a>


            <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                <a  class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu2">  <span  class="glyphicon glyphicon-option-vertical" ></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
                    <li><a href="#" >
                        <span class="glyphicon glyphicon-off" style="margin-right: 20px"></span>Завершить опрос
                    </a></li>
                    <li><a href="#" ><span class="glyphicon glyphicon-trash" style="margin-right: 20px"></span>Отменить опрос</a></li>
                    <li><a href="#" >
                        <span class="glyphicon glyphicon-pencil" style="margin-right: 20px"></span>Редактировать
                    </a></li>
                    <li><a href="#" >	<span class="glyphicon glyphicon-time" style="margin-right: 20px"></span>История изменений</a></li>
                    <li><a href="#" >	<span class="glyphicon glyphicon-home" style="margin-right: 20px"></span>К площадке</a></li>
                    <li><a href="#" >	<span class="glyphicon glyphicon-share-alt" style="margin-right: 20px"></span>К записи</a></li>
                    <li><a href="#">	<span class="glyphicon glyphicon-minus" style="margin-right: 20px"></span>Отменить голос</a></li>
                </ul>
            </div>
            <div class="media-body" style="padding-left: 10px">

                <h4 class="media-heading" style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px" id="placeGame"></h4>



                <span  style="color: gray">сегодня в 12.24</span>

            </div>

        </div>


    </div>
    <div>
        <a href="#" class="btn" style="margin-left: 5px" id="creatorEvent"><span class="glyphicon glyphicon-user " aria-hidden="" style="margin-right: 5px"></span> <span id="NameCreator">Леонид Заручевский</span></a>
    </div>
    <hr class="hrDescription">
    <div >
        <span  style="color: black; padding-left: 17px; padding-right: 17px" id="descriptionEvent"></span>
    </div>
    <hr class="hrDescription">

    <div class="panel-body" style="padding-bottom: 0px">
        <div class="list-group" style="margin-bottom: 5px" >
            <a href="#" class="list-group-item ">

                <span class="badge"><span id="countAnswer"></span> <span id="maxCountAnswer"></span></span>

                <div class="text-center">
                    +
                </div>
            </a>
        </div>

        <div class="btn-group " style="margin-top: 5px">
            <div class="container-fluid">
                <div class="row" id="userGroup">



                    <a href="#" class="btn hide" style="color: gray" id="all2"> <span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span></a>

                </div>

            </div>


        </div>

    </div>
    <a href="#" class="btn" style=" margin-left: 5px;margin-top: 4px; margin-bottom: 4px"><span class="glyphicon glyphicon-comment "  aria-hidden="Комментировать" style="color: #77A5C5;margin-right: 5px"></span>4</a>
    <a href="#" class="btn" style=" margin-left: 5px; margin-top: 4px;margin-bottom: 4px"><span class="glyphicon glyphicon-bullhorn "  aria-hidden="Комментировать" style="color: #77A5C5;margin-right: 5px"></span>2</a>



</div>
<nav class="navbar navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left" >
            <a class="navbar-brand" href="#">События</a>
        </div>
        <div class="pull-right" style="padding-top: 10px">
            <span style="margin-right: 3px">Все</span>
            <input type="checkbox" class="checkbox-switch" />
        </div>
    </div>
</nav>
<main style="margin-bottom: 40px; padding-bottom: 50px;">
    <div class="container-fluid ">

        <div class="row content">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">
                <div class="list-group" id="listEventGame">




                </div>



            </div>

        </div>
        <div class="col-md-2">

        </div>
    </div>

</main>


<script>
    var listEvents = ${listEvents};
    console.log(listEvents.length);
    if (listEvents) {
        listEvents.map(function (event, i) {
            var sp = event.sport;
            if (sp == 'Футбол') {
                $('#eventsGame').addClass('panel-success');
                $('#imageGroup2').attr("src", "resources/image/стадион.png")
            } else if (sp == 'Баскетбол') {
                $('#eventsGame').addClass('panel-warning');
                $('#imageGroup2').attr("src", "resources/image/playbasket.png")
            } else if (sp == 'Волейбол') {
                $('#eventsGame').addClass('panel-info');
                $('#imageGroup2').attr("src", "resources/image/сетка.png")
            }

            $('#placeGame').text(event.playgroundName);
            $('#NameCreator').text(event.userFirtsNameCreator + " " + event.userLastNameCreator);

            if (event.userList) {
                $('#countAnswer').text(event.userList.length);
                event.userList.map(function (user, i) {
                    $('#userTemplate').removeClass('hide');
                    $('#userTemplate').attr('href', "user?userId=" + user.userId);
                    var user = document.getElementById("userTemplate").cloneNode(true);
                    user.id = user.userId;
                    $('#userTemplate').addClass('hide');



                    var listUser = document.getElementById("userGroup");
                    listUser.appendChild(user);

                });
                if (event.userList.length > 3) {
                    $('#all2').removeClass('hide');
                }
            } else {
                $('#countAnswer').text("0");

                $('#all2').addClass('hide');
            }

            if (event.maxCountAnswer != 0) {
                $('#maxCountAnswer').text("/ " + event.maxCountAnswer);
            } else {
                $('#maxCountAnswer').text("");
            }


            var eventDescr = event.description.split('\r\n');
            $('#descriptionEvent').html('');
            eventDescr.map(function (descr, i) {
                console.log(descr);
                $('#descriptionEvent').append(descr);
                $('#descriptionEvent').append('<br>');
            });

            $('#eventsGame').removeClass('hide');
            var clonedNode = document.getElementById("eventsGame").cloneNode(true);
            clonedNode.id = event.idEvent;
            //Возврат состояния шаблона

            $('#eventsGame').addClass('hide');
            $('#eventsGame').removeClass('panel-success');
            $('#eventsGame').removeClass('panel-warning');
            $('#eventsGame').removeClass('panel-info');

            var list = document.getElementById("listEventGame");
            list.appendChild(clonedNode);
        });
    }


</script>

</body>
</html>