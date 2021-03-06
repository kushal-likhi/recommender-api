<%@ page import="com.recommender.domain.Application" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h1>Applications</h1>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <thead>
            <tr>
                <g:sortableColumn property="algorithm"
                                  title="${message(code: 'application.name.label', default: 'Name')}"/>
                <g:sortableColumn property="id"
                                  title="${message(code: 'application.appKey.label', default: 'App Key')}"/>
                <g:sortableColumn property="algorithm"
                                  title="${message(code: 'application.algorithm.label', default: 'Algorithm')}"/>

                <g:sortableColumn property="secretKey"
                                  title="${message(code: 'application.secretKey.label', default: 'Secret Key')}"/>
                <g:isAdmin>
                    <th><g:message code="application.user.label" default="User"/></th>
                </g:isAdmin>
            </tr>
            </thead>
            <tbody>
            <g:each in="${applicationInstanceList}" status="i" var="applicationInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                    <td><g:link action="show"
                                id="${applicationInstance.id}">${fieldValue(bean: applicationInstance, field: "name")}</g:link></td>
                    <td>${fieldValue(bean: applicationInstance, field: "id")}</td>
                    <td>${fieldValue(bean: applicationInstance, field: "algorithm")}</td>

                    <td>${fieldValue(bean: applicationInstance, field: "secretKey")}</td>

                    <g:isAdmin>
                        <td><g:link controller="user" action="show"
                                    id="${applicationInstance?.user?.id}">${applicationInstance?.user?.name}</g:link></td>
                    </g:isAdmin>
                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pagination right">
            <g:paginate total="${applicationInstanceTotal}"/>
        </div>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>

</div>
</body>
</html>
