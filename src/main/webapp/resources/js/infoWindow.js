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

function sendMessage(idFoot, userID, a) {
    $.ajax({
        url : "sendMessage",
        data : ({idFoot : idFoot, userID : userID}),
        success : function(data) {
        $('#sms').html("Ссылка отправлена");
        a.className = "btn btn-success btn-xs disabled";
        setTimeout(update, 6000);
    }
});
    function update() {
        $('#sms').html("Получить ссылку");
        a.className = "btn btn-success btn-xs";
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
        sendMessage(idFoot, userID, a );
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