  function handleLocationError(browserHasGeolocation, map) {
            var infoWindow = new google.maps.InfoWindow({map: map});
            infoWindow.setPosition(map.getCenter());
            infoWindow.setContent(browserHasGeolocation ?
                'Используйте поле ввода для посика на карте Google' :
                'Error: Your browser doesn\'t support geolocation.');
        }

   function handleUserIdError(map, errorUserId) {
                    var infoWindow = new google.maps.InfoWindow({map: map});
                    infoWindow.setPosition(map.getCenter());
                    infoWindow.setContent(errorUserId);
                }


          function handleMapsError(map, errorMaps) {
                            var infoWindow = new google.maps.InfoWindow({map: map});
                            infoWindow.setPosition(map.getCenter());
                            infoWindow.setContent(errorMaps);
                        }

