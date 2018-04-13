<%--
  Created by IntelliJ IDEA.
  User: Igor
  Date: 03.04.2017
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
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

        /* Set black background color, white text and some padding */
        .borderless {
            border: 0 none;
            box-shadow: none;

        }
        a.disabled {
            pointer-events: none; /* делаем элемент неактивным для взаимодействия */
            cursor: default; /*  курсор в виде стрелки */
        }

        hr {
            margin-top: 0px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>
<form action="createGame"  method="post" onsubmit="disabledButton()">
<nav class="nav navbar-static-top navbar-default" style="background: #eeeeee">
    <div class="container-fluid ">
        <div class="pull-left" >
            <a class="navbar-brand btn" href="/home?where=create" id="returnBackFromCreate" ><span class="glyphicon glyphicon-menu-left" aria-hidden=""></span></a>
        </div>
        <div class="navbar-brand ">
            Создание опроса
        </div>

    </div>
</nav>
<main>


    <div class="container-fluid ">


        <div class="row content">
            <div class="col-sm-2">

            </div>
            <div class="col-sm-8">

                <div class="panel panel-default" id="headingCreate" style="margin-top: 15px">
                    <div class="panel-heading " >
                        <div>
                            <a class="pull-left" href="#" >
                                <!-- <img class="media-object" src="\Users\igrok\Downloads\icons9.png" alt="Баскетбол" width="40" height="40" > -->
                                <img class="media-object" src="resources/image/playbasket.png" alt="Баскетбол" width="40" height="40" id="imageGroupCreate" >
                            </a>


                            <div class="media-body" style="padding-left: 10px">

                                <h4 class="media-heading" style="padding-bottom: 1px; margin-bottom: 0px; margin-top: 2px">
                                    ${namePlayground}</h4>



                                <span  style="color: gray;padding-right: 12px">${sport}</span> <span style="color: gray">Участники ${players.size()}</span>


                            </div>

                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="btn-group btn-group-justified" style="padding-bottom: 10px" id="tabCreate" >
                            <a href="#" class="btn  btn-primary" id="newGame">Новый</a>
                            <a href="#" class="btn " id="templatesGames">Шаблоны</a>
                        </div>
                        <div id="panelCreate">
                        <div>
                            <div>
                                <label for="desc"><span><img src="resources/image/new.png" width="20" height="20" style="margin-right: 5px; margin-bottom: 3px"></span>Описание</label>
                            </div>
                            <textarea  type="text" class="form-control borderless " name="descr" placeholder="Го на игру в 18 ?" rows="1" id="desc" required></textarea>
                            <hr>
                        </div>





                        <div class="row text-center " style="padding-top: 5px">
                            <div class="container-fluid">
                                <a href="#" onclick="saveToTemplates()" id="savetempl" class="btn disabled"><span class="glyphicon glyphicon-floppy-save " aria-hidden=""></span> <span id="savetempltext">Сохранить в шаблоны</span></a>
                            </div>
                        </div>


                        <div  style="margin-top: 5px">
                            <span style="margin-right: 3px; color: gray">Дополнительные настройки </span>
                            <input type="checkbox" class="checkbox-switch3" />
                        </div>

                        <div id="settings" style="margin-top: 5px" class="hide">

         <%--                   <div style="padding-bottom: 10px">
                                <div>
                                    <label for="response"><span><img src="resources/image/опрос.png" width="20" height="20" style="margin-right: 5px"></span>Варианты ответа</label>
                                </div>
                                <input type="text" class="form-control text-center borderless" placeholder="+" id="response">
                                <hr>
                            </div>
                            <div class="btn-group btn-group-justified"  >

                                <a href="#" class="btn" style="margin-right: 3px"><span class="glyphicon glyphicon-plus " aria-hidden=""></span> Добавить </a>
                                <a href="#" class="btn"><span class="glyphicon glyphicon-minus " aria-hidden=""></span> Удалить </a>

                            </div>--%>
                            <div style="padding-bottom: 10px">
                                <div >
                                    <label for="sel2"><span><img src="resources/image/количество.png" width="20" height="20" style="margin-right: 5px"></span>Количество голосов</label>
                                </div>
                                <select class="form-control borderless" id="sel2" name="sel2">
                                    <option>Без ограничений</option>
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                    <option>6</option>
                                    <option>7</option>
                                    <option>8</option>
                                    <option>9</option>
                                    <option>10</option>
                                    <option>11</option>
                                    <option>12</option>
                                    <option>13</option>
                                    <option>14</option>
                                    <option>15</option>
                                    <option>16</option>
                                    <option>17</option>
                                    <option>18</option>
                                    <option>19</option>
                                    <option>20</option>
                                    <option>21</option>
                                    <option>22</option>
                                    <option>23</option>
                                    <option>24</option>
                                    <option>25</option>
                                    <option>26</option>
                                    <option>27</option>
                                    <option>28</option>
                                    <option>29</option>
                                    <option>30</option>
                                </select>
                                <hr>
                            </div>
                     <input type="hidden" name="sport"
                             value="${sport}" />
                       <input type="hidden" name="playgroundId"
                                value="${playgroundId}" />
             <input type="hidden" name="namePlayground"
                    value="${namePlayground}" />

             <input id="templId" type="hidden" name="templateId"
                    value="" />
             <input id="eventId" type="hidden" name="eventId"
                    value="${event.idEvent}" />

                            <div style="padding-bottom: 10px">
                                <div >
                                    <label for="sel1"><span class="glyphicon glyphicon-time" style="margin-right: 5px"></span> Срок действия</label>
                                </div>
                                <select class="form-control borderless" id="sel1" name="sel1">
                                    <option>1 день</option>
                                    <option>2 дня</option>
                                    <option>3 дня</option>
                                    <option>4 дня</option>
                                    <option>5 дней</option>
                                    <option>6 дней</option>
                                    <option>7 дней</option>
                                </select>
                                <hr>
                            </div>
                        </div>
                        </div>

                        <div class=" btn-group btn-group-justified" style="padding-top: 15px" id="divCreateGame">
                            <div class="btn-group" >
                            <button class="btn  btn-primary" type="submit"  id="createGame" disabled>Опубликовать</button>
                            </div>
                        </div>
                        <div id="templatesPanel" class="hide">
                            <c:import url="templates.jsp"/>

                        </div>
                    </div>


                </div>


                <div class="col-sm-2">

                </div>

            </div>
        </div>
    </div>
</main>
</form>

<script>
    var el3 = document.querySelector('.checkbox-switch3');
    var mySwitch3 = new Switch(el3, {
        showText: true,
        onText: '',
        offText: '',
        onChange: function () {
          if (mySwitch3.getChecked() == true) {
              $('#settings').removeClass('hide');
          } else {
              $('#settings').addClass('hide');
          }
        }
    });

    var event = ${eventJson};
    if (event.idEvent) {
        $('#tabCreate').addClass('hide');
        $('#savetempl').addClass('hide');
        $('#desc').append(event.description);
        mySwitch3.on();

    }

    $(function() {
        $('#newGame').click(function(event) {
            $('#newGame').addClass(' btn-primary');
            $('#panelCreate').removeClass('hide');
            $('#templatesGames').removeClass(' btn-primary');
            $('#templatesPanel').addClass('hide');
            $('#divCreateGame').removeClass('hide');
        });
    });

    $(function() {
        $('#templatesGames').click(function(event) {
            $('#templatesGames').addClass(' btn-primary');
            $('#newGame').removeClass(' btn-primary');
            $('#templatesPanel').removeClass('hide');
            $('#panelCreate').addClass('hide');
            $('#divCreateGame').addClass('hide');
        });
    });

    var sp2 = '${sport}';
    if (sp2 == 'Футбол') {
        $('#headingCreate').addClass('panel-success');
        $('#imageGroupCreate').attr("src", "resources/image/стадион.png")
    } else if (sp2 == 'Баскетбол') {
        $('#headingCreate').addClass('panel-warning');
        $('#imageGroupCreate').attr("src", "resources/image/playbasket.png")
    } else if (sp2 == 'Волейбол') {
        $('#headingCreate').addClass('panel-info');
        $('#imageGroupCreate').attr("src", "resources/image/сетка.png")
    }

    var templates = ${templates};
    if (templates.length != 0) {
        $('#templatesGames').addClass(' btn-primary');
        $('#newGame').removeClass(' btn-primary');
        $('#templatesPanel').removeClass('hide');
        $('#panelCreate').addClass('hide');
        $('#divCreateGame').addClass('hide');
    } else {
        $('#templatesPanelEmpty').removeClass('hide');
    }

    function saveToTemplates() {
        var description = $('#desc').val();
        if (description.split('').length > 3) {
            var answer = '+';
            var sel2 = $('#sel2').val();
            var sel1 = $('#sel1').val();

            if (sel2 === 'Без ограничений') {
                sel2 = 'infinity';
            }

            $('#savetempltext').text('Сохранено в шаблоны');

            $('#savetempl').css({"pointer-events": "none"});

            $.ajax({
                url: 'saveTemplate',
                method: "POST",
                data: ({descr: description, answer: answer, sel2: sel2, sel1: sel1}),
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("Accept", "application/json");
                    //xhr.setRequestHeader("Content-Type", "application/json");
                },
                success: function (response) {

                    var description = response.description;
                    var template = {
                        templateId: response.templateId,
                        description: description,
                    }

                    var list = document.getElementById('listTemplates');
                    list.appendChild(getTemplatesList(template));
                    if (list.childNodes.length != 1) {
                        $('#templatesPanelEmpty').addClass('hide');

                    }
                }
            });
        }
    }

    function createGame() {
        var description = $('#desc').val();
        var answer = '+';
        var sel2 = $('#sel2').val();
        var sel1 = $('#sel1').val();
        var sport = '${sport}';
        var playgroundId = '${playgroundId}';

        if (sel2 === 'Без ограничений') {
            sel2 = 'infinity';
        }

       var href = "createGame?descr=" + description +"&answer=" + answer + "&sel2=" + sel2 + "&sel1=" + sel1 + "&sport=" + sport + "&playgroundId=" + playgroundId;
        //var href = 'home';
       // $('#createGame').attr('href', href);
      /* $.ajax({
            url: 'createGame',
            method: "POST",
            data: ({descr: description, answer: answer, sel2: sel2, sel1: sel1, sport: sport, playgroundId: playgroundId}),
            beforeSend: function (xhr) {
               xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
           }
        }).then(function (value) {

           $('#createGame').attr('onclick', toHome());

           $.get('home');


       });*/


       $.post("createGame", {descr: description, answer: answer, sel2: sel2, sel1: sel1, sport: sport, playgroundId: playgroundId});

       /* var xhr = new XMLHttpRequest();

        var body = 'descr=' + encodeURIComponent(description) +
            '&answer=' + encodeURIComponent(answer) + "&sel2=" + encodeURIComponent(sel2) + "&sel1=" + encodeURIComponent(sel1) + "&sport=" + encodeURIComponent(sport) + "&playgroundId=" + encodeURIComponent(playgroundId);

        xhr.open("POST", '/createGame', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');


        xhr.send(body);
*/
    }

    function toHome() {
        var href = 'home';
        $('#createGame').attr('href', href);
    }
    var isDisabled = true;
    function handleText() {
        if (isDisabled) {
            var text = $('#desc').val().split('');
            console.log("description " + text.length);
            var createGame = document.getElementById('createGame');
            if (text.length > 3) {
                createGame.removeAttribute('disabled');
                $('#savetempl').removeClass('disabled');
            } else {
                createGame.setAttribute('disabled', 'disabled');
                $('#savetempl').addClass('disabled');
            }
        }

    }
    setInterval(handleText, 300);

    function disabledButton() {
        isDisabled = false;
        var createGame = document.getElementById('createGame');
        createGame.setAttribute('disabled', 'disabled');
    }

</script>
</body>
</html>