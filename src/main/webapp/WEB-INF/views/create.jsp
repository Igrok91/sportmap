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

        /* Set black background color, white text and some padding */
        .borderless {
            border: 0 none;
            box-shadow: none;

        }

        hr {
            margin-top: 0px;
            margin-bottom: 0px;
        }
    </style>
</head>
<body>

<nav class="nav navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left" >
            <a class="navbar-brand btn" href="/home?where=create" id="returnBackFromCreate" ><span class="glyphicon glyphicon-menu-left" aria-hidden=""></span></a>
        </div>
        <div class="navbar-brand ">
            Создание опроса
        </div>
        <div class="pull-right">
            <a class="navbar-brand btn" href="#" ><span class="glyphicon glyphicon-ok" aria-hidden=""></span></a>
        </div>
    </div>
</nav>
<main>

    <div class="container-fluid ">


        <div class="row content">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">

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



                                <span  style="color: gray">${sport}</span>

                            </div>

                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="btn-group btn-group-justified" style="padding-bottom: 10px" >
                            <a href="#" class="btn active btn-primary" id="newGame">Новый</a>
                            <a href="#" class="btn " id="templatesGames">Шаблоны</a>
                        </div>
                        <div id="panelCreate">
                        <div>
                            <div>
                                <label for="desc"><span><img src="resources/image/новый3.png" width="20" height="20" style="margin-right: 5px; margin-bottom: 3px"></span>Описание</label>
                            </div>
                            <textarea  type="text" class="form-control borderless " placeholder="Го на игру в 18 ?" rows="1" id="desc"></textarea>
                            <hr>
                        </div>





                        <div class="row text-center " style="padding-top: 5px">
                            <div class="container-fluid">
                                <a href="#" onclick="" class="btn"><span class="glyphicon glyphicon-floppy-save " aria-hidden=""></span> Сохранить в шаблоны</a>
                            </div>
                        </div>


                        <div  style="margin-top: 5px">
                            <span style="margin-right: 3px; color: gray">Дополнительные настройки </span>
                            <input type="checkbox" class="checkbox-switch3" />
                        </div>

                        <div id="settings" style="margin-top: 5px" class="hide">

                            <div style="padding-bottom: 10px">
                                <div>
                                    <label for="response"><span><img src="resources/image/опрос.png" width="20" height="20" style="margin-right: 5px"></span>Варианты ответа</label>
                                </div>
                                <input type="text" class="form-control text-center borderless" placeholder="+" id="response">
                                <hr>
                            </div>
                            <div class="btn-group btn-group-justified"  >

                                <a href="#" class="btn" style="margin-right: 3px"><span class="glyphicon glyphicon-plus " aria-hidden=""></span> Добавить </a>
                                <a href="#" class="btn"><span class="glyphicon glyphicon-minus " aria-hidden=""></span> Удалить </a>

                            </div>
                            <div style="padding-bottom: 10px">
                                <div >
                                    <label for="sel2"><span><img src="resources/image/количество.png" width="20" height="20" style="margin-right: 5px"></span>Количество голосов</label>
                                </div>
                                <select class="form-control borderless" id="sel2">
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
                            <div style="padding-bottom: 10px">
                                <div >
                                    <label for="sel1"><span class="glyphicon glyphicon-time" style="margin-right: 5px"></span> Срок действия</label>
                                </div>
                                <select class="form-control borderless" id="sel1">
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

                        <div id="templatesPanel" class="hide">
                            <c:import url="templates.jsp"/>

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

    $(function() {
        $('#newGame').click(function(event) {
            $('#newGame').addClass('active btn-primary');
            $('#panelCreate').removeClass('hide');
            $('#templatesGames').removeClass('active btn-primary');
            $('#templatesPanel').addClass('hide');
        });
    });

    $(function() {
        $('#templatesGames').click(function(event) {
            $('#templatesGames').addClass('active btn-primary');
            $('#newGame').removeClass('active btn-primary');
            $('#templatesPanel').removeClass('hide');
            $('#panelCreate').addClass('hide');
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
        $('#templatesGames').addClass('active btn-primary');
        $('#newGame').removeClass('active btn-primary');
        $('#templatesPanel').removeClass('hide');
        $('#panelCreate').addClass('hide');
    } else {
        $('#templatesPanelEmpty').removeClass('hide');
    }

    function saveToTemplates() {
        $.ajax({
            url: 'saveTemplate?templateId=' + id,
            data: ({description: $('#desc').val(),
                answer : $('#response').val(),
                sel2 : $('#sel2').val() }),
                sel1 : $('#sel1').val()
        }).then(function () {
            var template = [];
            var description = $('#desc').val();
            var answer = $('#response').val();
            var listAnswer = $('#response').val();
            var sel2 = $('#sel2').val();
            var sel1 = $('#sel1').val();

            var object = {
                templateId : templates.length+1,
                "description" : description,
                "sel2" : sel2,
                "sel1" : sel1

            }
            template.push(object);
            var list = document.getElementById('listTemplates');
            list.appendChild(getTemplatesList(template));


        });
    }

</script>
</body>
</html>