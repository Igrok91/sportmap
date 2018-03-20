<%--
  Created by IntelliJ IDEA.
  User: Igor
  Date: 03.04.2017
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <div class="pull-right dropdown hide" id="dropdownTemplate" >
            <a href="#" class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu3" style="padding-left: 0px;padding-right: 0px">  <span class="glyphicon glyphicon-option-vertical "></span></a>
            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3">
                <li><a href="#"  id="removeTemlates"><span class="glyphicon glyphicon-trash" style="margin-right: 20px"></span>Удалить</a></li>
            </ul>
        </div>
        <div class="row content">

                <div class="list-group" id="listTemplates">
                   <%-- <button type="button"  class="list-group-item  borderless">
                        <div class="pull-right dropdown" >
                            <a href="#" class="btn  dropdown-toggle" data-toggle="dropdown" id="dropdownMenu3" style="padding-left: 0px;padding-right: 0px">  <span class="glyphicon glyphicon-option-vertical "></span></a>
                            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu3">

                                <li><a href="#" ><span class="glyphicon glyphicon-trash" style="margin-right: 20px"></span>Удалить</a></li>
                                <li><a href="#" >
                                    <span class="glyphicon glyphicon-pencil" style="margin-right: 20px"></span>Редактировать
                                </a></li>

                            </ul>
                        </div>
                        <span  style="margin-right: 15px"><span><img src="D:\бизнес\Проекты\SportMap\Разработка\icon\новый3.png" width="20" height="20" style="margin-right: 5px; margin-bottom: 3px"></span> Описание </span><br> <span class="list-group-item-heading">   Го на игру в 18 ?</span>
                        <br>
                        <div >
                            <span  style="margin-right: 15px"><span><img src="D:\бизнес\Проекты\SportMap\Разработка\icon\опрос.png" width="20" height="20" style="margin-right: 5px"></span> Варианты ответа </span>  <br>
                            <span class="list-group-item-heading "> Да, приду </span>
                            <br>
                            <span class="list-group-item-heading"> Не могу </span>
                        </div>

                        <div >
                            <span  style="margin-right: 15px"><span><img src="D:\бизнес\Проекты\SportMap\Разработка\icon\количество.png" width="20" height="20" style="margin-right: 5px"></span> Количество голосов</span>
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


    templates.map(function (template, i) {
        var list = document.getElementById('listTemplates');
        list.appendChild(getTemplatesList(template));

    });

    function getTemplatesList(template) {
        var clonedNode = document.getElementById("dropdownTemplate").cloneNode(true);
        clonedNode.className = "pull-right dropdown";

        clonedNode.childNodes[3].childNodes[1].childNodes[0].onclick = function () {
            removeTemplate(template.templateId);
        };


        var button = document.createElement('button');

        button.id = template.templateId;
        button.className = 'list-group-item borderless ';


        var description = document.createElement('h4');
        description.className = "list-group-item-heading";
        description.appendChild(document.createTextNode(template.description));

        button.appendChild(clonedNode);
        button.appendChild(description);
  /*      var answer = template.listAnswer;

        answer.map(function (answer, i) {
            var p = document.createElement('p');
            p.className = "list-group-item-text";
            p.appendChild(document.createTextNode(answer));
            button.appendChild(p);
        });*/
        var hr = document.createElement('hr');
        button.appendChild(hr);

        return button;
    }

   function removeTemplate(id) {
       $.ajax({
           url: 'removeTemplate?templateId=' + id
       }).then(function () {
           templates.map(function (template, i) {
               var list = document.getElementById('listTemplates');
               var child = document.getElementById(id);
               if (list.childNodes.length == 1) {
                   $('#templatesPanelEmpty').removeClass('hide');
               }
               while (child.firstChild) {
                   child.removeChild(child.firstChild);
               }
               list.removeChild(child);

           });

           });
   }
</script>
</body>
</html>