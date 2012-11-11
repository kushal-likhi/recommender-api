<%@ page import="com.recommender.domain.Application" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>
    <title><g:message code="default.show.label" args="[applicationInstance?.name]"/></title>
    <g:if test="${statsDataMap}">
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            google.load("visualization", "1", {packages:["corechart"]});
            google.setOnLoadCallback(drawChart);
            function drawChart() {
                var data = google.visualization.arrayToDataTable([
                    ['Target', 'Total Weightages']
                    <g:each in="${statsDataMap}" status="i" var="map">
                    ,
                    ["${map.key}", ${map.value}]
                    </g:each>
                ]);

                var options = {
                    title:'${applicationInstance.name} Activities'
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
                chart.draw(data, options);
            }
        </script>
    </g:if>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h1>${applicationInstance?.name}</h1>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody>

            <g:isAdmin>
                <tr class="prop">
                    <td valign="top" class="name"><g:message code="application.user.label" default="User"/></td>

                    <td valign="top" class="value"><g:link controller="user" action="show"
                                                           id="${applicationInstance?.user?.id}">${applicationInstance?.user?.name}</g:link></td>

                </tr>
            </g:isAdmin>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.name.label" default="Name"/></td>

                <td valign="top" class="value">${applicationInstance?.name}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.appKey.label" default="App Key"/></td>

                <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "id")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.algorithm.label" default="Algorithm"/></td>

                <td valign="top" class="value">${applicationInstance?.algorithm?.toString()}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.secretKey.label" default="Secret Key"/></td>

                <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "secretKey")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name">
                    <label for="failedEntries"><g:message code="application.failedEntries.label"
                                                          default="Failed Entries"/></label>
                </td>
                <td valign="top"
                    class="value ${hasErrors(bean: applicationInstance, field: 'failedEntries', 'errors')}">

                    <ul>
                        <g:each in="${applicationInstance?.failedEntries ?}" var="f">
                            <li>${f?.toString()}</li>
                        </g:each>
                    </ul>
                </td>
            </tr>

            </tbody>
        </table>
        <g:if test="${statsDataMap}">
            <div id="chart_div" style="width: 900px; height: 500px;">
            </div>
        </g:if>
        <g:else>
            <div style="margin-left: 40px;margin-bottom: 10px">
                No Data Available
            </div>
        </g:else>

        <div class="buttons">
            <p>
                <g:form>
                    <g:hiddenField name="id" value="${applicationInstance?.id}"/>
                    <span class="button"><g:actionSubmit class="submit small" action="edit"
                                                         value="${message(code: 'default.button.edit.label', default: 'Edit')}"/></span>
                    <span class="button"><g:actionSubmit class="submit small" action="delete"
                                                         value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                         onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                </g:form>
            </p>
        </div>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>

</div>
</body>
</html>
