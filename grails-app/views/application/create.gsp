<%@ page import="com.recommender.domain.Application" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'application.label', default: 'Application')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>

<body>
<div class="block">
    <div class="block_head">
        <div class="bheadl"></div>

        <div class="bheadr"></div>

        <h1>Create Application</h1>
    </div>

    <div class="block_content">
        <g:hasErrors bean="${applicationInstance}">
            <div class="error-msg custom-msg">
                <g:renderErrors bean="${applicationInstance}"/>
            </div>
        </g:hasErrors>
        <g:form action="save">
            <table cellpadding="0" cellspacing="0" width="100%">
                <tbody>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="name"><g:message code="application.name.label"
                                                     default="Application Name"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'name', 'errors')}">
                        <g:textField name="name" value="${applicationInstance?.name}"/>
                    </td>
                </tr>
                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="algorithm"><g:message code="application.algorithm.label"
                                                          default="Algorithm"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'algorithm', 'errors')}">
                        <g:select name="algorithm" from="${com.recommender.enums.AlgorithmType?.list()}"
                                  keys="${com.recommender.enums.AlgorithmType?.list()*.name()}"
                                  value="${applicationInstance?.algorithm?.name()}"/>
                    </td>
                </tr>

                <tr class="prop">
                    <td valign="top" class="name">
                        <label for="secretKey"><g:message code="application.secretKey.label"
                                                          default="Secret Key"/></label>
                    </td>
                    <td valign="top"
                        class="value ${hasErrors(bean: applicationInstance, field: 'secretKey', 'errors')}">
                        ${applicationInstance?.secretKey}<g:hiddenField name="secretKey"
                                                                        value="${applicationInstance?.secretKey}"/>
                    </td>
                </tr>
                <g:hiddenField name="user.id" value="${com.recommender.domain.User.list()?.first()?.id}"/>
                </tbody>
            </table>

            <div class="buttons">
                <span class="button"><g:submitButton name="create" class="submit small"
                                                     value="${message(code: 'default.button.create.label', default: 'Create')}"/></span>
            </div>
        </g:form>
    </div>

    <div class="bendl"></div>

    <div class="bendr"></div>
</div>
</body>
</html>
