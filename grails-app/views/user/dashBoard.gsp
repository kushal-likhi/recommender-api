<%@ page import="com.recommender.domain.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title>Dashboard</title>
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">
        google.load("visualization", "1", {packages:["corechart"]});
        google.setOnLoadCallback(drawChart);
        function drawChart() {
            var wholeApplsStatsData = google.visualization.arrayToDataTable([
                ['Target', 'Total Weightages']
                <g:each in="${wholeApplsStats}" status="i" var="map">
                ,
                ["${map.key}", ${map.value}]
                </g:each>
            ]);

            var wholeApplsStatsOptions = {
                title:'Your total activities'
            };
            var wholeApplsStatsChart = new google.visualization.PieChart(document.getElementById('chart_div_Apps_stats'));
            wholeApplsStatsChart.draw(wholeApplsStatsData, wholeApplsStatsOptions);

        %{--------------Whole App Compare Chart----------------------------------------}%

            var wholeApplsCompareStatsData = google.visualization.arrayToDataTable([
                ['Target', 'Total Weightages']
                <g:each in="${wholeAppsComapreStats}" status="i" var="map">
                ,
                ["${map.key}", ${map.value}]
                </g:each>
            ]);

            var wholeApplsCompareStatsOptions = {
                title:'Your Apps activities'
            };
            var wholeApplsCompareStatsChart = new google.visualization.PieChart(document.getElementById('chart_div_Whole_Compare'));
            wholeApplsCompareStatsChart.draw(wholeApplsCompareStatsData, wholeApplsCompareStatsOptions);
        }
    </script>
</head>

<body>
<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>
    </div>

    <div class="block_content">
        <div id="chart_div_Apps_stats" style="border-bottom: 1px dotted gray;">

        </div>

        <div id="chart_div_Whole_Compare">

        </div>

    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>
</div>
</body>
</html>
