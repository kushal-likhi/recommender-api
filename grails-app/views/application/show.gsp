<%@ page import="com.recommender.domain.Application" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>
    <title><g:message code="default.show.label" args="[entityName]"/></title>
</head>

<body>

<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h2><g:message code="default.show.label" args="[entityName]"/></h2>
        <ul>
            <li><g:link class="create" action="create">Add Application</g:link></li>
        </ul>
    </div>

    <div class="block_content">
        <table cellpadding="0" cellspacing="0" width="100%">
            <tbody>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.algorithm.label" default="Algorithm"/></td>

                <td valign="top" class="value">${applicationInstance?.algorithm?.encodeAsHTML()}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.failedEntries.label"
                                                         default="Failed Entries"/></td>

                <td valign="top" style="text-align: left;" class="value">
                    <ul>
                        <g:each in="${applicationInstance.failedEntries}" var="f">
                            <li><g:link controller="failedData" action="show"
                                        id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                        </g:each>
                    </ul>
                </td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.secretKey.label" default="Secret Key"/></td>

                <td valign="top" class="value">${fieldValue(bean: applicationInstance, field: "secretKey")}</td>

            </tr>

            <tr class="prop">
                <td valign="top" class="name"><g:message code="application.user.label" default="User"/></td>

                <td valign="top" class="value"><g:link controller="user" action="show"
                                                       id="${applicationInstance?.user?.id}">${applicationInstance?.user?.encodeAsHTML()}</g:link></td>

            </tr>

            </tbody>
        </table>

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
