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


        .borderless {
            border: 0 none;

            box-shadow: none;

        }

        .hrDescription {
            margin-top: 9px;
            margin-bottom: 9px;
        }
        textarea {
            resize: none;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left" >
            <a class="navbar-brand btn" href="home" ><span class="glyphicon glyphicon-menu-left" aria-hidden=""></span></a>
            <a class="navbar-brand" href="#">Событие</a>
        </div>

    </div>
</nav>
<main>
    <div class="container-fluid ">

        <div class="row content">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">
                <div class="list-group">

                    <div class="panel " id="eventPanel">
                        <div class="panel-heading" style="padding-bottom: 3px; padding-top: 6px">

                            <div>
                                <a class="pull-left" href="#" >
                                    <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                    <img id="imageGroup3" class="media-object" src="resources/image/playbasket.png" alt="Баскетбол" width="40" height="40" >
                                </a>


                                <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                                    <a  class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu2" >  <span  class="glyphicon glyphicon-option-vertical" ></span></a>
                                    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
                                        <c:choose>
                                            <c:when test="${event.userIdCreator == userId}">
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
                                            </c:when>
                                            <c:otherwise>
                                                <li><a href="#" >	<span class="glyphicon glyphicon-time" style="margin-right: 20px"></span>История изменений</a></li>
                                                <li><a href="#" >	<span class="glyphicon glyphicon-home" style="margin-right: 20px"></span>К площадке</a></li>
                                                <li><a href="#" >	<span class="glyphicon glyphicon-share-alt" style="margin-right: 20px"></span>К записи</a></li>
                                                <li><a href="#">	<span class="glyphicon glyphicon-minus" style="margin-right: 20px"></span>Отменить голос</a></li>
                                            </c:otherwise>
                                        </c:choose>

                                    </ul>
                                </div>
                                <div class="media-body" style="padding-left: 10px">

                                    <h4 class="media-heading" style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">${event.playgroundName}</h4>



                                    <span  style="color: gray">${event.date} сегодня в 13:34</span>

                                </div>

                            </div>


                        </div>
                        <div>
                            <a href="#" class="btn" style="margin-left: 5px"><span class="glyphicon glyphicon-user " aria-hidden="" style="margin-right: 5px"></span> ${event.userFirtsNameCreator} ${event.userLastNameCreator}</a>
                        </div>
                        <hr  style="margin-bottom: 9px; margin-top: 0px">
                        <div >
                            <span  style="color: black; padding-left: 17px; padding-right: 17px">${event.description}</span>
                        </div>
                        <hr class="hrDescription">

                        <div class="panel-body" style="padding-bottom: 0px">
                            <div class="list-group" style="margin-bottom: 5px" >
                                <a href="#" class="list-group-item ">
                                    <c:choose>
                                    <c:when test="${event.maxCountAnswer == 0}">
                                        <span class="badge">${event.userList.size()}</span>
                                    </c:when>
                                        <c:otherwise>
                                            <span class="badge">${event.userList.size()} / ${event.maxCountAnswer} </span>
                                        </c:otherwise>
                                    </c:choose>


                                    <div class="text-center">
                                        +
                                    </div>
                                </a>
                            </div>

                            <div class="btn-group " style="margin-top: 5px">
                                <div class="container-fluid">
                                    <div class="row">
                                        <c:forEach var="user" items="${event.userList}">
                                            <a  href="user?userId=${user.userId}"  class="btn" style="padding: 0px">
                                                <!-- <img  src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
                                                <img  src="resources/image/foot.png" alt="Баскетбол" width="30" height="30" >
                                            </a>
                                        </c:forEach>

                                        <c:if test="${event.userList.size() > 3}">
                                            <a href="#" class="btn" style="color: gray"> <span class="glyphicon glyphicon-eye-open" style="margin-right: 5px"></span>Все</a>
                                        </c:if>

                                    </div>

                                </div>


                            </div>

                        </div>
                        <hr style="margin-bottom: 0px">
                        <a href="#" class="btn" style=" margin-left: 5px; margin-top: 4px; margin-bottom: 4px"><span class="glyphicon glyphicon-bullhorn "  style="margin-right: 5px"></span> Поделиться</a>
                        <c:if test="${event.commentsList.size() != 0}">

                        <ul class="list-group">
                            <c:forEach var="comment" items="${event.commentsList}">
                    <li class="list-group-item" style="padding-bottom: 1px;padding-top: 5px">
                        <div class="media" >
                            <a class="pull-left" href="user?userId=${comment.userId}" style="margin-top: 5px">
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="35" height="35"> -->
                                <img class="media-object" src="resources/image/foot.png" alt="Футбол" width="35" height="35">
                            </a>
                            <div class="media-body "  >
                            <h5 class="media-heading" style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px;color: #77A5C5">${comment.firstName} ${comment.lastName}</h5>
                            <p style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 2px">${comment.message}</p>
                            <span  style="color: gray" >${comment.date}</span>
                        </div>
                </div>
                </li>
                            </c:forEach>
                </ul>
                        </c:if>

                <div style="margin-bottom: 15px; margin-top: 15px;">
                    <c:if test="${event.commentsList.size() == 0}">
                        <hr style="margin-top: 0px; padding-top: 0px; margin-bottom: 7px;padding-bottom: 7px">
                    </c:if>

                    <div >
                        <a class="pull-left" href="#" style="margin-left: 15px;" >
                            <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="30" height="30" > -->
                            <img class="media-object" src="resources/image/foot.png" alt="Баскетбол" width="35" height="35" >
                        </a>

                        <div class="media-body" >

                            <div class="container-fluid" >
                                <div class="row " >
                                    <div class="col-xs-9 col-md-11 col-sm-11  " >
                                        <textarea type="text" style="padding-bottom: 15px; margin-bottom: 0px; " class="form-control borderless  media-heading" rows="1" placeholder="Ваше сообщение" aria-label="" ></textarea>
                                        <hr style="padding: 0px; margin:0px">
                                    </div>
                                    <div class="col-xs-3 col-md-1 col-sm-1 pull-righ " >
                                        <a href="#" class="btn  pull-right" id="send"  ><span style="padding-bottom: 10px"> <img  src="resources/image/send.png"  width="25" height="25" ></span></a>
                                    </div>
                                </div>
                            </div>



                        </div>
                    </div>
                </div>




            </div>


                </div>



            </div>

        </div>
        <div class="col-md-2">

        </div>
    </div>

</main>


<script>
    $(document).ready(function(){
        $('#all').tooltip({title: "Смотреть всех", container: ".row"});
    });

    var sp = '${event.sport}';
    if (sp == 'Футбол') {
        $('#eventPanel').addClass('panel-success');
        $('#imageGroup3').attr("src", "resources/image/стадион.png")
    } else if (sp == 'Баскетбол') {
        $('#eventPanel').addClass('panel-warning');
        $('#imageGroup3').attr("src", "resources/image/playbasket.png")
    } else if (sp == 'Волейбол') {
        $('#eventPanel').addClass('panel-info');
        $('#imageGroup3').attr("src", "resources/image/сетка.png")
    }
</script>

</body>
</html>