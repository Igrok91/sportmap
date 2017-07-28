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
    <link rel="stylesheet" href="resources/searchBox.css">
    <script src="resources/js/searchBox.js"></script>
    <script src="resources/js/infoWindow.js"></script>
    <script src="resources/js/error.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://vk.com/js/api/xd_connection.js?2"  type="text/javascript"></script>
    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */
        .navbar {
            margin-bottom: 0;
            border-radius: 0;
        }
        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {height: 450px}

        /* Set black background color, white text and some padding */
        footer {
            background-color: #555;
            color: white;
            padding: 15px;
        }
        header{
            background-color: #fcfcfc;
        }


        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 300px) {
            .sidenav {
                height: auto;
                padding: 15px;
            }

            .row.content {height:auto;}
        }
        a.disabled {
            pointer-events: none; /* делаем ссылку некликабельной */
            cursor: default;  /* устанавливаем курсор в виде стрелки */
            color: #999; /* цвет текста для нективной ссылки */
        }

        .divMain {
            height: 105px;
            width: 150px;
        }


    </style>
</head>
<body>
<input id="pac-input" class="controls" type="text" placeholder="Поиск..">
<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container ">
        <div class="navbar-header " >
            <a class="navbar-brand" href="#">SportMap</a>
        </div>
<%--        <div class="collapse navbar-collapse navbar-right" id="myNavbar">
            <ul class="nav navbar-nav">
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">Выбрать город
                        <span class="caret"></span></a>

                </li>
            </ul>
        </div>--%>
    </div>
</nav>
<header>
    <div class="container-fluid" >
        <div class="row text-center">
            <h4 >Найди свою территорию спорта!</h4>
            <div class="container">
                <div class="btn-group ">
                    <a  class="btn btn-default btn-sm" id="football" role="button">
                        <img src="resources/images/ballMiddle.png" alt="" align="middle">
                    </a>
                    <a class="btn btn-primary btn-sm" id="basketball">
                        <img src="resources/images/basketball.png" alt="" align="middle">
                    </a>
                    <a  class="btn btn-default btn-sm" id="voleyball">
                        <img src="resources/images/volleyball.png" alt="" align="middle">
                    </a>
                </div>
            </div>
            <hr>
        </div>
    </div>
</header>
<main>
    <div class="container-fluid text-center">
        <div class="row content">
            <div class="sidenav"  id ="map" >
            </div>
        </div>
    </div>


</main>
<footer class="container-fluid text-center">
    <p>Copyright © 2017 SportMap</p>
</footer>
<script>
    var footMarkers;
    var markerCluster;
    var basketMarkers;
    var voleyMarkers;

    var footLocations = ${footLocation};
    var basketLocation = ${basketLocation};
    var voleyLocation = ${voleyLocation};

    var footInfo = ${footInfo};
    var basketInfo = ${basketInfo};
    var voleyballInfo = ${voleyballInfo};


    var userId = "${userId}";

    var errorMaps = "${errorMaps}";

    var allowMessage = {data : "false"};


    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 59.93903 , lng: 30.315828},
            zoom: 11,
            mapTypeId: 'roadmap'
        });
        initAutocomplete(map);
        var infoWindow = new google.maps.InfoWindow({map: map});


        // alert(footInfo[index].link);
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                infoWindow.setPosition(pos);
                infoWindow.setContent('Нажмите на маркер для перехода к площадке');
                map.setCenter(pos);
                initMarkers(map, infoWindow);

            }, function() {
                handleLocationError(true, map, infoWindow);
                initMarkers(map, infoWindow);
            });


        } else {
            handleLocationError(false, map, infoWindow);
            initMarkers(map, infoWindow);
            // Browser doesn't support Geolocation

        }
        function initMarkers(map, infoWindow) {
         if (userId.localeCompare("error") === 0) {
                handleUserError(map, infoWindow);
             } else if (errorMaps.localeCompare("fail") === 0){
               handleUserError(map, infoWindow);
              }
                else {
                   VK.init(function() {
                        // API initialization succeeded
                         initPlaygroundMarkers(map);
                         VK.addCallback('onAllowMessagesFromCommunity', function f(location){
                                     allow();
                                 });

                     }, function() {
                          // API initialization failed
                        //handleUserError(map, infoWindow);
                        initPlaygroundMarkers(map);
                   }, '5.67');
            }
        }
    }

    function allow() {
           allowMessage.data = "true";
    }

    function initPlaygroundMarkers(map) {
        var labels = 'Футбол';
        var imageFootball = 'resources/images/ball.png';
        var imageBasketball = 'resources/images/basketballSm.png';
        var imageVoleyball = 'resources/images/voleyballSm.png';

        var  allInfowindow = [];
        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "footLocations" array.
        // The map() method here has nothing to do with the Google Maps API.
        footMarkers = footLocations.map(function(location, i) {
            var marker = new google.maps.Marker({
                position: location,
                icon: imageFootball
            });

            var footInfowindow = new google.maps.InfoWindow({
                content: getFootWindowContent(footInfo, i, userId, allowMessage)
            });
            allInfowindow.push(footInfowindow);

            marker.addListener('click', function() {
                closeAllInfoWindows();
                footInfowindow.open(map, marker);

            });

            /*map.addListener('click', function(){
             footInfowindow.close();
             });*/
            return marker;
        });


        basketMarkers = basketLocation.map(function(location, i) {
            var bmarker = new google.maps.Marker({
                position: location,
                icon: imageBasketball
            });

            var basketInfowindow = new google.maps.InfoWindow({
                content: getBasketWindowContent(basketInfo, i, userId)
            });
            allInfowindow.push(basketInfowindow);
            bmarker.addListener('click', function() {
                closeAllInfoWindows();
                basketInfowindow.open(map, bmarker);

            });

            /* map.addListener('click', function(){
             basketInfowindow.close();
             }); */
            return bmarker;
        });


        voleyMarkers = voleyLocation.map(function(location, i) {
            var vmarker = new google.maps.Marker({
                position: location,
                icon: imageVoleyball
            });

            var voleyballInfowindow = new google.maps.InfoWindow({
                content: getVoleyballWindowContent(voleyballInfo ,i , userId)
            });
            allInfowindow.push(voleyballInfowindow);
            vmarker.addListener('click', function() {
                closeAllInfoWindows();
                voleyballInfowindow.open(map, vmarker);

            });
            /* map.addListener('click', function(){
             voleyballInfowindow.close();
             });*/
            return vmarker;
        });

        map.addListener('click', function(){
            closeAllInfoWindows();
        });
        var markers = footMarkers.concat(basketMarkers, voleyMarkers);


        // Add a marker clusterer to manage the markers.
        markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});

        function closeAllInfoWindows(){
            allInfowindow.map(function(infoWindow, i) {
                infoWindow.close();
            });
        }

    }



    $(function() {
        $('#football').click(function(event) {
            markerCluster.clearMarkers();
            markerCluster.addMarkers(footMarkers);
        });
    });
    $(function() {
        $('#basketball').click(function(event) {
            markerCluster.clearMarkers();
            markerCluster.addMarkers(basketMarkers);
        });
    });

    $(function() {
        $('#voleyball').click(function(event) {
            markerCluster.clearMarkers();
            markerCluster.addMarkers(voleyMarkers);
        });
    });



</script>
<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA1tr-_gVY9qwaDTDpvfgckDzV_uqekjEQ&libraries=places&callback=initMap">
</script>

</body>
</html>