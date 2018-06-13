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

    <style>

        /* Set black background color, white text and some padding */

        .borderless {
            border: 0 none;

        }

        hr {
            margin-top: 5px;
            margin-bottom: 0px;
        }

    </style>
</head>
<body>

<main>

    <div class="container-fluid ">
        <%--  <div class="pull-right hide" id="dropdownTemplate" >
               <button class="btn"  id="templateButton" style="padding-left: 6px;padding-right: 6px;background: white">  <span class="glyphicon glyphicon-remove " style="color: #77A5C5"></span></button>
           </div>--%>
        <div class="row content">
            <div class="list-group" id="listTemplates">
                <c:forEach var="templ" items="${template}">
                    <a href="createGameFromTemplate?templateId=${templ.templateId}&userId=${userId}&playgroundId=${playgroundId}&sport=${sport}&namePlayground=${namePlayground}&city=${city}"
                       onclick="disabledLink('${templ.templateId}')" class="list-group-item  borderless"
                       id="${templ.templateId}">
                        <h5>${templ.description}</h5>
                    </a>

                </c:forEach>
                <%-- <button type="button"  class="list-group-item  borderless">
                     <div class="pull-right dropdown" >
                         <a href="#" class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu3" style="padding-left: 0px;padding-right: 0px">  <span class="glyphicon glyphicon-option-vertical "></span></a>
                         <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3">

                             <li><a href="#" ><span class="glyphicon glyphicon-trash" style="margin-right: 20px"></span>Удалить</a></li>

                         </ul>
                     </div>
                     <span  style="margin-right: 15px"><span><img src="D:\бизнес\Проекты\SportMap\Разработка\icon\new.png" width="20" height="20" style="margin-right: 5px; margin-bottom: 3px"></span> Описание </span><br> <span class="list-group-item-heading">   Го на игру в 18 ?</span>
                     <br>
                     <div >
                         <span  style="margin-right: 15px"><span><img src="D:\бизнес\Проекты\SportMap\Разработка\icon\опрос.png" width="20" height="20" style="margin-right: 5px"></span> Варианты ответа </span>  <br>
                         <span class="list-group-item-heading "> Да, приду </span>
                         <br>
                         <span class="list-group-item-heading"> Не могу </span>
                     </div>

                     <div >
                         <span  style="margin-right: 15px"><span><img src="D:\бизнес\Проекты\SportMap\Разработка\icon\count.png" width="20" height="20" style="margin-right: 5px"></span> Количество голосов</span>
                         <span class="list-group-item-heading "> 20</span>

                     </div>

                     <hr>

                 </button>--%>
                <%--           <a href="#" class="list-group-item  borderless">
                               <h4 class="list-group-item-heading">   Го на игру в 18 ?</h4>
                               <p class="list-group-item-text"> Да, приду </p>
                               <p class="list-group-item-text"> Не могу </p>
                               <hr>

                           </a>--%>

            </div>
            <div id="templatesPanelEmpty" class="hide">
                <p style="color: darkgray">У вас пока нет шаблонов</p>
            </div>
        </div>


    </div>
    </div>
</main>


<script>

    var templates = ${templates};
    var sport = '${sport}';


    /*   templates.map(function (template, i) {
           var list = document.getElementById('listTemplates');
           list.appendChild(getTemplatesList(template));

       });*/

    function getTemplatesList(template) {
        /*    var templButton = document.getElementById("templateButton");
            templateButton.onclick = function () {
                removeTemplate(template.templateId);
            };
            var clonedNode = document.getElementById("dropdownTemplate").cloneNode(true);
            clonedNode.className = "pull-right";*/

        /*        clonedNode.childNodes[3].childNodes[1].childNodes[0].onclick = function () {
                    removeTemplate(template.templateId);
                };*/

        var a = document.createElement('a');

        a.id = template.templateId;
        a.className = 'list-group-item borderless ';

        a.href = "createGameFromTemplate?templateId=" +
            template.templateId + "&userId=" + ${userId} +"&playgroundId=" +
            "${playgroundId}" + "&sport=" + "${sport}" + "&namePlayground=${namePlayground}&city=${city}";

        var description = document.createElement('h5');
        // description.className = "list-group-item-text";
        description.appendChild(document.createTextNode(template.description));

        a.appendChild(description);

        return a;
    }

    function removeTemplate(id) {
        $.ajax({
            url: 'removeTemplate?userId=' + ${userId}
        }).then(function () {
            var list = document.getElementById('listTemplates');
            while (list.firstChild) {
                list.removeChild(list.firstChild);
            }

            if (list.childNodes.length == 0) {
                $('#templatesPanelEmpty').removeClass('hide');

            }
            $('#savetempltext').text('Сохранить в шаблоны');
            $('#savetempl').css({"pointer-events": ""});

        });
    }

    function setIdTemplate(templateId) {
        $('#templId').attr('value', templateId);
    }

    function disabledLink(id) {
        $('#' + id).addClass("disabled");
        /* templates.map(function (templ) {
             $('#' + templ.templateId).addClass("disabled");
         });*/
    }
</script>
</body>
</html>