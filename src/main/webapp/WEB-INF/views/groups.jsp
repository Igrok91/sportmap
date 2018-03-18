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

<nav class="nav  navbar-static-top navbar-default" >
    <div class="container-fluid ">
        <div class="navbar-brand ">
            Мои группы
        </div>
    </div>
</nav>
<main >

    <div class="container-fluid " >


        <div class="row content">
            <div class="col-md-2">

            </div>
            <div class="col-md-8">
                <div class="list-group" id="listGroupsUser">
                  <%--  <a href="#" class="list-group-item borderless" >
                        <div class="media">
                            <div class="pull-left">
                                <img class="media-object" src="resources/image/стадион3.png" alt="Футбол" width="40" height="40"/>
                            </div>


                            <div class="media-body " >
                                <h4 class="media-heading" id="test"></h4>
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
                                <h4 class="media-heading">У Школы № 345</h4>
                                <span  style="color: gray" >Баскетбол</span>
                                <hr>
                            </div>
                        </div>
                    </a>
--%>
                </div>

            </div>


            <div class="col-md-2">

            </div>

        </div>
    </div>

</main>
<script>
    var footInfo = ${footInfo};
    var basketInfo = ${basketInfo};
    var voleyballInfo = ${voleyballInfo};
    var sessionUser = ${sessionUser};
        var playgroundFoottUser = sessionUser.playgroundFoottUser;
        var playgroundBasketUser = sessionUser.playgroundBasketUser;
        var playgroundVoleyUser = sessionUser.playgroundVoleyUser;

        var playFootUser = [];
        var playBasketUser = [];
        var playVoleyUser = [];
        if (playgroundFoottUser !== undefined) {
             playgroundFoottUser.map(function(id, i) {

                 footInfo.map(function(info, i2) {
                    var idPlayground = info.id;
                    if (idPlayground == id) {
                        console.log('yes');
                        playFootUser.push(info);
                    }
                        });

            });

        }

    if (playgroundBasketUser !== undefined) {
        playgroundBasketUser.map(function(id, i) {

            basketInfo.map(function(info, i2) {
                var idPlayground = info.id;
                if (idPlayground == id) {
                    console.log('yes');
                    playBasketUser.push(info);
                }
            });

        });

    }
    if (playgroundVoleyUser !== undefined) {
        playgroundVoleyUser.map(function(id, i) {

            voleyballInfo.map(function(info, i2) {
                var idPlayground = info.id;
                if (idPlayground == id) {
                    console.log('yes');
                    playVoleyUser.push(info);
                }
            });

        });

    }


        var allPlaygroundUser = playFootUser.concat(playBasketUser, playVoleyUser );


         allPlaygroundUser.map(function(playground, i) {
                var list = document.getElementById('listGroupsUser');
                list.appendChild(getElementList(playground, i, "toGroup"));
         });


        function getElementList(allPlaygroundUser, index, href) {
            var a = document.createElement('a');
            a.href = href + "?playgroundId=" + allPlaygroundUser.id + "&sport=" + allPlaygroundUser.sport;
            a.id = allPlaygroundUser.id;
            a.className = 'list-group-item borderless list-groups';


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