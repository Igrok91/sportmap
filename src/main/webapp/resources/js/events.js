function addIgrok(maxCountAnswer, eventId, userId) {
    var addIgr = $('#countIgrok_' + eventId).val();
    $.ajax({
        url: 'addIgrok?eventId=' + eventId + '&count=' + addIgr + '&userId=' + userId
    }).then(function (value) {
        switch (value) {
            case 'true':
                if (maxCountAnswer == 1000) {
                    var clone = document.getElementById(userId + '_imgUser_' + eventId + '_fake');
                    if (clone) {
                        var countRemove = parseInt(document.getElementById(userId + "_add_" + eventId).getAttribute('count'));
                        var count = $('#badge1_'+ eventId).text();
                        $('#badge1_' + eventId).text(count - countRemove);
                        // var userList = document.getElementById('imgUserList_' + eventId);
                        // userList.removeChild(clone);
                        $('#'+userId + '_imgUser_' + eventId + '_fake').remove();
                    }
                    var count = parseInt($('#badge1_'+ eventId).text());
                    count = count + parseInt(addIgr);
                    $('#badge1_' + eventId).text(count);
                    if (!isWatch) {
                        addFakeIgrokToUserList(eventId, addIgr, userId);
                    }
                    $('#addIgrok_'+ eventId).modal('hide');

                } else {
                    var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                    console.log(count[0]);
                    var clone = document.getElementById(userId + '_imgUser_' + eventId + '_fake');
                    if (clone) {
                        var countRemove = parseInt(document.getElementById(userId + "_add_" + eventId).getAttribute('count'));
                        var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                        count = count - countRemove;
                        $('#badge2_' + eventId).text(count + ' / ' + maxCountAnswer );
                        $('#'+userId + '_imgUser_' + eventId + '_fake').remove();
                    }
                    count = count + parseInt(addIgr);
                    $('#badge2_' + eventId).text(count + ' / ' + maxCountAnswer );
                    if (!isWatch) {
                        addFakeIgrokToUserList(eventId, addIgr, userId);
                    }
                    $('#addIgrok_' + eventId).modal('hide');
                }
                break;
            case 'max_count_answer':
                $('#alertMax_' + eventId).removeClass('hide');
                $('#alertMax_' + eventId).alert();
                $('#addIgrok_' + eventId).modal('hide');
                break;

        }

    });
}

function handleAnswer(maxCountAnswer, eventId, userId) {
    $.ajax({
        url: 'handleAnswer?eventId=' + eventId + '&userId=' + userId
    }).then(function (value) {
        console.log('answer ' + value);
        switch (value) {
            case 'true':
                $('#cancelAnswer_'+ eventId).removeClass('hide');
                $('#doAnswer_'+ eventId).addClass('hide');
                $('#cancelAnswer2_'+ eventId).removeClass('hide');
                $('#doAnswer2_'+ eventId).addClass('hide');

                $('#answerButton_'+ eventId).removeClass('active');
                $('#answerButton_'+ eventId).css('background','#EAEAEC');
                $('#answerOk_'+ eventId).removeClass('hide');

                if (maxCountAnswer == 1000) {
                    var count = parseInt($('#badge1_'+ eventId).text());
                    ++count;
                    $('#badge1_'+ eventId).text(count);
                    if (!isWatch) {
                        addIgrokToUserList(eventId, userId);
                    }
                } else {
                    var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                    ++count;
                    $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                    if (!isWatch) {
                        addIgrokToUserList(eventId, userId);
                    }
                }
                break;
            case 'false':
                $('#addIgrok_' + eventId).modal('show');
                break;
            case 'max_count_answer':
                $('#alertMax_' + eventId).removeClass('hide');
                $('#alertMax_' + eventId).alert();
                break;
        }

    });
}

