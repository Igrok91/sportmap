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


    </style>
</head>
<body>

<nav class="nav navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left" >
            <a class="navbar-brand btn" href="#" ><span class="glyphicon glyphicon-menu-left" aria-hidden=""></span></a>
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

                <div style="padding-top: 10px;padding-bottom: 10px">

                    <div class="media ">
                        <div class="pull-left">
                            <img class="media-object" src="resources/image/foot.png" alt="Футбол" width="40" height="40"/>
                        </div>


                        <div class="media-body " >
                            <h4 class="media-heading" style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">У Школы № 29</h4>
                            <span  style="color: gray" >Футбол</span>

                        </div>
                    </div>

                </div>

                <div class="btn-group btn-group-justified" style="padding-bottom: 5px" >
                    <a href="#" class="btn active btn-primary">Новый</a>
                    <a href="#" class="btn ">Шаблоны</a>
                </div>

                <div class="panel panel-default">
                    <div class="panel-body">

                        <div>
                            <div>
                                <label for="desc"><span><img src="resources/image/.png" width="20" height="20" style="margin-right: 5px; margin-bottom: 3px"></span>Описание</label>
                            </div>
                            <textarea  type="text" class="form-control borderless " placeholder="Го на игру в 18 ?" rows="1" id="desc"></textarea>
                            <hr>
                        </div>





                        <div class="row text-center " style="padding-top: 5px">
                            <div class="container-fluid">
                                <a href="#" class="btn"><span class="glyphicon glyphicon-floppy-save " aria-hidden=""></span> Сохранить в шаблоны</a>
                            </div>
                        </div>


                        <div  style="margin-top: 5px">
                            <span style="margin-right: 3px; color: gray">Дополнительные настройки </span>
                            <input type="checkbox" class="checkbox-switch" />
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
                                    <label for="sel1"><span class="glyphicon glyphicon-time" style="margin-right: 5px"></span> Срок действия опроса</label>
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


                </div>


                <div class="col-md-2">

                </div>

            </div>
        </div>
    </div>
</main>
</body>
</html>