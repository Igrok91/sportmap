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

        <div class="row content">

                <div class="list-group" id="listTemplates">
         <%--           <a href="#" class="list-group-item  borderless">
                        <h4 class="list-group-item-heading">   Го на игру в 18 ?</h4>
                        <p class="list-group-item-text"> Да, приду </p>
                        <p class="list-group-item-text"> Не могу </p>
                        <hr>

                    </a>--%>

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
        list.appendChild(getTemplatesList(template, i, "createGame"));

    });

    function getTemplatesList(template, index, href) {
        var a = document.createElement('a');
        a.href = href + "?templateId=" + template.templateId + "playgroundId=" + ${playId} + "&sport=" + sport;
        a.id = template.id;
        a.className = 'list-group-item borderless ';


        var description = document.createElement('h4');
        description.className = "list-group-item-heading";
        description.appendChild(document.createTextNode(template.description));

        a.appendChild(description);
        var answer = template.listAnswer;

        answer.map(function (answer, i) {
            var p = document.createElement('p');
            p.className = "list-group-item-text";
            p.appendChild(document.createTextNode(answer));
            a.appendChild(p);
        });
        var hr = document.createElement('hr');
        a.appendChild(hr);

        return a;
    }
</script>
</body>
</html>