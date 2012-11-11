<%@ page import="com.recommender.domain.Application" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
        google.load("visualization", "1", {packages:["corechart"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
        <g:each in="${appStats?.sort{it.name}}" var="applicationStatsDto" status="i">
            var applicationStatsDtoData${i} = google.visualization.arrayToDataTable([
                ['Target', 'Total Weightages'],
                ["Saved Hits", ${(applicationStatsDto.savedHits)?:0}],
                ["Failed Hits", ${(applicationStatsDto.failedHits)?:0}],
                ["Received Hits", ${(applicationStatsDto.receivedHits)?:0}]

            ]);
            var applicationStatsDtoOptions${i} = {
                title:'${applicationStatsDto.name} app activities'
            };
            var applicationStatsDtoChart${i} = new google.visualization.PieChart(document.getElementById('chart_div${i}'));
            applicationStatsDtoChart${i}.draw(applicationStatsDtoData${i}, applicationStatsDtoOptions${i});
        </g:each>
        }
    </script>
</head>

<body>
<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h1>Statistics</h1>
    </div>

    <div class="block_content">
        <g:each in="${appStats?.sort {it.name}}" var="applicationStatsDto" status="i">
            <g:if test="${applicationStatsDto?.totalHits()}">
                <div style="border-bottom: 1px dotted gray;margin-left: 3px;">
                    <div id="chart_div${i}">

                    </div>

                    <div style="margin-left: 20px;">
                        App key : <g:link controller="application" action="show">${applicationStatsDto.id}</g:link><br/>
                        App secretKey : ${applicationStatsDto.secretKey}

                    </div>
                </div>
            </g:if>

        </g:each>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>
</div>
</body>
</html>
