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

function sendMessage(idFoot, userID, a, p, div) {
    a.className = "btn btn-success btn-xs disabled";
    $.ajax({
        url : "sendMessage",
        data : ({idPlay : idFoot, userID : userID}),
        success : function(data) {
        //$('#sms').html("Ссылка отправлена");
            if (data.localeCompare("success") === 0){
                p.innerHTML = "Ссылка отправлена";
                setTimeout(update, 4000, a, p);
            } else if (data.localeCompare("stopMessage") === 0) {
                //p.innerHTML = "Лимит сообщений превышен и отключен на 5 миннут!";
                   var coString = '<div>' +
                 '<h4> Ошибка </h4>'+
                 '</div>';
                   div.innerHTML = coString;
               // setTimeout(update, 7000, a, p);
            }else if (data.localeCompare("fail") === 0) {
                p.innerHTML = "Произошла ошибка при отправки сообщения!";
                setTimeout(update, 7000, a, p);
            }

    }
});
    function update(aa, pp) {
       // $('#sms').html("Получить ссылку");
        aa.className = "btn btn-success btn-xs";
        pp.innerHTML = "Получить ссылку";
    }
}

function createInfoWindow(info, index, userId) {

    var idFoot = info[index].id;
    var userID = userId;

    var divMain = document.createElement('div');
    divMain.className = "divMain";
    var name = document.createElement('h4');
    name.appendChild( document.createTextNode(info[index].namePlayground));

    var p = document.createElement('p');
    p.appendChild( document.createTextNode( "Получить ссылку" ) );
    p.id = "sms";

    var hr = document.createElement('hr');
    var div = document.createElement('div');
    div.className = "btn-group ";

    var a = document.createElement('a');
    a.id = "button";
    var img = document.createElement('img');
    img.src = "resources/images/whatsapp2.png";

    a.className = "btn btn-success btn-xs";
    a.role = "button";
    a.id = "footballId";
    a.onclick = function () {
        sendMessage(idFoot, userID, a, p, divMain);
    };
    //a.appendChild( document.createTextNode( "Получить ссылку" ) );
    a.appendChild(img);
    div.appendChild(a);

    divMain.appendChild(name);
    divMain.appendChild(div);
    //divMain.appendChild(hr);
    divMain.appendChild(p);
    return divMain;
}