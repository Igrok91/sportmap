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
    <link rel="stylesheet" href="resources/searchBox.css">
    <link rel="stylesheet" href="resources/button.css">
    <script src="resources/js/searchBox.js"></script>
    <script src="resources/js/infoWindow.js"></script>
    <script src="resources/js/error.js"></script>
    <script src="resources/js/markerclusterer.js"></script>

    <style>
        /* Remove the navbar's default margin-bottom and rounded borders */

        /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
        .row.content {
            height: 550px
        }

        /* Set black background color, white text and some padding */

        .borderless {
            border: 0 none;

            box-shadow: none;

        }

        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 480px) {
            .sidenav {
                height: auto;
            }

            /*            .row.content {height:auto;}*/
            #pac-input {
                width: 175px;
                margin-left: 3px;
            }
        }

        .divMain {
            /*
                        height: 90px;
                        width: 140px;
            */

        }

        .divTitle {
            /*background-color:#fafafa;*/

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
    <nav class="nav navbar-static-top navbar-default navSportMap">
        <div class="container-fluid ">
            <div class="pull-left">
                <a class="navbar-brand" href="#">Поиск</a>
            </div>
            <%--     <div class="pull-right" style="padding: 10px">
                     <a class="btn" href="#" onclick="loadPlaygrounds()">Добавить</a>
                 </div>--%>

            <%--    <div class="pull-right" style="margin-top: 10px">
                    <span style="margin-right: 3px">Free</span>
                    <input type="checkbox" class="checkbox-switch2" />
                </div>--%>
            <div class="pull-right dropdown" style="padding-top: 10px">
                <a class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu5"><span
                        class="glyphicon glyphicon-filter"></span></a>
                <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu5">
                    <li><a href="#" id="football" style="padding-top: 3px;padding-bottom: 3px;">
                        <div class="media">
                            <div class="pull-left">
                                <img class="media-object" src="resources/image/foot.png" alt="Футбол" width="20"
                                     height="20" style="margin-top: 5px"/>
                            </div>


                            <div class="media-body ">
                                <h5 class="media-heading" style="margin-top: 7px;margin-bottom: 7px">Футбол</h5>
                            </div>
                        </div>
                    </a></li>
                    <li><a href="#" id="basketballPlayground">
                        <div class="media">
                            <div class="pull-left">
                                <img src="resources/image/basket.png" alt="Футбол" width="20" height="20"
                                     style="margin-top: 5px"/>
                            </div>


                            <div class="media-body ">
                                <h5 class="media-heading" style="margin-top: 7px;margin-bottom: 7px">Баскетбол</h5>
                            </div>
                        </div>
                    </a></li>
                    <li><a href="#" id="voleyballPlayground">
                        <div class="media">
                            <div class="pull-left">
                                <img src="resources/image/voley.png" alt="Футбол" width="20" height="20"
                                     style="margin-top: 5px"/>
                            </div>


                            <div class="media-body ">
                                <h5 style="margin-top: 7px;margin-bottom: 7px">Волейбол</h5>
                            </div>
                        </div>
                    </a></li>
                </ul>
            </div>
        </div>
    </nav>

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
                            <img class="media-object" src="resources/image/стадион3.png" alt="Футбол" width="40"
                                 height="40"/>
                        </div>


                        <div class="media-body ">
                            <h4 class="media-heading">Площадка у школы № 29</h4>
                            <span style="color: gray">Футбол</span>
                            <hr>
                        </div>
                    </div>
                </a>
                <a href="#" class="list-group-item borderless">
                    <div class="media">
                        <div class="pull-left">
                            <img class="media-object" src="resources/image/площадка2.png" alt="Баскетбол" width="40"
                                 height="40"/>
                        </div>

                        <div class="media-body">
                            <h4 class="media-heading">Площадка у школы № 345</h4>
                            <span style="color: gray">Баскетбол</span>
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
            <div class="sidenav panel borderless" id="map">
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

    function setBackPosition(map) {
        var coor = ${playgroundCoordinate};
        map.setCenter(coor);
    }

    var map;

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {lat: 59.93903, lng: 30.315828},
            zoom: 11,
            mapTypeId: 'roadmap'
        });
        initAutocomplete(map);
        infoWindow = new google.maps.InfoWindow({map: map});
        infoWindow.setPosition(map.getCenter());
        infoWindow.setContent('Нажмите на маркер для перехода к группе');
        initMarkers(map, infoWindow);
        var returnBack = '${returnBack}';
        if (returnBack == 'map') {
            setBackPosition(map);
        } else if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                var pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                infoWindow.setPosition(pos);
                infoWindow.setContent('Нажмите на маркер для перехода к группе');
                map.setCenter(pos);
                //initMarkers(map, infoWindow);
                setTimeout(updateInfoWindow, 4000, infoWindow);

            }, function () {
                handleLocationError(true, map, infoWindow);
                //initMarkers(map, infoWindow);
            });


        } else {
            handleLocationError(false, map, infoWindow);
            //initMarkers(map, infoWindow);
            // Browser doesn't support Geolocation
        }

        function initMarkers(map, infoWindow) {
            if (errorMaps.localeCompare("fail") === 0) {
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

        var allInfowindow = [];

        /*$.ajax({
            url: 'initPlaygroundInfo'
        }).then(function (value) {
            console.log(value);
            var playgroundInfo = value;
            playgroundInfo.map(function(playground, i) {
                if (playground.sport === 'Футбол') {
                    footInfo.push(playground);
                    var locations = {
                        "lat": playground.lat,
                        "lng": playground.lng
                    }
                    footLocations.push(locations);
                } else if (playground.sport === 'Баскетбол') {
                    basketInfo.push(playground);
                    var locations = {
                        "lat": playground.lat,
                        "lng": playground.lng
                    }
                    basketLocation.push(locations);
                } else if (playground.sport === 'Волейбол') {
                    voleyballInfo.push(playground);
                    var locations = {
                        "lat": playground.lat,
                        "lng": playground.lng
                    }
                    voleyLocation.push(locations);
                }
            });
        }*/


        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "footLocations" array.
        // The map() method here has nothing to do with the Google Maps API.
        footMarkers = footLocations.map(function (location, i) {
            var marker = new google.maps.Marker({
                position: location,
                icon: imageFootball
            });

            var footInfowindow = new google.maps.InfoWindow({
                content: getFootWindowContent(footInfo, i, userId)
            });
            allInfowindow.push(footInfowindow);

            marker.addListener('click', function () {
                closeAllInfoWindows();
                footInfowindow.open(map, marker);
            });

            /*map.addListener('click', function(){
             footInfowindow.close();
             });*/
            return marker;
        });


        basketMarkers = basketLocation.map(function (location, i) {
            var bmarker = new google.maps.Marker({
                position: location,
                icon: imageBasketball
            });

            var basketInfowindow = new google.maps.InfoWindow({
                content: getBasketWindowContent(basketInfo, i, userId)
            });
            allInfowindow.push(basketInfowindow);
            bmarker.addListener('click', function () {
                closeAllInfoWindows();
                basketInfowindow.open(map, bmarker);

            });

            /* map.addListener('click', function(){
             basketInfowindow.close();
             }); */
            return bmarker;
        });


        voleyMarkers = voleyLocation.map(function (location, i) {
            var vmarker = new google.maps.Marker({
                position: location,
                icon: imageVoleyball
            });

            var voleyballInfowindow = new google.maps.InfoWindow({
                content: getVoleyballWindowContent(voleyballInfo, i, userId)
            });
            allInfowindow.push(voleyballInfowindow);
            vmarker.addListener('click', function () {
                closeAllInfoWindows();
                voleyballInfowindow.open(map, vmarker);

            });
            /* map.addListener('click', function(){
             voleyballInfowindow.close();
             });*/
            return vmarker;
        });


        var markers = footMarkers.concat(basketMarkers, voleyMarkers);
        map.addListener('click', function () {
            closeAllInfoWindows();
            infoWindow.close();

        });

        // Add a marker clusterer to manage the markers.
        markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'resources/image/m'});

        function closeAllInfoWindows() {
            allInfowindow.map(function (infoWindow, i) {
                infoWindow.close();
            });


        }
    }


    $(function () {
        $('#football ').click(function (event) {
            markerCluster.clearMarkers();
            markerCluster.addMarkers(footMarkers);
        });
    });
    $(function () {
        $('#basketballPlayground').click(function (event) {
            markerCluster.clearMarkers();
            markerCluster.addMarkers(basketMarkers);
        });
    });

    $(function () {
        $('#voleyballPlayground').click(function (event) {
            markerCluster.clearMarkers();
            markerCluster.addMarkers(voleyMarkers);
        });
    });

    function loadPlaygrounds() {
        $.ajax({
            url: 'loadPlayground'
        }).then(function (value) {
            console.log('loadPlayground success')
        });

    }

</script>

<script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCXkXTJQMPNPInJcJt2yT6pNgzksYfpw1c&libraries=places">
</script>
<%--<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>--%>

</body>
</html>