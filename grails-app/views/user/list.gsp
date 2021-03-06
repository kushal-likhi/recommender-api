<%@ page import="com.recommender.domain.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <ul>
            <li><g:link class="create" action="create">Create User</g:link></li>
        </ul>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <thead>
            <tr>

                <g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}"/>

                <g:sortableColumn property="enabled"
                                  title="${message(code: 'user.enabled.label', default: 'Enabled')}"/>

                <g:sortableColumn property="firstName"
                                  title="${message(code: 'user.firstName.label', default: 'First Name')}"/>

                <g:sortableColumn property="lastName"
                                  title="${message(code: 'user.lastName.label', default: 'Last Name')}"/>

            </tr>
            </thead>
            <tbody>
            <g:each in="${userInstanceList}" status="i" var="userInstance">
                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

                    <td><g:link action="show"
                                id="${userInstance.id}">${fieldValue(bean: userInstance, field: "email")}</g:link></td>

                    <td><g:formatBoolean boolean="${userInstance.enabled}"/></td>

                    <td>${fieldValue(bean: userInstance, field: "firstName")}</td>

                    <td>${fieldValue(bean: userInstance, field: "lastName")}</td>

                </tr>
            </g:each>
            </tbody>
        </table>

        <div class="pagination right">
            <g:paginate total="${userInstanceTotal}"/>
        </div>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>

</div>
</body>
</html>
