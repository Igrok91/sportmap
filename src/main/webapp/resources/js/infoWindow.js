/**
 * Created by IgorR on 25.06.2017.
 */
function getFootWindowContent(info, index ){


    var coString = '<div>' +
        '<h4>' + info[index].namePlayground + '</h4> <hr>' +
        '<div class="btn-group ">' +
        ' <a href="sendMessage/' + info[index].id +'"  class="btn btn-primary" id="footballInfo" role="button" >' +
        'Перейти в группу' + ' </a>' +
        '</div>' +
        '</div>';

    return coString;
}

function getBasketWindowContent(info, index ){


    var coString = '<div>' +
        '<h4>' + info[index].namePlayground + '</h4> <hr>' +
        '<div class="btn-group ">' +
        ' <a href="  ' + info[index].link +'"  class="btn btn-primary" id="basketballInfo" role="button" >' +
        'Перейти в группу' + ' </a>' +
        '</div>' +
        '</div>';

    return coString;
}

function getVoleyballWindowContent(info, index ){


    var coString = '<div>' +
        '<h4>' + info[index].namePlayground + '</h4> <hr>' +
        '<div class="btn-group ">' +
        ' <a href="  ' + info[index].link +'"  class="btn btn-primary" id="voleyballInfo" role="button" >' +
        'Перейти в группу' + ' </a>' +
        '</div>' +
        '</div>';

    return coString;
}

