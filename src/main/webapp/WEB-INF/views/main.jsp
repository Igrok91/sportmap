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
    <link rel="stylesheet" href="resources\switch\switch.css" />
    <script src="resources\switch\switch.js"></script>

    <style>
        .borderless {
            border: 0 none;

            box-shadow: none;

        }
        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    </style>
</head>
<body>
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
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">

                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title" id="exampleModalLabel">Выберите место игры</h5>
                </div>
                <div class="modal-body">

                    <div class="list-group">
                        <a href="#" class="list-group-item borderless">
                            <div class="media">
                                <div class="pull-left">
                                    <img class="media-object" src="resources/image/стадион3.png" alt="Футбол" width="40" height="40"/>
                                </div>


                                <div class="media-body " >
                                    <h4 class="media-heading" style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">У Школы № 29</h4>
                                    <span  style="color: gray" >Футбол</span>
                                    <hr>
                                </div>
                            </div>
                        </a>
                        <a href="#" class="list-group-item borderless">
                            <div class="media">
                                <div class="pull-left">
                                    <img class="media-object" src="resources/image/площадка2.png" alt="Баскетбол" width="40" height="40" />
                                </div>

                                <div class="media-body">
                                    <h4 class="media-heading" style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">У Школы № 345</h4>
                                    <span  style="color: gray" >Баскетбол</span>
                                    <hr>
                                </div>
                            </div>
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="falseModal" tabindex="-1" role="dialog" aria-labelledby="falseModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <h5 class="modal-title" id="falseModalLabel">У вас нет площадок</h5>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <button type="button" class="btn btn-primary">Перейти в поиск</button>
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

    $(document).ready(function(){
        $('#all2').tooltip({title: "Смотреть всех"});
    });


</script>

</body>
</html>