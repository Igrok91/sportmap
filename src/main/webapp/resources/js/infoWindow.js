/**
 * Created by IgorR on 25.06.2017.
 */
function getFootWindowContent(info, index ){

    var image = info[index].image;
    if (image != null){
        image ='/images/foot/' + index;
    }else {
        image = 'resources/images/volleyball.png';
    }

    var coString = '<div>' +
        '<img src=" ' + image +'" alt="image" > ' +
        '<h4>' + info[index].namePlayground + '</h4> <hr>' +
        '<div class="btn-group ">' +
        ' <a href="  ' + info[index].link +'"  class="btn btn-primary" id="football" role="button" >' +
        'Перейти в группу' + ' </a>' +
        '</div>' +
        '</div>';

    return coString;
}

function getBasketWindowContent(info, index ){

    var image = info[index].image;
    if (image != null){
        image ='/images/basket/' + index;
    }else {
        image = 'resources/images/volleyball.png';
    }

    var coString = '<div>' +
        '<img src=" ' + image +'" alt="image" > ' +
        '<h4>' + info[index].namePlayground + '</h4> <hr>' +
        '<div class="btn-group ">' +
        ' <a href="  ' + info[index].link +'"  class="btn btn-primary" id="football" role="button" >' +
        'Перейти в группу' + ' </a>' +
        '</div>' +
        '</div>';

    return coString;
}

function getVoleyballWindowContent(info, index ){

    var image = info[index].image;
    if (image != null){
        image ='/images/voley/' + index;
    }else {
        image = 'resources/images/volleyball.png';
    }

    var coString = '<div>' +
        '<img src=" ' + image +'" alt="image" > ' +
        '<h4>' + info[index].namePlayground + '</h4> <hr>' +
        '<div class="btn-group ">' +
        ' <a href="  ' + info[index].link +'"  class="btn btn-primary" id="football" role="button" >' +
        'Перейти в группу' + ' </a>' +
        '</div>' +
        '</div>';

    return coString;
}