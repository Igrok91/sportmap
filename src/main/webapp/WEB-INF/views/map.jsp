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

        /* On small screens, set height to 'auto' for sidenav and grid */
        @media screen and (max-width: 480px) {

            /*            .row.content {height:auto;}*/
            #pac-input {
                width: 175px;
                margin-left: 3px;
            }
        }

        #map {
            width: 100%;
            height: 550px;
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
<header>
    <nav id="navbarSearch" class="nav navbar-static-top navbar-default">
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
            <c:if test="${user.isAdmin() == true}">
                <div id="addPlaygroundToMap" class="pull-right hide dropdown" style="padding-top: 10px">
                    <a id="addPlaygroundToMapLink" class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span
                            class="glyphicon glyphicon-plus"></span></a>
                    <a id="cancelAddPlaygroundToMapLink" class="btn hide" onclick="cancelAddPlaygroundToMapLink()"
                       href="#"><span
                            class="glyphicon glyphicon-trash" style="padding-top: 3px"></span></a>
                    <ul class="dropdown-menu" role="menu" aria-labelledby="addPlaygroundToMapLink">
                        <li><a href="#" onclick="addPlaygroundToMap('Футбол')"
                               style="padding-top: 3px;padding-bottom: 3px;">
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
                        <li><a href="#" onclick="addPlaygroundToMap('Баскетбол')">
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
                        <li><a href="#" onclick="addPlaygroundToMap('Волейбол')">
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
            </c:if>

            <c:if test="${user.isAdmin() == true && countPlaygroundAdd > 0}">
                <div class="pull-right" style="padding-top: 10px">
                    <a id="notifyAddPlayground" class="btn" onclick="getNotifications()" href="#"><span
                            class="glyphicon glyphicon-bell" style="padding-right: 5px"></span> <c:out
                            value="${countPlaygroundAdd}"/></a>
                </div>
            </c:if>
        </div>
    </nav>

