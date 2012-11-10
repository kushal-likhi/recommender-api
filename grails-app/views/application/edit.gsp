<%@ page import="com.recommender.domain.Application" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>
    <title><g:message code="default.edit.label" args="[entityName]"/></title>
</head>

<body>
<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h2><g:message code="default.create.label" args="[entityName]"/></h2>
    </div>

    <div class="block_content">
        <g:hasErrors bean="${applicationInstance}">
            <div class="error-msg custom-msg">
                <g:renderErrors bean="${applicationInstance}"/>
            </div>
        </g:hasErrors>
        <g:form method="post">
            <g:hiddenField name="id" value="${applicationInstance?.id}"/>
            <g:hiddenField name="version" value="${applicationInstance?.version}"/>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="algorithm"><g:message code="application.algorithm.label"
                                                          default="Algorithm"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'algorithm', 'errors')}">
                        <g:select name="algorithm" from="${com.recommender.enums.AlgorithmType?.values()}"
                                  keys="${com.recommender.enums.AlgorithmType?.values()*.name()}"
                                  value="${applicationInstance?.algorithm?.name()}"/>
                    </td>
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
                                <li><g:link controller="failedData" action="show"
                                            id="${f.id}">${f?.encodeAsHTML()}</g:link></li>
                            </g:each>
                        </ul>
                        <g:link controller="failedData" action="create"
                                params="['application.id': applicationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'failedData.label', default: 'FailedData')])}</g:link>

                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secretKey"><g:message code="application.secretKey.label"
                                                          default="Secret Key"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'secretKey', 'errors')}">
                        <g:textField name="secretKey" value="${applicationInstance?.secretKey}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="user"><g:message code="application.user.label" default="User"/></label>
                    </td>
                    <td valign="top" class="value ${hasErrors(bean: applicationInstance, field: 'user', 'errors')}">
                        <g:select name="user.id" from="${com.recommender.domain.User.list()}" optionKey="id"
                                  value="${applicationInstance?.user?.id}"/>
                    </td>
                </tr>

                </tbody>
            </table>

            <div class="buttons">
                <span class="button"><g:actionSubmit class="submit small" action="update"
                                                     value="${message(code: 'default.button.update.label', default: 'Update')}"/></span>
                <span class="button"><g:actionSubmit class="submit small" action="delete"
                                                     value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                                     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
            </div>

            <div class="bendl"></div>

            <div class="bendr"></div>
        </g:form>
    </div>
</div>
</div>
</body>
</html>
