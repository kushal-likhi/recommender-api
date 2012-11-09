<%@ page import="com.recommender.domain.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h2><g:message code="default.show.label" args="[entityName]"/></h2>
        <ul>
            <li><g:link class="create" action="create">Add User</g:link></li>
        </ul>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="user.applications.label" default="Applications"/></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${userInstance.applications}" var="a">
                            <li><g:link controller="application" action="show"
                                        id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="user.email.label" default="Email"/></td>

                <td valign="top" class="value">${fieldValue(bean: userInstance, field: "email")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="user.enabled.label" default="Enabled"/></td>

                <td valign="top" class="value"><g:formatBoolean boolean="${userInstance?.enabled}"/></td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="user.firstName.label" default="First Name"/></td>

                <td valign="top" class="value">${fieldValue(bean: userInstance, field: "firstName")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="user.lastName.label" default="Last Name"/></td>

                <td valign="top" class="value">${fieldValue(bean: userInstance, field: "lastName")}</td>

            </tr>

            </tbody>
        </table>

        <div class="buttons">
            <p>
                <g:form>
                    <g:hiddenField name="id" value="${userInstance?.id}"/>
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
