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
        @media screen and (max-width: 300px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }
            .row.content {height:auto;}

            #pac-input {
                width: auto;
                margin-right: 5px;
            }
        }
        /* Set black background color, white text and some padding */
        hr {
            margin-top: 5px;
            margin-bottom: 0px;
        }


        .borderless {
            border: 0 none;


        }
        .row.content {height: 450px}
        .subtitleMap{
            padding: 1px;
            margin-top: 10px;
            margin-bottom: 10px;
            font-family:Trebuchet MS;
            color:#525252;
        }
    </style>
</head>
<body>

<nav class="nav navbar-static-top navbar-default">
    <div class="container-fluid ">
        <div class="pull-left" >
            <a class="navbar-brand" href="#">Поиск</a>
        </div>
 <%--       <div class="pull-right" style="margin-top: 10px">
            <span style="margin-right: 3px">Free</span>
            <!-- <span style="margin-right: 3px"><img src="\Applications\Разработка\иконки\cost2.png" alt="COST" width="30" height="30"> </span> -->
            <input type="checkbox" class="checkbox-switch2" />
        </div>--%>
        <div class="pull-right dropdown" style="padding-top: 10px">
            <a  class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu5"><span  class="glyphicon glyphicon-filter" ></span></a>
            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu5">
                <li><a href="#" class="list-group-item borderless">
                    <div class="media">
                        <div class="pull-left">
                            <img class="media-object" src="resources/image/foot.png" alt="Футбол" width="20" height="20"  />
                        </div>


                        <div class="media-body " >
                            <h4 class="media-heading" style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">Футбол</h4>
                        </div>
                    </div>
                </a></li>
                <li><a href="#" class="list-group-item borderless">
                    <div class="media">
                        <div class="pull-left">
                            <img class="media-object" src="resources/image/basket.png" alt="Футбол" width="20" height="20"  />
                        </div>


                        <div class="media-body " >
                            <h4 class="media-heading" style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">Баскетбол</h4>
                        </div>
                    </div>
                </a></li>
                <li><a href="#" class="list-group-item borderless">
                    <div class="media">
                        <div class="pull-left">
                            <img class="media-object" src="resources/image/voley.png" alt="Футбол" width="20" height="20"  />
                        </div>


                        <div class="media-body " >
                            <h4 class="media-heading" style="padding-bottom: 0px; margin-bottom: 0px; margin-top: 0px">Волейбол</h4>
                        </div>
                    </div>
                </a></li>
            </ul>
        </div>
    </div>
</nav>
<main>
    <div class="container-fluid ">
<%--        <div class="row ">
            <div class="text-center">
                <span style="color: gray">Фильтры:</span>
                <a  class="btn" id="football"><img  src="resources/image/foot.png" alt="Футбол" width="40" height="40"/></a>
                <a  class="btn" id="basketballPlayground"><img  src="resources/image/basket.png" alt="Баскетбол" width="40" height="40"/></a>
                <a  class="btn" id="voleyballPlayground"><img  src="resources/image/voley.png" alt="Волейбол" width="40" height="40"/></a>

            </div>

        </div>--%>

        <div class="row-content hide ">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">
                <div class="btn-group btn-group-justified">
                    <a href="#" class="btn active">Список</a>
                    <a href="#" class="btn ">Карта</a>
                </div>
                <div class="text-center">
                    <p style="margin-top: 5px">Площадки рядом с вами</p>
                </div>

                <div class="list-group ">
                    <a href="#" class="list-group-item borderless">
                        <div class="media">
                            <div class="pull-left">
                                <img class="media-object" src="resources/image/стадион3.png" alt="Футбол" width="40" height="40"/>
                            </div>


                            <div class="media-body " >
                                <h4 class="media-heading">Площадка у школы № 29</h4>
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
                                <h4 class="media-heading">Площадка у школы № 345</h4>
                                <span  style="color: gray" >Баскетбол</span>
                                <hr>
                            </div>
                        </div>
                    </a>

                </div>

            </div>
            <div class="col-md-2">

            </div>
        </div>



    </div>

</main>

<script>

</script>

</body>
</html>