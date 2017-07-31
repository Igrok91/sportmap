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
    <link rel="stylesheet" href="resources/button.css">
    <script src="resources/js/searchBox.js"></script>
    <script src="resources/js/infoWindow.js"></script>
    <script src="resources/js/error.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
            background-color: #384e73;
            color: #f0f3ff;
            padding: 7px;
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
            height: 110px;
            width: 190px;
            background-color:#fafafa;

        }

        hr {

            margin-top: 3px;
            margin-bottom: 10px;
        }


        .subtitleMap{
            padding: 1px;
            margin-top: 10px;
            margin-bottom: 10px;
            font-family:Trebuchet MS;
            color:#525252;
        }

        h5 {
            padding-top: 10px;
        }

    </style>
</head>
<body>

<%--<nav class="navbar navbar-inverse navbar-static-top">
    <div class="container ">
        <div class="navbar-header " >
            <a class="navbar-brand" href="#">SportMap</a>
        </div>
    </div>
</nav>--%>
<header>
    <div class="container-fluid" >
        <div class="row text-center">
            <h3 class="subtitleMap">Найди свою территорию спорта!</h3>
            <hr>
            <div class="container">
                <%--<div class="btn-group ">--%>
                    <a  class="myButton btn btn-default btn-sm" id="football" role="button">
                        <img src="resources/image/football.png" alt="" align="middle">
                    </a>
                    <a class="myButton btn btn-default btn-sm" id="basketball">
                        <img src="resources/image/basketball.png" alt="" align="middle">
                    </a>
                    <a  class="myButton btn btn-default btn-sm" id="voleyball">
                        <img src="resources/image/voleyball.png" alt="" align="middle">
                    </a>
                <%--</div>--%>
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
<input id="pac-input" class="controls" type="text" placeholder="Поиск..">
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
                initPlaygroundMarkers(map);
            }
        }
    }


    function initPlaygroundMarkers(map) {
        var labels = 'Футбол';
        var imageFootball = 'resources/images/ball.png';
        var imageBasketball = 'resources/images/basketballSm.png';
        var imageVoleyball = 'resources/images/voleyballSm.png';

        var imageFootball2 = 'resources/images/ball2.png';
        var imageBasketball2 = 'resources/images/basketballSm2.png';
        var imageVoleyball2 = 'resources/images/voleyballSm2.png';


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
                content: getFootWindowContent(footInfo, i, userId)
            });
            allInfowindow.push(footInfowindow);

            marker.addListener('click', function() {
                closeAllInfoWindows();
                marker.icon = imageFootball2;
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


        var markers = footMarkers.concat(basketMarkers, voleyMarkers);
            map.addListener('click', function(){
            closeAllInfoWindows();

        });

        // Add a marker clusterer to manage the markers.
        markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});

        function closeAllInfoWindows(){
            allInfowindow.map(function(infoWindow, i) {
                infoWindow.close();
            });
            markers.map(function(marker, i) {
                   if (marker.icon !== imageFootball) {
                            marker.icon = imageFootball;
                   }

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