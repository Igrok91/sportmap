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
            <hr>
            <div class="container">
                <div class="btn-group ">
                    <a  class="btn " id="football" role="button">
                        <img src="resources/images/ballMiddle.png" alt="" align="middle">
                    </a>
                    <a class="btn " id="basketball">
                        <img src="resources/images/basketball.png" alt="" align="middle">
                    </a>
                    <a  class="btn " id="voleyball">
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


    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 59.93903 , lng: 30.315828},
            zoom: 11,
            mapTypeId: 'roadmap'
        });

        initAutocomplete(map);



        // alert(footInfo[index].link);
        // Try HTML5 geolocation.
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };

                /*infoWindow.setPosition(pos);
                 infoWindow.setContent('Location found.');*/
                map.setCenter(pos);

            }, function() {
                handleLocationError(true, map.getCenter());
            });


        } else {
            // Browser doesn't support Geolocation
            handleLocationError(false, map.getCenter());
        }

        var labels = 'Футбол';
        var imageFootball = 'resources/images/ball.png';
        var imageBasketball = 'resources/images/basketballSm.png';
        var imageVoleyball = 'resources/images/voleyballSm.png';

        var  footInfowindow;

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
                content: getFootWindowContent(footInfo, i)
            });

            marker.addListener('click', function() {
                footInfowindow.open(map, marker);
            });

            map.addListener('click', function(){
                footInfowindow.close();
            });
            return marker;
        });


        basketMarkers = basketLocation.map(function(location, i) {
            var bmarker = new google.maps.Marker({
                position: location,
                icon: imageBasketball
            });

            var basketInfowindow = new google.maps.InfoWindow({
                content: getBasketWindowContent(basketInfo, i)
            });

            bmarker.addListener('click', function() {
                basketInfowindow.open(map, bmarker);
            });

            map.addListener('click', function(){
                basketInfowindow.close();
            });
            return bmarker;
        });


        voleyMarkers = voleyLocation.map(function(location, i) {
            var vmarker = new google.maps.Marker({
                position: location,
                icon: imageVoleyball
            });

            var voleyballInfowindow = new google.maps.InfoWindow({
                content: getVoleyballWindowContent(voleyballInfo ,i)
            });

            vmarker.addListener('click', function() {
                voleyballInfowindow.open(map, vmarker);
            });
            map.addListener('click', function(){
                voleyballInfowindow.close();
            });
            return vmarker;
        });
        var markers = footMarkers.concat(basketMarkers, voleyMarkers);


        // Add a marker clusterer to manage the markers.
        markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});


        function handleLocationError(browserHasGeolocation, pos) {
            var infoWindow = new google.maps.InfoWindow({map: map});
            infoWindow.setPosition(pos);
            infoWindow.setContent(browserHasGeolocation ?
                'Используйте поле ввода для посика на карте Google' :
                'Error: Your browser doesn\'t support geolocation.');
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