/**
 * Created by IgorR on 25.06.2017.
 */
function getFootWindowContent(info, index, userId){
    var infoWindow = createInfoWindow(info, index, userId, 'football');


/*    var coString = '<div>' +
        '<h4>' + info[index].namePlayground + '</h4> <hr>' +
        '<div class="btn-group ">' +
        ' <a href="' + link + '"  class="btn btn-primary" id="footballInfo" role="button" >' +
        'Перейти в группу' + ' </a>' +
        '</div>' +
        '</div>';*/


    return infoWindow;
}

function getBasketWindowContent(info, index, userId){

    var infoWindow = createInfoWindow(info, index, userId, 'basketball');

    return infoWindow;
}

function getVoleyballWindowContent(info, index, userId){

    var infoWindow = createInfoWindow(info, index, userId, 'voleyball');

    return infoWindow;
}

/*function sendMessage(idFoot, userID, a, p) {
    a.className = "whatsapp btn btn-default btn-xs disabled";
    $.ajax({
        url : "sendMessage",
        data : ({idPlay : idFoot, userID : userID}),
        success : function(data) {
        //$('#sms').html("Ссылка отправлена");
            if (data.localeCompare("success") === 0){

                p.innerHTML = "Ссылка отправлена";
                setTimeout(update, 4000, a, p);
            } else if (data.localeCompare("stopMessage") === 0) {
                //p.innerHTML = "Лимит сообщений превышен, сервис отключен на 5 миннут!";
                   var coString = '<div>' +
                 //'<img src="resources/images/error.png">' +
                  '<p>Лимит сообщений превышен! Сообщения будут доступны через 5 мин.</p>' +
                 '</div>';
                   p.innerHTML = coString;
                setTimeout(update, 10000, a, p);
            }else if (data.localeCompare("fail") === 0) {
                var coString = '<div>' +
                    //'<img src="resources/images/error.png">' +
                    '<p>Произошла ошибка при отправки сообщения!</p>' +
                    '</div>';
                p.innerHTML = coString;
                setTimeout(update, 10000, a, p);
            }

    }
});
    function update(aa, pp) {
       // $('#sms').html("Получить ссылку");
        aa.className = "whatsapp btn btn-default btn-xs";
        pp.innerHTML = "";
    }
}*/

function createInfoWindow(info, index, userId, sport) {

    var imgfootball = document.createElement('img');
    imgfootball.src = "resources/image/стадион3.png";
    imgfootball.className = ' text-center';
    imgfootball.width = '35';
    imgfootball.height = '35';
    imgfootball.style.marginBottom = '0px';


    var imgbasket = document.createElement('img');
    imgbasket.src = "resources/image/площадка2.png";
    imgbasket.className = ' text-center';
    imgbasket.width = '35';
    imgbasket.height = '35';
    imgbasket.style.marginBottom = '0px';

    var imgvoley = document.createElement('img');
    imgvoley.src = "resources/image/спортивная-сетка.png";
    imgvoley.className = ' text-center';
    imgvoley.width = '35';
    imgvoley.height = '35';
    imgvoley.style.marginBottom = '0px';

    var idFoot = info[index].id;
    var userID = userId;

    var divMain = document.createElement('div');
    divMain.className = "divMain";
    var divTitle = document.createElement('div');
    divTitle.className = "divTitle";

    var media = document.createElement('div');
    var image = document.createElement('a');
    image.href = '#';
    //image.class = 'pull-left';
    if (sport === 'basketball') {
        image.appendChild(imgbasket);
    }
    if (sport === 'voleyball') {
        image.appendChild(imgvoley);
    }
    if (sport === 'football') {
        image.appendChild(imgfootball);
    }

    var mediaBody = document.createElement('div');



    var hr = document.createElement('hr');
    hr.style.marginTop = '4px';
    hr.style.marginBottom = '0px';

    mediaBody.appendChild(document.createTextNode(info[index].namePlayground));

    media.appendChild(image);
    //media.appendChild(mediaBody);


/*    var div = document.createElement('div');
    div.className = "text-center ";
    div.id = info[index].id;*/


    var a = document.createElement('a');

    a.appendChild( mediaBody);
    a.id = "button";

    a.className = " btn toGroup";
    a.role = "button";
    a.id = info[index].id;
    a.href = "groupFromMap?playgroundId=" + info[index].id + "&sport=" + sport + "&userId=" + userId;



   // a.appendChild(img);
   // div.appendChild(a);
    divTitle.appendChild(media);
    divMain.appendChild(divTitle);
    divMain.appendChild(hr);
    divMain.appendChild(a);
    //divMain.appendChild(p);
    return divMain;
}


function getplaygroundInfo(id, sport) {
    if (sport === 'football') {
        footInfo.map(function(info, i2) {
            var idPlayground = info.id;
            if (idPlayground == id) {
                console.log('yes yes');
                return info;
            }
        });

    }

}