</header>
<main id="mapMain">
    <div id="map" class="text-center">
    </div>
    <input id="pac-input" class="controls" type="text" placeholder="Поиск..">

    <div class="modal fade" id="addPlayModal" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                    <div class="text-center">
                        <img src="resources/image/стадион.png" alt="Баскетбол"
                             width="40" height="40" id="imageGroup">
                    </div>
                    <h4 id="titleAdd" class="modal-title text-center"></h4>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <c:choose>
                            <c:when test="${subscriptionStatus == 'active' || subscriptionIntern == 'active'}">
                                <p>После проверки, площадка будет добавлена на карту <span
                                        style="padding-right: 5px; padding-left: 5px"
                                        class="glyphicon glyphicon-globe"></span></p>
                            </c:when>
                            <c:otherwise>
                                <p>После проверки, площадка будет добавлена на карту <span
                                        style="padding-right: 5px; padding-left: 5px"
                                        class="glyphicon glyphicon-globe"></span>
                                    и активируется подписка "Премиум" на 3 месяца <span
                                            class="glyphicon glyphicon-star-empty"></span></p>
                            </c:otherwise>
                        </c:choose>
                        <a href="#" onclick="checkPlayground()" id="pay" class="btn btn-primary ">Добавить</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:forEach var="markerModal" items="${playgroundAddData}">
        <div class="modal fade" id="addPlayModalAdmin_${markerModal.id}" tabindex="-1" role="dialog"
             aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <div class="text-center">
                            <img src="resources/image/стадион.png" alt="Баскетбол"
                                 width="40" height="40" id="imageGroupAdmin_${markerModal.id}">
                        </div>
                        <h4 id="titleAddAdmin_${markerModal.id}" class="modal-title text-center"></h4>
                    </div>
                    <div class="modal-body">
                        <div id="alertWarningMap" class="alert alert-warning fade in hide" role="alert" style="padding-top: 10px">
                            <button type="button" class="close" onclick="hideButtonAlert('alertWarningMap')"
                                    aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            Заполните все поля!
                        </div>
                        <div class="text-center">
                            <div class="input-group" style="padding: 10px">
                                <input id="inputCity_${markerModal.id}" type="text" class="form-control" placeholder="Город" required style="margin: 5px">
                                <input id="inputName_${markerModal.id}" type="text" class="form-control" placeholder="Название площадки"  required style="margin: 5px">
                                <input id="inputStreet_${markerModal.id}" type="text" class="form-control" placeholder="Улица" required style="margin: 5px">
                                <input id="inputHouse_${markerModal.id}" type="text" class="form-control" placeholder="Дом" required style="margin: 5px">
                            </div>
                            <p id="idPlayground_${markerModal.id}"></p>
                            <a href="#"  id="addAdmin_${markerModal.id}" class="btn btn-primary ">Добавить</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>

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

    var markerAdd;
    var sportMarker;
    var playgroundAddData = ${playgroundAddDataJson};
    var playgroundAddMarker = [];

    function setBackPosition(map) {
        var coor = ${playgroundCoordinate};
        map.setCenter(coor);
    }

    var map;

    function setMobileMap() {
        if (!device.desktop()) {
            $('#mapMain').css('padding-bottom', '25px');
            $('#mapMain').css('margin-bottom', '25px');
        }
    }

    if (device.desktop()) {
        var buttonAdd = document.getElementById('addPlaygroundToMap');
        if (buttonAdd) {
            $('#addPlaygroundToMap').removeClass('hide');
        }
    }


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
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});

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

    function addPlaygroundToMap(sport) {
        $('#addPlaygroundToMapLink').addClass('hide');
        $('#cancelAddPlaygroundToMapLink').removeClass('hide');
        var myLatLng = map.getCenter();
        if (sport === 'Футбол') {

            markerAdd = new google.maps.Marker({
                position: myLatLng,
                map: map,
                title: 'Нажмите на маркер, чтобы добавить площадку',
                label: 'Ф',
                draggable: true,
                animation: google.maps.Animation.DROP
            });
        } else if (sport === 'Баскетбол') {
            markerAdd = new google.maps.Marker({
                position: myLatLng,
                map: map,
                title: 'Нажмите на маркер, чтобы добавить площадку',
                label: 'Б',
                draggable: true,
                animation: google.maps.Animation.DROP
            });
        } else if (sport === 'Волейбол') {
            markerAdd = new google.maps.Marker({
                position: myLatLng,
                map: map,
                title: 'Нажмите на маркер, чтобы добавить площадку',
                label: 'В',
                draggable: true,
                animation: google.maps.Animation.DROP
            });
        }


        markerAdd.addListener('click', function () {
            showModalAdd(sport);
        });
    }

    function showModalAdd(sport) {
        if (sport === 'Футбол') {
            $('#titleAdd').text("Футбольная площадка");
            $('#imageGroup').attr("src", "resources/image/стадион3.png")
            sportMarker = 'Футбол';
        } else if (sport === 'Баскетбол') {
            $('#titleAdd').text("Баскетбольная площадка");
            $('#imageGroup').attr("src", "resources/image/площадка2.png")
            sportMarker = 'Баскетбол';
        } else if (sport === 'Волейбол') {
            $('#titleAdd').text("Волейбольная площадка");
            $('#imageGroup').attr("src", "resources/image/спортивная-сетка.png")
            sportMarker = 'Волейбол';
        }
        $('#addPlayModal').modal('show');
    }

    function showModalAddAdmin(sport, id) {
        if (sport === 'Футбол') {
            $('#titleAddAdmin_' + id).text("Футбольная площадка");
            $('#imageGroupAdmin_' + id).attr("src", "resources/image/стадион3.png")
            sportMarker = 'Футбол';
        } else if (sport === 'Баскетбол') {
            $('#titleAddAdmin_' + id).text("Баскетбольная площадка");
            $('#imageGroupAdmin_' + id).attr("src", "resources/image/площадка2.png")
            sportMarker = 'Баскетбол';
        } else if (sport === 'Волейбол') {
            $('#titleAddAdmin_' + id).text("Волейбольная площадка");
            $('#imageGroupAdmin_' + id).attr("src", "resources/image/спортивная-сетка.png")
            sportMarker = 'Волейбол';
        }
        $('#idPlayground_' + id).text('Id площадки - ' + id);

        $('#addPlayModalAdmin_' + id).modal('show');

    }

    function cancelAddPlaygroundToMapLink() {
        markerAdd.setMap(null);
        $('#addPlaygroundToMapLink').removeClass('hide');
        $('#cancelAddPlaygroundToMapLink').addClass('hide');
    }

    function getNotifications() {
        $('#notifyAddPlayground').addClass('hide');

        playgroundAddData.forEach(function (data, i) {
            var myLatlng = new google.maps.LatLng(data.lat, data.lng);
            var marker = new google.maps.Marker({
                position: myLatlng,
                draggable: true,
                animation: google.maps.Animation.DROP
            });
            marker.addListener('click', function () {
                showModalAddAdmin(data.sport, data.id);
            });
            $('#addAdmin_' + data.id).click(function (event) {
                $('#addAdmin_' + data.id).addClass('disabled');
                addPlaygroundToDB(data.id);
                marker.setMap(null);

            });

            marker.setMap(map);
            playgroundAddMarker.push(marker);
        });
    }

    function checkPlayground() {
        $('#addPlayModal').modal('hide');
        $('#addPlaygroundToMapLink').removeClass('hide');
        $('#cancelAddPlaygroundToMapLink').addClass('hide');

        var latLng = markerAdd.getPosition();
        markerAdd.setMap(null);
        $.ajax({
            url: 'addPlaygroundToCheck?lat=' + latLng.lat() + '&lng=' + latLng.lng() + '&sport=' + sportMarker + '&userIdCreator=' + ${userId}
        }).then(function (value) {
            console.log('addPlaygroundToCheck success');
        });
    }


    function addPlaygroundToDB(id) {
        $('#addPlayModalAdmin_' + id).modal('hide');
         console.log(id + ' addPlaygroundToDB ');
        $('#addAdmin_' + id).removeClass('disabled');
        var dataMarker;
        playgroundAddData.forEach(function (data, i) {
            if (data.id === id) {
                dataMarker = data;
            }
        });
        var namePlayground = $('#inputName_' + id).val();
        var city = $('#inputCity_' + id).val();
        var street = $('#inputStreet_' + id).val();
        var house = $('#inputHouse_' + id).val();
        if (namePlayground.length === 0 || city.length === 0 || street.length === 0 || house.length === 0) {
            $('#alertWarningMap').removeClass('hide');
            $('#alertWarningMap').alert();
        } else {
            $.ajax({
                url: 'addPlaygroundToDB',
                method: 'post',
                data: ({id: dataMarker.id, lat: dataMarker.lat, lng: dataMarker.lng, userIdCreator: dataMarker.userIdCreator, name: namePlayground,
                    city: city, street: street, house: house, sport: dataMarker.sport })
            }).then(function (value) {
                console.log('loadPlayground success')
            });
        }

    }

</script>

<script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCXkXTJQMPNPInJcJt2yT6pNgzksYfpw1c&libraries=places">
</script>
<%--<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
</script>--%>

</body>
</html>