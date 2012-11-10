<%@ page import="com.recommender.domain.FailedData" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'failedData.label', default: 'FailedData')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h2><g:message code="default.list.label" args="[entityName]"/></h2>

        <ul>
            <li><g:link class="create" action="create">Add FailedData</g:link></li>
        </ul>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <thead>
            <tr>

                <th><g:message code="failedData.application.label" default="Application"/></th>

                <g:sortableColumn property="eventSource"
                                  title="${message(code: 'failedData.eventSource.label', default: 'Event Source')}"/>

                <g:sortableColumn property="eventTarget"
                                  title="${message(code: 'failedData.eventTarget.label', default: 'Event Target')}"/>

                <g:sortableColumn property="reason"
                                  title="${message(code: 'failedData.reason.label', default: 'Reason')}"/>

                <g:sortableColumn property="weight"
                                  title="${message(code: 'failedData.weight.label', default: 'Weight')}"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${failedDataInstanceList}" status="i" var="failedDataInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${failedDataInstance.id}">${fieldValue(bean: failedDataInstance, field: "application")}</g:link></td>

                    <td>${fieldValue(bean: failedDataInstance, field: "eventSource")}</td>

                    <td>${fieldValue(bean: failedDataInstance, field: "eventTarget")}</td>

                    <td>${fieldValue(bean: failedDataInstance, field: "reason")}</td>

                    <td>${fieldValue(bean: failedDataInstance, field: "weight")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pagination right">
            <g:paginate total="${failedDataInstanceTotal}"/>
        </div>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>

</div>
</body>
</html>
