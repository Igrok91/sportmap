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

        /* Set black background color, white text and some padding */
        .borderless {
            border: 0 none;

            box-shadow: none;

        }

        textarea {
            resize: none;
        }


    </style>
</head>
<body>
<nav class="nav  navbar-static-top navbar-default ">
    <div class="container-fluid ">
        <div class="navbar-brand ">
            Мои профиль
        </div>
        <div class="pull-right dropdown" style="padding-top: 10px">
            <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu1"> <span
                    class="glyphicon glyphicon-bell"></span></a>
            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
                <li><a href="#">Включить уведомления</a></li>
            </ul>
        </div>
    </div>
</nav>
<main>

    <div class="container-fluid " style="margin-top: 15px">


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">
                <div class="panel panel-default">
                    <div class="panel-heading ">
                        <div>
                            <a class="pull-left" href="#">
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons8-ÑÑÑÐ±Ð¾Ð»ÑÐ½ÑÐ¹-Ð¼ÑÑ-50.png" alt="Футбол" width="40" height="40"> -->
                                <img class="media-object" src="resources/image/foot.png" alt="Футбол" width="40"
                                     height="40">
                            </a>
                            <div class="pull-right dropdown" style=" margin-top: 4px;margin-bottom: 4px; ">
                                <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu3"> <span
                                        class="glyphicon glyphicon-option-vertical"></span></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3">
                                    <li><a onclick="editInfoUser()">
                                        <span class="glyphicon glyphicon-pencil" style="margin-right: 20px"></span>Редактировать
                                    </a></li>
                                    <li><a href="#"> <span class="glyphicon glyphicon-bell" style="margin-right: 20px"></span>Включить </a></li>
                                </ul>
                            </div>
                            <div class="media-body " style="padding-left: 10px">
                                <h4>${user.lastName} ${user.firstName} </h4>
                                <!--    <span  class="glyphicon glyphicon-star-empty" ></span><span style="color: gray; margin-right: 15px" > 105 </span>
                                   <span style="color: gray"> 3 место</span> -->
                            </div>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div>
                            <h5><span class="glyphicon glyphicon-info-sign"></span>
                                <span id="informationUser" style="color: gray; padding-left: 10px" >
                                     <c:choose>
                                         <c:when test="${user.info == null}">
                                             нет информации
                                         </c:when>
                                         <c:otherwise>
                                             ${user.info}
                                         </c:otherwise>
                                     </c:choose>
                                    </span>

                                </h5>
                            <div class="container-fluid hide" id="divUserInfo">
                                <div class="row ">
                                    <div>
                                        <textarea type="text" id="userInfo"
                                                  style="padding-bottom: 15px; margin-bottom: 0px; "
                                                  class="form-control borderless " rows="1"
                                                  placeholder="" aria-label=""></textarea>
                                        <hr style="padding: 0px; margin:0px">
                                    </div>
                                    <div style="padding-top: 10px">
                                        <a href="#" onclick="saveInfoUser()" class="btn  pull-right" id="send">
                                            <span class="glyphicon glyphicon-floppy-save " aria-hidden=""></span>
                                            Сохранить</a>
                                    </div>
                                </div>
                            </div>
                        </div>


                    </div>
                    <div class="list-group">
                        <a href="#" class="list-group-item ">
                            <span class="badge" style="background: #ffffff"><span style="color: gray"><c:out value="${user.playgroundIdlList.size()}"/></span> <span
                                    class="glyphicon glyphicon-menu-right" style="color: gray"></span></span>
                            Группы
                        </a>


                        <a href="#" class="list-group-item">
                            <span class="badge"  style="background: #ffffff"><span style="color: gray"><c:out value="${user.playgroundIdlList.size()}"/> <span class="glyphicon glyphicon-menu-right"></span></span></span>
                            Участие в играх</a>
                        <a href="#" class="list-group-item">
                            <span class="badge"  style="background: #ffffff"><span style="color: gray"><c:out value="${user.playgroundIdlList.size()}"/> <span class="glyphicon glyphicon-menu-right"></span></span></span>
                            Организация игр</a>
                    </div>

                    <div style="padding: 20px">
                        <!-- <a href="#" class="btn"><span class="glyphicon glyphicon-th-list"></span> Общий рейтинг</a>   -->
                    </div>


                </div>


                <div class="col-sm-2">

                </div>

            </div>
        </div>
    </div>
</main>
<script>
    function editInfoUser() {
        $('#divUserInfo').removeClass('hide');
        $('#userInfo').focus();
    }

    function saveInfoUser() {

        var text = $('#userInfo').val();
        var userId = '${userId}';

        $.ajax({
            url: 'editUserInfo',
            method: "POST",
            data: ({userInfo: text, userId: userId})
        }).then(function () {
            $('#informationUser').text(text);
            $('#divUserInfo').addClass('hide');
        });
    }
</script>
</body>
</html>