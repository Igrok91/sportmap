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

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {height: 450px}

        /* Set black background color, white text and some padding */



        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 480px) {
       /*     .sidenav {
                height: auto;
                padding: 15px;
            }*/

/*            .row.content {height:auto;}*/
            #pac-input {
                width: 175px;
                margin-left: 3px;
            }
        }


        .divMain {
            height: 120px;
            width: 190px;
            background-color:#fafafa;

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
    <nav class="nav navbar-static-top navbar-default">
        <div class="container-fluid ">
            <div class="pull-left" >
                <a class="navbar-brand" href="#">Поиск</a>
            </div>
            <div class="pull-right" style="margin-top: 10px">
                <span style="margin-right: 3px">Free</span>
                <!-- <span style="margin-right: 3px"><img src="\Applications\Разработка\иконки\cost2.png" alt="COST" width="30" height="30"> </span> -->
                <input type="checkbox" class="checkbox-switch2" />
            </div>
        </div>
    </nav>
    <div class="container-fluid " style="margin-bottom: 10px">
    <div class="row ">
        <div class="text-center">
            <span style="color: gray">Фильтры:</span>
            <a  class="btn" id="football"><img  src="resources/image/foot2.png" alt="Футбол" width="40" height="40"/></a>
            <a  class="btn" id="basketball"><img  src="resources/image/basket.png" alt="Баскетбол" width="40" height="40"/></a>
            <a  class="btn" id="voleyball"><img  src="resources/image/voley.png" alt="Волейбол" width="40" height="40"/></a>
            <div class="btn-group btn-group-justified">
                <a href="#" class="btn active">Список</a>
                <a href="#" class="btn ">Карта</a>
            </div>
        </div>

    </div>

    </div>
</header>
<main>
    <div class="row content hide ">
        <div class="col-md-2">

        </div>
        <div class="col-md-8">
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




    <div class="container-fluid text-center">

        <div class="row content">
            <div class="sidenav"  id ="map" >
            </div>

        </div>

    </div>
    <input id="pac-input" class="controls" type="text" placeholder="Поиск..">
</main>

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

    var infoWindow;

    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 59.93903 , lng: 30.315828},
            zoom: 11,
            mapTypeId: 'roadmap'
        });
        initAutocomplete(map);
        infoWindow = new google.maps.InfoWindow({map: map});
        infoWindow.setPosition(map.getCenter());
        infoWindow.setContent('Нажмите на маркер для перехода к площадке');
        initMarkers(map, infoWindow);
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
                //initMarkers(map, infoWindow);
                setTimeout(updateInfoWindow, 4000, infoWindow);

            }, function() {
                handleLocationError(true, map, infoWindow);
                //initMarkers(map, infoWindow);
            });


        } else {
            handleLocationError(false, map, infoWindow);
            //initMarkers(map, infoWindow);
            // Browser doesn't support Geolocation
        }
        function initMarkers(map, infoWindow) {
            if (errorMaps.localeCompare("fail") === 0){
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

        var imageFootball2 = 'resources/image/football2.png';
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
            infoWindow.close();

        });

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
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCXkXTJQMPNPInJcJt2yT6pNgzksYfpw1c&libraries=places&callback=initMap">
</script>

</body>
</html>