function handleAnswerMain(maxCountAnswer, eventId, userId) {
    $.ajax({
        url: 'handleAnswerMain?eventId=' + eventId + '&userId=' + userId
    }).then(function (value) {
        console.log('answer ' + value);
        switch (value) {
            case 'true':
                $('#cancelAnswer_'+ eventId).removeClass('hide');
                $('#doAnswer_'+ eventId).addClass('hide');
                $('#cancelAnswer2_'+ eventId).removeClass('hide');
                $('#doAnswer2_'+ eventId).addClass('hide');

                $('#answerButton_'+ eventId).removeClass('active');
                $('#answerButton_'+ eventId).css('background','#EAEAEC');
                $('#answerOk_'+ eventId).removeClass('hide');

                if (maxCountAnswer == 1000) {

                    var count = $('#badge1_'+ eventId).text();
                    ++count;
                    $('#badge1_'+ eventId).text(count);
                    if (!isWatch) {
                        addIgrokToUserList(eventId);
                    }
                } else {
                    var count = parseInt($('#badge2_'+ eventId).text().split(' / ')[0]);
                    $('#answerButton_'+ eventId).removeClass('active');
                    $('#answerButton_'+ eventId).css('background','#EAEAEC');
                    $('#answerOk_'+ eventId).removeClass('hide');
                    ++count;
                    $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                    if (!isWatch) {
                        addIgrokToUserList(eventId);
                    }
                }
                break;
            case 'false':
                $('#cancelAnswer_'+ eventId).addClass('hide');
                $('#doAnswer_'+ eventId).removeClass('hide');
                $('#cancelAnswer2_'+ eventId).addClass('hide');
                $('#doAnswer2_'+ eventId).removeClass('hide');

                $('#answerButton_'+ eventId).addClass('active');
                $('#answerButton_'+ eventId).css('background','');
                $('#answerOk_'+ eventId).addClass('hide');

                if (maxCountAnswer == 1000) {

                    var count = $('#badge1_'+ eventId).text();
                    $('#badge1_'+ eventId).text(count - 1);
                } else {
                    var count = parseInt($('#badge2_'+ eventId).text().split(' / '));
                    --count;
                    $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                }
                $('#' + userId + '_imgUser_'+ eventId).remove();


                var userAdd = document.getElementById(userId + '_imgUser_'+ eventId + '_fake');
                if(userAdd) {
                    var countRemove = parseInt(document.getElementById(userId + '_add_' + eventId).getAttribute('count'));
                    if (maxCountAnswer == 1000) {
                        var count = $('#badge1_'+ eventId).text();
                        $('#badge1_'+ eventId).text(count - countRemove);
                    } else {
                        var count = parseInt($('#badge2_'+ eventId).text().split(' / '));
                        count = count - countRemove;
                        $('#badge2_'+ eventId).text(count + ' / ' + maxCountAnswer );
                    }
                    $('#' + userId + '_imgUser_'+ eventId + '_fake' ).remove();
                }
                $('#answerButton_' + eventId).removeClass('disabled');
                break;
            case 'max_count_answer':
                $('#alertMax_' + eventId).removeClass('hide');
                $('#alertMax_' + eventId).alert();
                break;
        }

    });
}

function addFakeIgrokToUserList(eventId, addIgr, userId) {
    $('#templateUserList2').removeClass('hide');
    $('#imageUser').addClass('hide');
    var userImg = document.getElementById("templateUserList2").cloneNode(true);
    userImg.id = userId + '_imgUser_' + eventId + '_fake';
    userImg.href = "user?userId=" + userId;
    var span = document.createElement('span');
    span.id = userId + '_add_' + eventId;
    span.setAttribute('count', addIgr);
    span.appendChild(document.createTextNode("+" + addIgr));
    userImg.appendChild(span);
    $('#imgUserList_' + eventId).append(userImg)
    $('#templateUserList2').addClass('hide');
    $('#imageUser').removeClass('hide');

}

function addIgrokToUserList(eventId, userId) {
    $('#templateUserList2').removeClass('hide');
    var userImg = document.getElementById("templateUserList2").cloneNode(true);
    userImg.id = userId + '_imgUser_' + eventId;
    userImg.href = "user?userId=" + userId;
    $('#imgUserList_' + eventId).append(userImg);
    $('#templateUserList2').addClass('hide');
}