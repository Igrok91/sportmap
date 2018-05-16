  function handleLocationError(browserHasGeolocation, map, infoWindow) {
            //var infoWindow = new google.maps.InfoWindow({map: map});
            infoWindow.setPosition(map.getCenter());
            infoWindow.setContent(browserHasGeolocation ?
                'Не удалось определить ваше местоположение!' :
                'Не удалось определить ваше местоположение!');
             setTimeout(updateInfo, 4000, infoWindow);

  }

   function handleUserError(map, infoWindow) {
                    //var infoWindow = new google.maps.InfoWindow({map: map});
                    infoWindow.setPosition(map.getCenter());
                    infoWindow.setContent(createInfoWindowError("Ошибка при загрузке Google Maps, в ближайшее время мы ее исправим!"));

}

  function createInfoWindowError(error) {


      var divMain = document.createElement('div');
      divMain.className = "divMain";


      var p = document.createElement('p');
      p.appendChild( document.createTextNode( error ) );
      p.id = "error";

      var hr = document.createElement('hr');
      var img = document.createElement('img');
      img.src = "resources/images/error.png";

      divMain.appendChild(img);
      divMain.appendChild(p);
      return divMain;
  }

    function updateInfo(infoWindow){
        infoWindow.setContent("Нажмите на маркер для перехода к площадке");
    }
  function updateInfoWindow(infoWindow){
      infoWindow.setContent("Если нет вашей площадки, напишите нам в группу и мы ее добавим");
  }