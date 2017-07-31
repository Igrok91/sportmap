/**
 * Created by IgorR on 25.06.2017.
 */
function getFootWindowContent(info, index, userId){
    var infoWindow = createInfoWindow(info, index, userId);


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

    var infoWindow = createInfoWindow(info, index, userId);

    return infoWindow;
}

function getVoleyballWindowContent(info, index, userId){

    var infoWindow = createInfoWindow(info, index, userId);

    return infoWindow;
}

function sendMessage(idFoot, userID, a, p) {
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
}

function createInfoWindow(info, index, userId) {

    var idFoot = info[index].id;
    var userID = userId;

    var divMain = document.createElement('div');
    divMain.className = "divMain";
    var name = document.createElement('h5');
    name.appendChild( document.createTextNode(info[index].namePlayground));

    var p = document.createElement('p');
    p.appendChild( document.createTextNode( "" ) );
    p.id = "sms";

    var hr = document.createElement('hr');
    var div = document.createElement('div');
    div.className = "text-center ";

    var a = document.createElement('a');
    a.appendChild( document.createTextNode("Перейти в группу  "));
    a.id = "button";
    var img = document.createElement('img');
    img.src = "resources/image/whatsapp.png";

    a.className = "whatsapp btn btn-default btn-xs";
    a.role = "button";
    a.id = "footballId";
    a.href = info[index].link;
    a.target = "_blank";
    // a.onclick = function () {
    //     sendMessage(idFoot, userID, a, p);
    // };
    //a.appendChild( document.createTextNode( "Получить ссылку" ) );
    a.appendChild(img);
    div.appendChild(a);

    divMain.appendChild(name);
    divMain.appendChild(hr);
    divMain.appendChild(div);
    divMain.appendChild(p);
    return divMain;
}
